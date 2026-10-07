-- SKYY2 Fresh Sky V2 - iPad / Delta
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local env = (getgenv and getgenv()) or _G
local getasset = getcustomasset or getsynasset

if not writefile or not getasset then
    warn("[SKYY2 V2] missing writefile/getcustomasset")
    return
end

local KEY = "__SKYY2_FRESH_SKY_V2"

if env[KEY] and env[KEY].connections then
    for _, c in ipairs(env[KEY].connections) do
        pcall(function() c:Disconnect() end)
    end
end

local state = {connections = {}, running = true}
env[KEY] = state

local function keep(c)
    if c then table.insert(state.connections, c) end
end

local urls = {
    Bk = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/back.tex",
    Dn = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/down.tex",
    Ft = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/front.tex",
    Lf = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/left.tex",
    Rt = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/right.tex",
    Up = "https://raw.githubusercontent.com/leitopatatua-lab/SKYY2/main/up.tex"
}

local assets = {}

for face, url in pairs(urls) do
    local ok, data = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok or type(data) ~= "string" or #data < 50 then
        warn("[SKYY2 V2] download failed " .. face)
        return
    end

    local file = "skyy2_" .. face .. ".tex"

    if not pcall(function()
        writefile(file, data)
    end) then
        warn("[SKYY2 V2] write failed " .. face)
        return
    end

    local ok2, asset = pcall(function()
        return getasset(file)
    end)

    if not ok2 or not asset then
        warn("[SKYY2 V2] asset failed " .. face)
        return
    end

    assets[face] = asset
end

local creating = false

local function fresh()
    if creating then return end
    creating = true

    for _, x in ipairs(Lighting:GetChildren()) do
        if x:IsA("Sky") then
            pcall(function() x:Destroy() end)
        end
    end

    local s = Instance.new("Sky")
    s.Name = "SKYY2FreshSky"
    s.SkyboxBk = assets.Bk
    s.SkyboxDn = assets.Dn
    s.SkyboxFt = assets.Ft
    s.SkyboxLf = assets.Lf
    s.SkyboxRt = assets.Rt
    s.SkyboxUp = assets.Up
    s.Parent = Lighting

    creating = false
end

fresh()

for _, t in ipairs({0.5, 1.5, 3, 6, 10}) do
    task.delay(t, fresh)
end

local last = 0

keep(Lighting.ChildAdded:Connect(function(x)
    if x:IsA("Sky") and x.Name ~= "SKYY2FreshSky" then
        local now = os.clock()
        if now - last > 0.5 then
            last = now
            task.delay(0.15, fresh)
        end
    end
end))

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "SKYY2 Fresh Sky V2",
        Text = "Fresh Sky loaded",
        Duration = 6
    })
end)
