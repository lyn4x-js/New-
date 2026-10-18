-- Minecraft Textures | Standalone V1 for iPad / Delta
-- Based on the supplied Minecraft textures.json.
-- The source's ambience rule has no with_id: this implementation mutes matching sounds.
-- Best effort: works only for accessible instances and supported executor functions.
local Players = game:GetService('Players')
local player = Players.LocalPlayer
local URL = 'https://raw.githubusercontent.com/66buncer/Rivals-Pack-Assets/main/item_slot_3_blue_hollow.png'
local TARGET = '7658055825'
local MUTE_IDS = {['17813065011']=true, ['17813065464']=true, ['12099785239']=true}
local KEY = '__MINECRAFT_TEXTURES_IPAD_ADAPTIVE_V1'
local env = (getgenv and getgenv()) or _G
if env[KEY] and env[KEY].close then pcall(env[KEY].close) end
local active, saved, connection, gui, asset, statusLabel = false, {}, nil, nil, nil, nil
local PROPERTIES = {Decal={'Texture'}, Texture={'Texture'}, MeshPart={'TextureID'}, SpecialMesh={'TextureId'}, SurfaceAppearance={'ColorMap'}}
local function status(message)
    if statusLabel then statusLabel.Text = message end
    print('[Minecraft Textures] '..message)
end
local function assetId(value)
    if type(value) ~= 'string' then return nil end
    return value:match('(%d+)%D*$')
end
local function remember(obj, prop, value)
    saved[obj] = saved[obj] or {}
    if saved[obj][prop] == nil then saved[obj][prop] = value end
end
local function update(obj)
    if not active then return end
    if obj:IsA('Sound') then
        local ok, soundId = pcall(function() return obj.SoundId end)
        if ok and MUTE_IDS[assetId(soundId)] then
            local volumeOk, volume = pcall(function() return obj.Volume end)
            if volumeOk then
                remember(obj, 'Volume', volume)
                pcall(function() obj.Volume = 0 end)
            end
        end
        return
    end
    local props = PROPERTIES[obj.ClassName]
    if not props or not asset then return end
    for _,prop in ipairs(props) do
        local ok, old = pcall(function() return obj[prop] end)
        if ok and assetId(old) == TARGET then
            remember(obj, prop, old)
            pcall(function() obj[prop] = asset end)
        end
    end
end
local function fetch()
    if asset then return true end
    if type(writefile) ~= 'function' or type(getcustomasset) ~= 'function' then
        status('Texture needs Delta writefile + getcustomasset; not supported here')
        return false
    end
    local ok, err = pcall(function()
        local data = game:HttpGet(URL)
        assert(type(data) == 'string' and #data > 100, 'Image download was empty')
        local path = 'Minecraft_Textures_V1.png'
        writefile(path, data)
        asset = getcustomasset(path)
        assert(type(asset) == 'string' and #asset > 0, 'Custom asset unavailable')
    end)
    if not ok then status('Image load failed: '..tostring(err)); return false end
    return true
end
local function remove()
    active = false
    if connection then connection:Disconnect(); connection = nil end
    local restored = 0
    for obj,props in pairs(saved) do
        if obj and obj.Parent then
            for prop,original in pairs(props) do
                if pcall(function() obj[prop] = original end) then restored = restored + 1 end
            end
        end
    end
    saved = {}
    status('Removed; restored '..restored..' properties')
end
local function apply()
    if active then status('Already active'); return end
    status('Downloading Minecraft texture...')
    if not fetch() then return end
    active = true
    local count = 0
    for _,obj in ipairs(game:GetDescendants()) do
        update(obj)
    end
    for _,props in pairs(saved) do
        for _ in pairs(props) do count = count + 1 end
    end
    connection = game.DescendantAdded:Connect(function(obj)
        if active then task.defer(update, obj) end
    end)
    status('Applied to '..count..' properties'..(count == 0 and ' (no matching IDs found)' or ''))
end
local function close()
    remove()
    if gui then gui:Destroy(); gui = nil end
    env[KEY] = nil
end
env[KEY] = {close=close, remove=remove}
local parent = (gethui and gethui()) or player:WaitForChild('PlayerGui')
gui = Instance.new('ScreenGui')
gui.Name = 'MinecraftTexturesStandaloneV1'
gui.ResetOnSpawn = false
gui.Parent = parent
local frame = Instance.new('Frame')
frame.Size = UDim2.fromOffset(295, 176)
frame.Position = UDim2.new(0.5, -147, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(23, 25, 23)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new('UICorner', frame).CornerRadius = UDim.new(0, 12)
local title = Instance.new('TextLabel')
title.Size = UDim2.new(1, -42, 0, 40)
title.Position = UDim2.fromOffset(12, 2)
title.BackgroundTransparency = 1
title.Text = 'MINECRAFT TEXTURES  |  V1'
title.TextColor3 = Color3.fromRGB(132, 225, 115)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local function button(label, x, y, w, fn)
    local b = Instance.new('TextButton')
    b.Size = UDim2.fromOffset(w, 38)
    b.Position = UDim2.fromOffset(x, y)
    b.BackgroundColor3 = Color3.fromRGB(47, 78, 47)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Text = label
    b.Parent = frame
    Instance.new('UICorner', b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(fn)
end
button('APPLY', 12, 53, 130, apply)
button('REMOVE', 152, 53, 130, remove)
button('X', 261, 7, 25, close)
statusLabel = Instance.new('TextLabel')
statusLabel.Size = UDim2.new(1, -24, 0, 65)
statusLabel.Position = UDim2.fromOffset(12, 103)
statusLabel.BackgroundTransparency = 1
statusLabel.TextWrapped = true
statusLabel.TextColor3 = Color3.fromRGB(215, 225, 215)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = 'Ready | Texture + mute map ambience'
statusLabel.Parent = frame
