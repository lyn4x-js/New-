-- Flow Textures | Standalone V1
-- Based on user-provided Flow textures.json
-- Client-side visual replacement. Requires executor support for writefile and getcustomasset.
local Players = game:GetService('Players')
local player = Players.LocalPlayer
local URL = 'https://raw.githubusercontent.com/Prlngzz/Prlngzz-Textures/main/FLow%20Textures.png'
local TARGET = '7658055825'
local KEY = '__FLOW_TEXTURES_IPAD_ADAPTIVE_V1'
local env = (getgenv and getgenv()) or _G
if env[KEY] and env[KEY].close then pcall(env[KEY].close) end
local active, saved, added, gui = false, {}, nil, nil
local asset, statusLabel
local function status(msg)
    if statusLabel then statusLabel.Text = msg end
    print('[Flow Textures] '..msg)
end
local function matches(s)
    return type(s) == 'string' and s:find(TARGET, 1, true) ~= nil
end
local PROPERTIES = {Decal={'Texture'}, Texture={'Texture'}, MeshPart={'TextureID'}, SpecialMesh={'TextureId'}, SurfaceAppearance={'ColorMap'}}
local function replace(obj)
    if not active or not asset then return end
    local props = PROPERTIES[obj.ClassName]
    if not props then return end
    for _,prop in ipairs(props) do
        local ok, old = pcall(function() return obj[prop] end)
        if ok and matches(old) then
            saved[obj] = saved[obj] or {}
            if saved[obj][prop] == nil then saved[obj][prop] = old end
            pcall(function() obj[prop] = asset end)
        end
    end
end
local function fetch()
    if asset then return true end
    if type(writefile) ~= 'function' or type(getcustomasset) ~= 'function' then
        status('Delta needs writefile + getcustomasset for CDN textures')
        return false
    end
    local ok, err = pcall(function()
        local data = game:HttpGet(URL)
        assert(type(data) == 'string' and #data > 100, 'Empty image download')
        local path = 'Flow_Textures_V1.png'
        writefile(path, data)
        asset = getcustomasset(path)
        assert(type(asset) == 'string' and #asset > 0, 'Custom asset unavailable')
    end)
    if not ok then status('Image load failed: '..tostring(err)); return false end
    return true
end
local function remove()
    active = false
    if added then added:Disconnect(); added = nil end
    local count = 0
    for obj, props in pairs(saved) do
        if obj and obj.Parent then
            for prop,old in pairs(props) do
                if pcall(function() obj[prop] = old end) then count = count + 1 end
            end
        end
    end
    saved = {}
    status('Removed; restored '..count..' properties')
end
local function apply()
    if active then status('Already active'); return end
    status('Downloading Hello Kitty texture...')
    if not fetch() then return end
    active = true
    local count = 0
    for _,obj in ipairs(game:GetDescendants()) do
        local props = PROPERTIES[obj.ClassName]
        if props then
            for _,prop in ipairs(props) do
                local ok, value = pcall(function() return obj[prop] end)
                if ok and matches(value) then count = count + 1 end
            end
            replace(obj)
        end
    end
    added = game.DescendantAdded:Connect(function(obj)
        if active then task.defer(replace, obj) end
    end)
    status('Applied to '..count..' matching properties'..(count == 0 and ' (no matching ID found)' or ''))
end
local function close()
    remove()
    if gui then gui:Destroy(); gui = nil end
    env[KEY] = nil
end
env[KEY] = {close=close}
local parent = (gethui and gethui()) or player:WaitForChild('PlayerGui')
gui = Instance.new('ScreenGui')
gui.Name = 'FlowTexturesStandaloneV1'
gui.ResetOnSpawn = false
gui.Parent = parent
local frame = Instance.new('Frame')
frame.Size = UDim2.fromOffset(275, 168)
frame.Position = UDim2.new(0.5, -137, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(23, 22, 29)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new('UICorner', frame).CornerRadius = UDim.new(0, 12)
local title = Instance.new('TextLabel')
title.Size = UDim2.new(1, -35, 0, 40)
title.Position = UDim2.fromOffset(12, 2)
title.BackgroundTransparency = 1
title.Text = 'FLOW TEXTURES  |  V1'
title.TextColor3 = Color3.fromRGB(255, 170, 80)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local function button(label, x, y, w, fn)
    local b = Instance.new('TextButton')
    b.Size = UDim2.fromOffset(w, 38)
    b.Position = UDim2.fromOffset(x, y)
    b.BackgroundColor3 = Color3.fromRGB(61, 48, 70)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Text = label
    b.Parent = frame
    Instance.new('UICorner', b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(fn)
end
button('APPLY', 12, 53, 120, apply)
button('REMOVE', 142, 53, 120, remove)
button('X', 242, 7, 24, close)
statusLabel = Instance.new('TextLabel')
statusLabel.Size = UDim2.new(1, -24, 0, 56)
statusLabel.Position = UDim2.fromOffset(12, 103)
statusLabel.BackgroundTransparency = 1
statusLabel.TextWrapped = true
statusLabel.TextColor3 = Color3.fromRGB(215, 210, 225)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = 'Ready | Target ID: '..TARGET
statusLabel.Parent = frame
