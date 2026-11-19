-- LYN4X ARENA V1 - Texture only, adaptive replacement
-- Adapted from the texture scanning approach of DEATH_NOTE_iPad_Adaptive_AllInOne_V1.lua
-- No skybox, sounds, music, fonts, or other graphics are modified.

local PREFIX = '[LYN4X Arena] '
local env = (getgenv and getgenv()) or _G
local write = (env and env.writefile) or writefile
local custom = (env and env.getcustomasset) or getcustomasset or getsynasset
if type(write) ~= 'function' or type(custom) ~= 'function' then
    warn(PREFIX .. 'writefile/getcustomasset not available')
    return
end

local KEY = '__LYN4X_ARENA_TEXTURE_ONLY_V2'
if env[KEY] and env[KEY].connections then
    for _, c in ipairs(env[KEY].connections) do pcall(function() c:Disconnect() end) end
end
local state = {connections = {}, running = true, changed = 0}
env[KEY] = state

local URL = 'https://raw.githubusercontent.com/lyn4x-js/New-/main/LYN4X_ARENA_V1.png'
local FILE = 'lyn4x_arena_v1_texture.png'
local TARGET = '7658055825'
local ok, asset = pcall(function()
    local bytes = game:HttpGet(URL)
    if type(bytes) ~= 'string' or #bytes < 100 then error('PNG download empty or invalid') end
    if bytes:sub(1, 8) ~= '\137PNG\r\n\26\n' then error('URL did not return a PNG') end
    write(FILE, bytes)
    return custom(FILE)
end)
if not ok or type(asset) ~= 'string' then
    warn(PREFIX .. 'Could not load PNG: ' .. tostring(asset))
    return
end

local function id(value)
    if type(value) ~= 'string' then return nil end
    return value:match('rbxassetid://(%d+)')
        or value:match('[?&]id=(%d+)')
        or value:match('^(%d+)$')
end

local props = {
    ImageLabel = {'Image'}, ImageButton = {'Image'},
    Decal = {'Texture'}, Texture = {'Texture'},
    MeshPart = {'TextureID'}, SpecialMesh = {'TextureId'},
    ParticleEmitter = {'Texture'}, Trail = {'Texture'}, Beam = {'Texture'},
}

local function inspect(obj)
    for class, names in pairs(props) do
        if obj:IsA(class) then
            for _, prop in ipairs(names) do
                local readOK, old = pcall(function() return obj[prop] end)
                if readOK and id(old) == TARGET then
                    local setOK = pcall(function() obj[prop] = asset end)
                    if setOK then state.changed += 1 end
                end
            end
            break
        end
    end
end

for i, obj in ipairs(game:GetDescendants()) do
    pcall(inspect, obj)
    if i % 250 == 0 then task.wait() end
end

state.connections[#state.connections + 1] = game.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if obj.Parent then pcall(inspect, obj) end
        task.wait(.25)
        if obj.Parent then pcall(inspect, obj) end
    end)
end)

-- Re-scan for streamed-in/reloaded arena textures; never touch nonmatching IDs.
task.spawn(function()
    while state.running and env[KEY] == state do
        task.wait(8)
        for i, obj in ipairs(game:GetDescendants()) do
            pcall(inspect, obj)
            if i % 300 == 0 then task.wait() end
        end
    end
end)

print(PREFIX .. 'texture-only active; initial replacements: ' .. state.changed)
if state.changed == 0 then
    warn(PREFIX .. 'No matching texture IDs found yet. The game may use another texture ID or load arena assets later.')
end
