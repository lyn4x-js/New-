-- LINE TEXTURES | texture-only Lua loader
-- Converted from the supplied Line textures.json configuration.
-- Replaces asset ID 7658055825 with the supplied GitHub image.

local SOURCE_URL = 'https://raw.githubusercontent.com/SonicJimYT/Soinc/main/Textures.png'
local TARGET_ID = '7658055825'
local LOCAL_FILE = 'line_textures_pack.png'
local PREFIX = '[Line Textures] '

local env = (type(getgenv) == 'function' and getgenv()) or _G
local write = (env and env.writefile) or writefile
local custom = (env and env.getcustomasset) or getcustomasset or (env and env.getsynasset) or getsynasset

if type(write) ~= 'function' or type(custom) ~= 'function' then
    warn(PREFIX .. 'This environment needs writefile and getcustomasset support.')
    return
end

local ok, replacement = pcall(function()
    local data = game:HttpGet(SOURCE_URL)
    assert(type(data) == 'string' and #data > 100, 'Image download returned no valid data')
    write(LOCAL_FILE, data)
    return custom(LOCAL_FILE)
end)
if not ok or type(replacement) ~= 'string' then
    warn(PREFIX .. 'Could not load texture: ' .. tostring(replacement))
    return
end

local properties = {'Texture', 'TextureID', 'Image'}
local changed = 0
local seen = setmetatable({}, {__mode='k'})

local function matches(value)
    if type(value) ~= 'string' then return false end
    -- Match a complete asset ID, not a substring of another ID.
    for number in value:gmatch('%d+') do
        if number == TARGET_ID then return true end
    end
    return false
end

local function apply(object)
    if seen[object] then return end
    local replaced = false
    for _, property in ipairs(properties) do
        local got, value = pcall(function() return object[property] end)
        if got and matches(value) then
            local success = pcall(function() object[property] = replacement end)
            if success then
                changed = changed + 1
                replaced = true
            end
        end
    end
    if replaced then seen[object] = true end
end

for _, object in ipairs(game:GetDescendants()) do
    apply(object)
end

game.DescendantAdded:Connect(function(object)
    task.defer(function()
        if object.Parent then apply(object) end
    end)
end)

print(PREFIX .. 'Loaded. Properties replaced: ' .. changed .. '. Watching new objects.')
if changed == 0 then
    warn(PREFIX .. 'No matching loaded texture found. Game may use other asset IDs or non-exposed textures.')
end
