-- Shades Texture Pack | converted from supplied JSON
-- CDN textures and Roblox asset-ID replacements. No sky changes.
local env = (getgenv and getgenv()) or _G
local KEY = "__SHADES_TEXTURE_PACK_V1"
if env[KEY] and env[KEY].connection then pcall(function() env[KEY].connection:Disconnect() end) end
local state = {}
env[KEY] = state
local assetFn = getcustomasset or getsynasset
local replacements = {}
local function assetId(v) return "rbxassetid://" .. tostring(v) end
replacements["18525513345"] = assetId(128891284954593) -- Matchmaking bell
replacements["16737738420"] = assetId(103374393698378) -- Slide
replacements["14147881792"] = assetId(18703245834) -- Profile 1
replacements["14147882149"] = assetId(18703243349) -- Profile 2
replacements["14147882761"] = assetId(18703240532) -- Profile 3
replacements["14147883091"] = assetId(18703237556) -- Profile 4
replacements["14147882405"] = assetId(18703235430) -- Profile 5
replacements["14147881297"] = assetId(18703232671) -- Profile 6
local function download(url, filename)
    if type(writefile) ~= "function" or type(assetFn) ~= "function" then return nil end
    local ok, data = pcall(function() return game:HttpGet(url) end)
    if not ok or type(data) ~= "string" or #data < 40 then warn("[Shades] Download failed: " .. filename); return nil end
    if not pcall(writefile, filename, data) then return nil end
    local good, result = pcall(assetFn, filename)
    if good and type(result) == "string" then return result end
end
do -- Textures
    local asset = download("https://github.com/TexPackSearcher/crispy-adventure/blob/main/Gemini_Generated_Image_8otz3o8otz3o8otz-removebg-preview%20(1).webp?raw=true", "shades_texture_1.webp")
    if asset then
        replacements["7658055825"] = asset
    end
end
do -- cAT
    local asset = download("https://github.com/TexPackSearcher/upgraded-invention/blob/main/image-removebg-preview%20(26).png?raw=true", "shades_texture_2.png")
    if asset then
        replacements["121503061771505"] = asset
        replacements["133917828562858"] = asset
    end
end
do -- pbj
    local asset = download("https://github.com/TexPackSearcher/urban-octo-fortnight/blob/main/image-removebg-preview%20(23).png?raw=true", "shades_texture_3.png")
    if asset then
        replacements["13854780213"] = asset
    end
end
local properties = {"Texture", "TextureID", "Image", "SoundId", "MeshId"}
local function apply(obj)
    for _, property in ipairs(properties) do
        local ok, value = pcall(function() return obj[property] end)
        if ok and type(value) == "string" then
            local id = value:match("(%d+)")
            local new = id and replacements[id]
            if new and new ~= value then pcall(function() obj[property] = new end) end
        end
    end
end
for i, obj in ipairs(game:GetDescendants()) do
    apply(obj)
    if i % 300 == 0 then task.wait() end
end
state.connection = game.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if env[KEY] == state and obj.Parent then apply(obj) end
    end)
end)
print("[Shades] Loaded texture and sound ID replacements. Rules without a target or local font file were skipped.")
