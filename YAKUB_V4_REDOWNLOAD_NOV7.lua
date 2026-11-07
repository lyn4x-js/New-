-- YAKUB V4 | persistent pack with independent sky/texture toggles
-- Source rules preserved from YAKUB V2. Client-only; re-run after a server teleport.
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
local Lighting=game:GetService("Lighting")
local CoreGui=game:GetService("CoreGui")
local HttpService=game:GetService("HttpService")
local Players=game:GetService("Players")
local assetFn=getcustomasset or getsynasset
local requestFn=(syn and syn.request) or http_request or request
local G=(getgenv and getgenv()) or _G
-- Re-execution stops the previous watcher to avoid duplicate connections.
if G.YAKUB_V3_STOP then pcall(G.YAKUB_V3_STOP) end
local cache, originals, connections, objectConnections={},{},{},{}
local active, busy, disposed=false,false,false
local skyEnabled, texturesEnabled, bubbleHidden=true,true,false
local stats={matched=0,changed=0,failed=0}
local status,applyBtn,enableBtn,gui,panel,mini,skyBtn,textureBtn,bubbleBtn
local skyName="YakubV3Sky"
local function log(s) warn("[YAKUB V3] "..tostring(s)) end
local function setStatus(s)
    if status and status.Parent then status.Text=s end
    log(s)
end
local function normalizeId(v)
    local s=tostring(v or "")
    return s:match("[?&]id=(%d+)") or s:match("rbxassetid://(%d+)") or s:match("/(%d+)") or s:match("^(%d+)$")
end
local function fetch(url)
    if requestFn then
        local r=requestFn({Url=url,Method="GET"})
        assert(r and (r.Success or r.StatusCode==200),"HTTP error: "..url)
        return r.Body
    end
    return game:HttpGet(url)
