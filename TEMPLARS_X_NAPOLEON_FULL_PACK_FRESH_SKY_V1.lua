-- Templars X Napoleon | iPad/Delta | CDN pack + fresh sky
-- Converted from user-provided JSON; actual behavior depends on executor and game assets.
local env = (getgenv and getgenv()) or _G
local KEY = "__TEMPLARS_NAPOLEON_V1"
if env[KEY] and env[KEY].connection then pcall(function() env[KEY].connection:Disconnect() end) end
local state = {}
env[KEY] = state
local assetFn = getcustomasset or getsynasset
local replacements = {}
local cache = {}
local function download(url, ext)
    if cache[url] then return cache[url] end
    if type(writefile) ~= "function" or type(assetFn) ~= "function" then return nil end
    local ok, data = pcall(function() return game:HttpGet(url) end)
    if not ok or type(data) ~= "string" or #data < 40 then warn("[Templars] Download failed: " .. url); return nil end
    local path = "templars_napoleon_" .. tostring(#cache + 1) .. "_" .. tostring(math.floor(os.clock()*1000)) .. "." .. ext
    if not pcall(writefile, path, data) then return nil end
    local good, asset = pcall(assetFn, path)
    if good and type(asset) == "string" then cache[url] = asset; return asset end
end
do -- Rivals Logo (change)
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/main/Logo%201.webp", "webp")
    if asset then
        replacements["17803962335"] = asset
    end
end
do -- Arena Texture
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/main/Texture1.webp", "webp")
    if asset then
        replacements["7658055825"] = asset
    end
end
do -- Fonts (Change)
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/d367c0f3add49096057e498133b0afde20303182/KnightsQuest.ttf", "ttf")
    if asset then
        replacements["12187262242"] = asset
        replacements["12187271237"] = asset
        replacements["12187280273"] = asset
        replacements["12187288714"] = asset
        replacements["12187303601"] = asset
        replacements["12187320363"] = asset
        replacements["12187323909"] = asset
        replacements["12187341020"] = asset
        replacements["12187341500"] = asset
        replacements["12187342816"] = asset
        replacements["12187354260"] = asset
    end
end
do -- Chicken > Napoleon
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/3567af72f62329c6d784bfcca7e16bdaae5eec90/napoleon.png", "png")
    if asset then
        replacements["133917828562858"] = asset
    end
end
do -- Bandoboy > Knight (templars)
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/main/Logo%201.webp", "webp")
    if asset then
        replacements["121503061771505"] = asset
    end
end
do -- N (change)
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/a3acb9512e5a3d810894225e0d17aad3f5efef58/n1.png", "png")
    if asset then
        replacements["13854780042"] = asset
    end
end
do -- G (Change)
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/a3acb9512e5a3d810894225e0d17aad3f5efef58/G1.png", "png")
    if asset then
        replacements["13854780213"] = asset
    end
end
do -- Level
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/b698bcfbd9d85d1036a387a01003105e5f08f2e4/level2.png", "png")
    if asset then
        replacements["81461991645938"] = asset
    end
end
do -- Sky Lf
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/Sky%20Lf.png", "png")
    if asset then
        replacements["2108482395"] = asset
        replacements["10196550128"] = asset
        replacements["12261809766"] = asset
        replacements["14147883091"] = asset
        replacements["84214501374682"] = asset
        replacements["135908632589654"] = asset
    end
end
do -- Sky Rt
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sky%20rt.png", "png")
    if asset then
        replacements["2108482542"] = asset
        replacements["10196549902"] = asset
        replacements["12261809766"] = asset
        replacements["14147882405"] = asset
        replacements["84214501374682"] = asset
        replacements["135908632589654"] = asset
    end
end
do -- Sky Ft
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sky%20ft.png", "png")
    if asset then
        replacements["2108482231"] = asset
        replacements["10196550367"] = asset
        replacements["12261809766"] = asset
        replacements["14147882761"] = asset
        replacements["84214501374682"] = asset
        replacements["135908632589654"] = asset
    end
end
do -- Sky bk
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png", "png")
    if asset then
        replacements["2108482005"] = asset
        replacements["10196550937"] = asset
        replacements["12261809766"] = asset
        replacements["14147881792"] = asset
        replacements["84214501374682"] = asset
        replacements["135908632589654"] = asset
    end
end
do -- sky up
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png", "png")
    if asset then
        replacements["2108482676"] = asset
        replacements["10196567794"] = asset
        replacements["12261813678"] = asset
        replacements["14147881297"] = asset
        replacements["72960281658487"] = asset
        replacements["92138082970751"] = asset
    end
end
do -- dn
    local asset = download("https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png", "png")
    if asset then
        replacements["2108545280"] = asset
        replacements["10196550667"] = asset
        replacements["12261813110"] = asset
        replacements["14147882149"] = asset
        replacements["89972436184102"] = asset
        replacements["103020541883227"] = asset
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
    task.defer(function() if env[KEY] == state and obj.Parent then apply(obj) end end)
end)
-- Fresh sky: build all six faces before replacing existing sky.
local Lighting = game:GetService("Lighting")
local skyUrls = {
    SkyboxLf = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/Sky%20Lf.png",
    SkyboxRt = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sky%20rt.png",
    SkyboxFt = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sky%20ft.png",
    SkyboxBk = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png",
    SkyboxUp = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png",
    SkyboxDn = "https://raw.githubusercontent.com/crypt0knifer-111/Templars-X-Napoleon/c0337551a0a6ac0e03c48004753c082ed37a0ab2/sjy%20rest.png",
}
local function freshSky()
    local assets = {}
    for face, url in pairs(skyUrls) do
        assets[face] = download(url, "png")
        if not assets[face] then warn("[Templars] Sky face missing: " .. face); return end
    end
    local sky = Instance.new("Sky")
    sky.Name = "TemplarsNapoleonFreshSky"
    for face, asset in pairs(assets) do sky[face] = asset end
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("Sky") then child:Destroy() end
    end
    sky.Parent = Lighting
end
task.spawn(freshSky)
for _, delaySec in ipairs({1.5, 4, 8}) do task.delay(delaySec, freshSky) end
print("[Templars X Napoleon] Loaded pack and fresh sky (where supported).")
