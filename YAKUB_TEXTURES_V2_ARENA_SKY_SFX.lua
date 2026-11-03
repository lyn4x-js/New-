-- YAKUB V2: standalone asset replacement, from user-supplied yakub textures.json
-- Best-effort local changes; game-specific assets may not be accessible.
local Rules = {
{name="Skybox bk",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"2108482005","14147881792","135908632589654","84214501374682","10196550937","12261809766"}},
{name="Skybox dn",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"2108545280","10196550667","14147882149","103020541883227","89972436184102","12261813110"}},
{name="Skybox ft",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147882761","12261809766","135908632589654","84214501374682","10196550367","2108482231"}},
{name="skybox lf",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147883091","135908632589654","84214501374682","2108482395","12261809766","10196550128"}},
{name="Skybox rt",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147882405","135908632589654","84214501374682","2108482542","12261809766","10196549902"}},
{name="Skybox up",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147881297","72960281658487","92138082970751","2108482676","10196567794","12261813678"}},
{name="Slide",url="https://github.com/H4rb0r-rbx/Fleasion-pearlscent-textures/raw/refs/heads/main/sparkle.wav",enabled=true,ids={"16737738420"}},
{name="Kill sound (all)",url="https://raw.githubusercontent.com/jakub7-svg/fleasion-custom-kill-sound/main/anime%20sound%20kill%20fleasion.MP3",enabled=true,ids={"16530229616","16530229541","16530229695"}},
{name="Main textures",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-texture/main/flower_texture_2.0-removebg-preview.png",enabled=true,ids={"7658055825"}},
{name="weapon background",url="https://raw.githubusercontent.com/jakub7-svg/fleasion-custom-bg/main/flower%20gun%20cosmetic.png",enabled=true,ids={"13220167337","13188242420","13220167472","13188153054","13188242287"}},
{name="Jump (all)",url="https://github.com/H4rb0r-rbx/Fleasion-pearlscent-textures/raw/refs/heads/main/bell%20ding%20sfx.ogg",enabled=true,ids={"16770456156","16492958314"}},
}
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local assetFn = getcustomasset or getsynasset
local requestFn = (syn and syn.request) or http_request or request
local cache, originals, watchConnections = {}, {}, {}
local active, applying = false, false
local stats = {matched=0, changed=0, failed=0}
local function normalizeId(v)
    local s = tostring(v or "")
    return s:match("[?&]id=(%d+)") or s:match("rbxassetid://(%d+)") or s:match("/(%d+)") or s:match("^(%d+)$")
end
local function fetch(url)
    if requestFn then
        local res = requestFn({Url=url, Method="GET"})
        assert(res and (res.Success or res.StatusCode == 200), "HTTP failed "..url)
        return res.Body
    end
    return game:HttpGet(url)
end
local function localAsset(rule)
    if cache[rule.url] then return cache[rule.url] end
    assert(writefile and assetFn, "Executor needs writefile and getcustomasset")
    local ext=rule.url:lower():match("%.([a-z0-9]+)$") or "png"
    local filename="yakub_v2_"..tostring(#rule.url).."_"..HttpService:GenerateGUID(false).."."..ext
    local body=fetch(rule.url)
    assert(type(body)=="string" and #body>0, "Empty asset: "..rule.name)
    writefile(filename,body)
    local uri=assetFn(filename)
    assert(type(uri)=="string", "Custom asset unavailable: "..rule.name)
    cache[rule.url]=uri
    return uri
end
local faceNames = {
    ["Skybox bk"]="SkyboxBk", ["Skybox dn"]="SkyboxDn",
    ["Skybox ft"]="SkyboxFt", ["skybox lf"]="SkyboxLf",
    ["Skybox rt"]="SkyboxRt", ["Skybox up"]="SkyboxUp"
}
local ruleMap={}
for _,r in ipairs(Rules) do
    if r.enabled then
        for _,id in ipairs(r.ids) do
            -- The source JSON reuses IDs across skybox faces; only map non-sky properties.
            if not faceNames[r.name] then ruleMap[id]=r end
        end
    end
end
local function propertyFor(obj)
    if obj:IsA("Sound") then return "SoundId" end
    if obj:IsA("Decal") or obj:IsA("Texture") then return "Texture" end
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then return "Image" end
    if obj:IsA("MeshPart") then return "TextureID" end
    if obj:IsA("SpecialMesh") then return "TextureId" end
end
local function updateObject(obj)
    local prop=propertyFor(obj)
    if not prop then return end
    local ok,current=pcall(function() return obj[prop] end)
    if not ok then return end
    local rule=ruleMap[normalizeId(current)]
    if not rule then return end
    stats.matched=stats.matched+1
    local good,err=pcall(function() obj[prop]=localAsset(rule) end)
    if good then stats.changed=stats.changed+1
    else stats.failed=stats.failed+1; warn("[YAKUB] "..rule.name..": "..tostring(err)) end
end
local function applySky()
    local sky=Lighting:FindFirstChild("YakubV2Sky")
    if not sky then sky=Instance.new("Sky");sky.Name="YakubV2Sky" end
    -- Other active Sky instances can take precedence; disable them locally.
    for _,obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") and obj~=sky then obj:Destroy() end
    end
    for _,rule in ipairs(Rules) do
        local face=faceNames[rule.name]
        if face and rule.enabled then
            local ok,err=pcall(function() sky[face]=localAsset(rule) end)
            if not ok then stats.failed=stats.failed+1;warn("[YAKUB] sky "..face..": "..tostring(err)) end
        end
    end
    sky.Parent=Lighting
end
local parent=(gethui and gethui()) or CoreGui
local old=parent:FindFirstChild("YakubV2UI")
if old then old:Destroy() end
local gui=Instance.new("ScreenGui")
gui.Name="YakubV2UI";gui.ResetOnSpawn=false;gui.Parent=parent
local panel=Instance.new("Frame")
panel.Size=UDim2.fromOffset(330,175);panel.Position=UDim2.new(.5,-165,.32,0)
panel.BackgroundColor3=Color3.fromRGB(23,23,28);panel.Parent=gui
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,12)
local function text(y,h,size,msg)
    local o=Instance.new("TextLabel");o.BackgroundTransparency=1
    o.Position=UDim2.fromOffset(12,y);o.Size=UDim2.new(1,-24,0,h)
    o.TextColor3=Color3.fromRGB(255,161,48);o.Font=Enum.Font.GothamBold
    o.TextSize=size;o.TextWrapped=true;o.Text=msg;o.Parent=panel
    return o
end
text(8,28,16,"YAKUB V2  |  SKY + SFX + TEXTURES")
local status=text(39,65,12,"Ready. Tap Apply to load assets.")
status.TextColor3=Color3.fromRGB(240,240,240)
local function button(x,w,msg)
    local b=Instance.new("TextButton");b.Size=UDim2.fromOffset(w,40)
    b.Position=UDim2.fromOffset(x,120);b.Text=msg;b.TextSize=14
    b.Font=Enum.Font.GothamBold;b.BackgroundColor3=Color3.fromRGB(255,145,25)
    b.TextColor3=Color3.new(0,0,0);b.Parent=panel
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    return b
end
local apply=button(12,235,"APPLY + WATCH")
local close=button(255,62,"X")
close.Activated:Connect(function()
    active=false
    for _,c in ipairs(watchConnections) do c:Disconnect() end
    gui:Destroy()
end)
local function safeUpdate(obj)
    local ok,err=pcall(updateObject,obj)
    if not ok then stats.failed=stats.failed+1;warn("[YAKUB] scan: "..tostring(err)) end
end
apply.Activated:Connect(function()
    if applying or active then return end
    applying=true;apply.Text="LOADING...";status.Text="Fetching assets and scanning current objects..."
    task.spawn(function()
        local ok,err=pcall(function()
            -- Pre-fetch assets to avoid downloading repeatedly inside object events.
            for _,rule in ipairs(Rules) do
                if rule.enabled then
                    local success,e=pcall(localAsset,rule)
                    if not success then stats.failed=stats.failed+1;warn("[YAKUB] download "..rule.name..": "..tostring(e)) end
                end
            end
            applySky()
            for _,obj in ipairs(game:GetDescendants()) do safeUpdate(obj) end
            active=true
            table.insert(watchConnections,game.DescendantAdded:Connect(function(obj)
                if active then task.defer(safeUpdate,obj) end
            end))
            table.insert(watchConnections,Lighting.ChildAdded:Connect(function(obj)
                if active and obj:IsA("Sky") and obj.Name~="YakubV2Sky" then
                    task.defer(function() if active then pcall(applySky) end end)
                end
            end))
        end)
        if not ok then warn("[YAKUB V2] "..tostring(err)) end
        status.Text=(ok and "Watching new assets" or "Partial failure").." | Matched "..stats.matched.." | Changed "..stats.changed.." | Errors "..stats.failed
        apply.Text=active and "WATCHING" or "RETRY";applying=false
        warn("[YAKUB V2] "..status.Text..". Sound playback not guaranteed.")
    end)
end)
