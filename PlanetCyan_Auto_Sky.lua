-- PlanetCyan Auto Sky for Roblox / Delta
-- Reuses six PNGs already hosted in lyn4x-js/New-.
-- Local visual modification only. Re-run after a full app restart.

local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local BASE = "https://raw.githubusercontent.com/lyn4x-js/New-/main/"
local SCRIPT_URL = BASE .. "PlanetCyan_Auto_Sky.lua"
local FACES = {SkyboxBk="bk",SkyboxDn="dn",SkyboxFt="ft",SkyboxLf="lf",SkyboxRt="rt",SkyboxUp="up"}

local previous = getgenv and getgenv().__PlanetCyanAutoSky
if previous and previous.stop then previous.stop() end

local state = {running=true, connections={}, assets={}, applying=false}
if getgenv then getgenv().__PlanetCyanAutoSky = state end

local function connect(signal, callback)
    local c = signal:Connect(callback)
    table.insert(state.connections, c)
    return c
end

function state.stop()
    state.running = false
    for _,c in ipairs(state.connections) do pcall(function() c:Disconnect() end) end
    state.connections = {}
    print("[PlanetCyan] Auto sky stopped")
end

local assetFn = getcustomasset or getsynasset
if not (writefile and assetFn) then
    warn("[PlanetCyan] Delta must support writefile and getcustomasset/getsynasset")
    state.stop()
    return
end

for prop, suffix in pairs(FACES) do
    local filename = "PlanetCyan_" .. suffix .. ".png"
    local ok, result = pcall(function()
        local data = game:HttpGet(BASE .. filename)
        assert(type(data)=="string" and #data>100, "image download empty")
        writefile(filename, data)
        return assetFn(filename)
    end)
    if not ok then
        warn("[PlanetCyan] Failed to load " .. filename .. ": " .. tostring(result))
        state.stop()
        return
    end
    state.assets[prop] = result
end

local function apply()
    if not state.running or state.applying then return end
    state.applying = true
    local ok, err = pcall(function()
        local sky = Lighting:FindFirstChild("PlanetCyan_Auto")
        if not sky or not sky:IsA("Sky") then
            if sky then sky:Destroy() end
            sky = Instance.new("Sky")
            sky.Name = "PlanetCyan_Auto"
            sky.Parent = Lighting
        end
        for prop, asset in pairs(state.assets) do
            if sky[prop] ~= asset then sky[prop] = asset end
        end
        -- Prevent another Sky from overriding the chosen sky.
        for _,child in ipairs(Lighting:GetChildren()) do
            if child:IsA("Sky") and child ~= sky then
                child:Destroy()
            end
        end
    end)
    state.applying = false
    if not ok then warn("[PlanetCyan] Apply error: " .. tostring(err)) end
end

apply()
connect(Lighting.ChildAdded, function(child)
    if child:IsA("Sky") then task.defer(apply) end
end)
connect(Lighting.ChildRemoved, function(child)
    if child:IsA("Sky") then task.defer(apply) end
end)

-- Some games change Lighting after moving between maps or rounds.
task.spawn(function()
    while state.running do
        task.wait(2)
        apply()
    end
end)

-- Teleport persistence is executor-specific; it may not be available on iPad.
local queue = queue_on_teleport or (syn and syn.queue_on_teleport)
if type(queue)=="function" then
    pcall(function()
        queue('loadstring(game:HttpGet("' .. SCRIPT_URL .. '"))()')
        print("[PlanetCyan] Teleport reload queued")
    end)
end

print("[PlanetCyan] Auto sky active; checking every 2 seconds")