end
local function localAsset(rule)
    if cache[rule.url] then return cache[rule.url] end
    assert(writefile and assetFn,"Executor needs writefile and getcustomasset")
    local ext=rule.url:lower():match("%.([a-z0-9]+)$") or "png"
    local filename="yakub_v3_"..HttpService:GenerateGUID(false).."."..ext
    local body=fetch(rule.url)
    assert(type(body)=="string" and #body>0,"Empty download: "..rule.name)
    writefile(filename,body)
    local uri=assetFn(filename)
    assert(type(uri)=="string" and #uri>0,"Cannot register asset: "..rule.name)
    cache[rule.url]=uri
    return uri
end
local faces={
    ["Skybox bk"]="SkyboxBk",["Skybox dn"]="SkyboxDn",
    ["Skybox ft"]="SkyboxFt",["skybox lf"]="SkyboxLf",
    ["Skybox rt"]="SkyboxRt",["Skybox up"]="SkyboxUp"
}
local map={}
for _,r in ipairs(Rules) do
    if r.enabled and not faces[r.name] then
        for _,id in ipairs(r.ids) do map[id]=r end
    end
end
local function isTextureRule(rule)
    return rule.name=="Main textures" or rule.name=="weapon background"
end
local function propOf(obj)
    if obj:IsA("Sound") then return "SoundId" end
    if obj:IsA("Decal") or obj:IsA("Texture") then return "Texture" end
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then return "Image" end
    if obj:IsA("MeshPart") then return "TextureID" end
    if obj:IsA("SpecialMesh") then return "TextureId" end
end
local function disconnectObjects()
    for obj,c in pairs(objectConnections) do pcall(function() c:Disconnect() end);objectConnections[obj]=nil end
end
local function replace(obj,prop)
    if not active or disposed or not obj.Parent then return end
    local ok,current=pcall(function() return obj[prop] end)
    if not ok then return end
    local rule=map[normalizeId(current)]
    if not rule or (isTextureRule(rule) and not texturesEnabled) then return end
    stats.matched=stats.matched+1
    local success,err=pcall(function()
        local replacement=localAsset(rule)
        if originals[obj]==nil then originals[obj]={prop=prop,value=current,rule=rule} end
        if obj[prop]~=replacement then obj[prop]=replacement;stats.changed=stats.changed+1 end
    end)
    if not success then stats.failed=stats.failed+1;log(rule.name..": "..tostring(err)) end
end
local function watchObject(obj)
    if not active or disposed or objectConnections[obj] then return end
    local prop=propOf(obj)
    if not prop then return end
    replace(obj,prop)
    local ok,c=pcall(function()
        return obj:GetPropertyChangedSignal(prop):Connect(function()
            if active and not disposed then task.defer(replace,obj,prop) end
        end)
    end)
    if ok then objectConnections[obj]=c end
end
local skyOriginals={}
local function applySky()
    if not active or disposed or not skyEnabled then return end
    local sky=Lighting:FindFirstChild(skyName)
    if not sky then sky=Instance.new("Sky");sky.Name=skyName end
    -- Do not destroy the game's original sky; hide it until the pack is disabled.
    for _,obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") and obj~=sky and not skyOriginals[obj] then
            skyOriginals[obj]=true
            obj.Parent=nil
        end
    end
    for _,rule in ipairs(Rules) do
        local face=faces[rule.name]
        if face and rule.enabled then
            local ok,err=pcall(function() sky[face]=localAsset(rule) end)
            if not ok then stats.failed=stats.failed+1;log("Sky "..face..": "..tostring(err)) end
        end
    end
    sky.Parent=Lighting
end
local function restoreSky()
    local sky=Lighting:FindFirstChild(skyName)
    if sky then sky:Destroy() end
    for obj in pairs(skyOriginals) do
        if obj then pcall(function() obj.Parent=Lighting end) end
    end
    skyOriginals={}
end
local function restoreTextures()
    for obj,entry in pairs(originals) do
        if isTextureRule(entry.rule) and obj and obj.Parent then
            pcall(function() obj[entry.prop]=entry.value end)
            originals[obj]=nil
        end
    end
end
local function restore()
    for obj,entry in pairs(originals) do
        if obj and obj.Parent then pcall(function() obj[entry.prop]=entry.value end) end
    end
    originals={}
    restoreSky()
end
local function stopWatch()
    active=false
    for _,c in ipairs(connections) do pcall(function() c:Disconnect() end) end
    connections={}
    disconnectObjects()
end
local function disablePack()
    stopWatch()
    restore()
    if applyBtn then applyBtn.Text="APPLY PACK" end
    if enableBtn then enableBtn.Text="DISABLE" end
    setStatus("Disabled. Tap Apply to enable again.")
end
local function teardown()
    disposed=true
    stopWatch()
    restore()
    if gui then pcall(function() gui:Destroy() end) end
end
G.YAKUB_V3_STOP=teardown
local function startWatch()
    table.insert(connections,game.DescendantAdded:Connect(function(obj)
        if active then task.defer(watchObject,obj) end
    end))
    table.insert(connections,Lighting.ChildAdded:Connect(function(obj)
        if active and skyEnabled and obj:IsA("Sky") and obj.Name~=skyName then
            task.defer(function() if active then applySky() end end)
        end
    end))
    -- Re-check on character respawn and on new Arena/lobby assets.
    local player=Players.LocalPlayer
    if player then
        table.insert(connections,player.CharacterAdded:Connect(function()
            task.delay(1,function()
                if active then applySky() end
            end)
        end))
    end
end
local parent=(gethui and gethui()) or CoreGui
local old=parent:FindFirstChild("YakubV3UI")
if old then old:Destroy() end
gui=Instance.new("ScreenGui")
gui.Name="YakubV3UI";gui.ResetOnSpawn=false;gui.Parent=parent
panel=Instance.new("Frame")
panel.Size=UDim2.fromOffset(340,292);panel.Position=UDim2.new(.5,-170,.3,0)
panel.BackgroundColor3=Color3.fromRGB(24,24,28);panel.Parent=gui
Instance.new("UICorner",panel).CornerRadius=UDim.new(0,12)
local function label(y,h,sz,msg)
    local t=Instance.new("TextLabel");t.BackgroundTransparency=1
    t.Position=UDim2.fromOffset(12,y);t.Size=UDim2.new(1,-24,0,h)
    t.Font=Enum.Font.GothamBold;t.TextSize=sz;t.TextWrapped=true
    t.TextColor3=Color3.fromRGB(255,159,43);t.Text=msg;t.Parent=panel
    return t
end
label(9,28,16,"YAKUB V4  |  PACK CONTROLS")
status=label(40,72,12,"Ready. Apply once per game session.")
status.TextColor3=Color3.fromRGB(240,240,240)
local function button(x,w,name)
    local b=Instance.new("TextButton")
    b.Size=UDim2.fromOffset(w,40);b.Position=UDim2.fromOffset(x,126)
    b.BackgroundColor3=Color3.fromRGB(255,148,30)
    b.TextColor3=Color3.new(0,0,0);b.Font=Enum.Font.GothamBold
    b.TextSize=13;b.Text=name;b.Parent=panel
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    return b
end
applyBtn=button(12,174,"APPLY PACK")
enableBtn=button(192,83,"DISABLE")
local close=button(281,47,"X")
label(261,25,11,"X hides menu only. Pack keeps running.")
mini=Instance.new("TextButton")
mini.Name="YakubReopen";mini.Size=UDim2.fromOffset(82,39)
mini.Position=UDim2.new(0,16,.55,0);mini.Text="YAKUB"
mini.Font=Enum.Font.GothamBold;mini.TextSize=13
mini.BackgroundColor3=Color3.fromRGB(255,148,30)
mini.TextColor3=Color3.new(0,0,0);mini.Visible=false;mini.Parent=gui
Instance.new("UICorner",mini).CornerRadius=UDim.new(0,9)
-- Category toggles keep sounds independent from sky and texture settings.
local function smallButton(x,y,w,caption)
    local b=Instance.new("TextButton")
    b.Size=UDim2.fromOffset(w,37);b.Position=UDim2.fromOffset(x,y)
    b.BackgroundColor3=Color3.fromRGB(48,48,54)
    b.TextColor3=Color3.fromRGB(255,169,62)
    b.Font=Enum.Font.GothamBold;b.TextSize=12;b.Text=caption;b.Parent=panel
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
    return b
end
skyBtn=smallButton(12,178,152,"SKY: ON")
textureBtn=smallButton(176,178,152,"TEXTURES: ON")
bubbleBtn=smallButton(12,221,316,"HIDE REOPEN BUBBLE: OFF")
local function updateButtons()
    skyBtn.Text=skyEnabled and "SKY: ON" or "SKY: OFF"
    textureBtn.Text=texturesEnabled and "TEXTURES: ON" or "TEXTURES: OFF"
    bubbleBtn.Text=bubbleHidden and "HIDE REOPEN BUBBLE: ON" or "HIDE REOPEN BUBBLE: OFF"
    mini.BackgroundTransparency=bubbleHidden and 1 or 0
    mini.TextTransparency=bubbleHidden and 1 or 0
end
skyBtn.Activated:Connect(function()
    if busy then return end
    skyEnabled=not skyEnabled
    if active then
        if skyEnabled then applySky() else restoreSky() end
    end
    updateButtons()
    setStatus(skyEnabled and "Sky enabled" or "Sky disabled; SFX still active")
end)
textureBtn.Activated:Connect(function()
    if busy then return end
    texturesEnabled=not texturesEnabled
    if active then
        if texturesEnabled then
            for _,obj in ipairs(game:GetDescendants()) do
                if not active then break end
                local prop=propOf(obj)
                if prop then replace(obj,prop) end
            end
        else restoreTextures() end
    end
    updateButtons()
    setStatus(texturesEnabled and "Textures enabled" or "Textures disabled; SFX still active")
end)
bubbleBtn.Activated:Connect(function()
    bubbleHidden=not bubbleHidden
    updateButtons()
    setStatus(bubbleHidden and "Bubble invisible; tap left-center to reopen" or "Reopen bubble visible")
end)
updateButtons()
close.Activated:Connect(function() panel.Visible=false;mini.Visible=true end)
mini.Activated:Connect(function() panel.Visible=true;mini.Visible=false end)
enableBtn.Activated:Connect(function()
    if busy then return end
    if active then disablePack() else setStatus("Pack is already disabled.") end
end)
applyBtn.Activated:Connect(function()
    if busy or active then return end
    busy=true;applyBtn.Text="LOADING..."
    setStatus("Downloading pack assets...")
    task.spawn(function()
        local ok,err=pcall(function()
            -- Fetch assets once; retain them across rounds.
            for _,r in ipairs(Rules) do
                if r.enabled then
                    local success,e=pcall(localAsset,r)
                    if not success then stats.failed=stats.failed+1;log("Asset "..r.name..": "..tostring(e)) end
                end
            end
            active=true
            applySky()
            startWatch()
            for _,obj in ipairs(game:GetDescendants()) do
                if not active then break end
                watchObject(obj)
            end
        end)
        if not ok then stats.failed=stats.failed+1;log(err) end
        busy=false
        applyBtn.Text=active and "PACK ACTIVE" or "RETRY"
        setStatus((active and "Watching new round assets" or "Startup failed").." | Matched "..stats.matched.." | Changed "..stats.changed.." | Errors "..stats.failed)
    end)
end)
log("Loaded. Apply once; X only hides the menu.")
