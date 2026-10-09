-- Vexn Miku SFX ONLY - iPad/Delta
-- Slide, normal jump and double jump use the same mario-meow audio.
-- Kill and load-in SFX are retained from the supplied JSON.
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local env = (getgenv and getgenv()) or _G
local getAsset = getcustomasset or getsynasset
if type(writefile) ~= "function" or type(getAsset) ~= "function" then
    warn("[Miku SFX] writefile/getcustomasset missing")
    return
end
local KEY = "__MIKU_VEXN_SFX_MEOW_V1"
if env[KEY] then
    env[KEY].active = false
    for _, c in ipairs(env[KEY].connections or {}) do pcall(function() c:Disconnect() end) end
end
local state = {active = true, connections = {}}
env[KEY] = state
local function keep(c) table.insert(state.connections, c) end
local function download(url, path)
    local ok, data = pcall(function() return game:HttpGet(url) end)
    if not ok or type(data) ~= "string" or #data < 32 then
        warn("[Miku SFX] Download failed: " .. path)
        return nil
    end
    local saved = pcall(writefile, path, data)
    if not saved then warn("[Miku SFX] Save failed: " .. path); return nil end
    local got, asset = pcall(getAsset, path)
    if got and type(asset) == "string" and #asset > 0 then return asset end
    warn("[Miku SFX] Custom asset failed: " .. path)
end
local meow = download("https://github.com/jadrentillo04-ai/Fleasion-/raw/refs/heads/main/mario-meow.mp3", "miku_vexn_meow_sfx_v1.mp3")
local kill = download("https://github.com/jadrentillo04-ai/Fleasion-/raw/refs/heads/main/0911.MP3", "miku_vexn_kill_sfx_v1.mp3")
local loadin = download("https://github.com/jadrentillo04-ai/miku/raw/refs/heads/main/Screen_Recording_20260927_113857~2.mp3", "miku_vexn_load_sfx_v1.mp3")
local mapping = {}
-- JSON slide (sparkle.wav) intentionally changed to the double-jump meow.
if meow then
    mapping["16737738420"] = meow -- slide
    mapping["16770456156"] = meow -- double jump
end
if kill then
    mapping["16530229616"] = kill
    mapping["16530229541"] = kill
    mapping["16530229695"] = kill
end
if loadin then mapping["6384899588"] = loadin end
local function inspect(obj)
    if not obj:IsA("Sound") then return end
    local ok, old = pcall(function() return obj.SoundId end)
    if not ok then return end
    local id = tostring(old):match("(%d+)")
    local new = id and mapping[id]
    if new then pcall(function() obj.SoundId = new end) end
end
for i, obj in ipairs(game:GetDescendants()) do
    inspect(obj)
    if i % 250 == 0 then task.wait() end
end
keep(game.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if env[KEY] == state and state.active and obj.Parent then inspect(obj) end
    end)
end))
-- The JSON has no normal-jump asset ID, so detect the local player's jump directly.
-- Avoid touching sky, textures, fonts or other visual properties.
local function attachCharacter(char)
    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 10)
    if not hum or not meow or not state.active then return end
    local last = 0
    keep(hum.Jumping:Connect(function(jumping)
        if not jumping or env[KEY] ~= state or not state.active then return end
        local now = os.clock()
        if now - last < 0.22 then return end
        last = now
        local sound = Instance.new("Sound")
        sound.Name = "MikuVexnNormalJumpMeow"
        sound.SoundId = meow
        sound.Volume = 1
        sound.Parent = SoundService
        sound.Ended:Once(function() sound:Destroy() end)
        sound:Play()
        task.delay(8, function() if sound.Parent then sound:Destroy() end end)
    end))
end
local player = Players.LocalPlayer
if player then
    if player.Character then task.spawn(attachCharacter, player.Character) end
    keep(player.CharacterAdded:Connect(attachCharacter))
end
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "Miku Vexn SFX Only",
        Text = meow and "Meow slide + normal/double jump; kill/load SFX" or "Meow download failed; check console",
        Duration = 6
    })
end)
