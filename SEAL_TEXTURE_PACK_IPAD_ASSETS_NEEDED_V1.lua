-- Seal pack (made by angl, no steal) | iPad / Delta
-- The supplied JSON references creator-local Windows files. Those files are NOT included.
-- Put the matching asset files in executor workspace/SealAssets/ before running.
-- No assets are substituted with unrelated images or audio.
local folder = "SealAssets/"
local getAsset = getcustomasset or getsynasset
if type(isfile) ~= "function" or type(getAsset) ~= "function" then
    warn("[Seal] Executor needs isfile and getcustomasset/getsynasset")
    return
end
local replacements = {}
local missing = {}
replacements["18341252690"] = "297fb2524fb2a0cbeb8a176e9a586b55.png"
replacements["24108148"] = "ChatGPT Image Sep 27, 2026, 05_38_04 PM.png"
replacements["17878306151"] = "ChatGPT Image Sep 27, 2026, 05_41_36 PM.png"
replacements["7658055825"] = "♡♡ (2).png"
replacements["133917828562858"] = "Spotty Smiling Seal Mascot.png"
replacements["13854780042"] = "Spotty Smiling Seal Mascot.png"
replacements["13854780213"] = "Spotty Smiling Seal Mascot.png"
replacements["6384899588"] = "Y2Mate.is - Ohayo gozaimasu_ - Idolmaster anime.mp3"
local assets = {}
for id, filename in pairs(replacements) do
    local path = folder .. filename
    if isfile(path) then
        local ok, value = pcall(getAsset, path)
        if ok and value then assets[id] = value else missing[filename] = true end
    else
        missing[filename] = true
    end
end
for name in pairs(missing) do warn("[Seal] Missing: " .. folder .. name) end
local function replace(value)
    if type(value) ~= "string" then return nil end
    local id = value:match("(%d+)")
    return id and assets[id] or nil
end
local function apply(obj)
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        local new = replace(obj.Image)
        if new then pcall(function() obj.Image = new end) end
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        local new = replace(obj.Texture)
        if new then pcall(function() obj.Texture = new end) end
    elseif obj:IsA("Sound") then
        local new = replace(obj.SoundId)
        if new then pcall(function() obj.SoundId = new end) end
    elseif obj:IsA("MeshPart") then
        local new = replace(obj.TextureID)
        if new then pcall(function() obj.TextureID = new end) end
    end
end
for _, obj in ipairs(game:GetDescendants()) do pcall(apply, obj) end
local env = (getgenv and getgenv()) or _G
if env.__SEAL_PACK_CONN then pcall(function() env.__SEAL_PACK_CONN:Disconnect() end) end
env.__SEAL_PACK_CONN = game.DescendantAdded:Connect(function(obj)
    task.defer(function() pcall(apply, obj) end)
end)
print("[Seal] Ready. Loaded " .. tostring(#(function() local a={} for k in pairs(assets) do a[#a+1]=k end return a end)()) .. " asset IDs.")
