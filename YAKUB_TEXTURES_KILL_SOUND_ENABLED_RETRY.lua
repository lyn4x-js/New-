-- YAKUB TEXTURES - standalone asset replacement helper
-- Generated from yakub textures.json; requires executor file/custom-asset support.
-- Applies to matching existing instances only. No guarantee of game-wide replacements.
local Rules = {
{name="Skybox bk",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"2108482005","14147881792","135908632589654","84214501374682","10196550937","12261809766"}},
{name="Skybox dn",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"2108545280","10196550667","14147882149","103020541883227","89972436184102","12261813110"}},
{name="Skybox ft",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147882761","12261809766","135908632589654","84214501374682","10196550367","2108482231"}},
{name="skybox",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147883091","135908632589654","84214501374682","2108482395","12261809766","10196550128"}},
{name="skybox lf",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147883091","135908632589654","84214501374682","2108482395","12261809766","10196550128"}},
{name="Skybox rt",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147882405","135908632589654","84214501374682","2108482542","12261809766","10196549902"}},
{name="Skybox up",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-skybox/main/anime%20sky%203.png",enabled=true,ids={"14147881297","72960281658487","92138082970751","2108482676","10196567794","12261813678"}},
{name="Slide",url="https://github.com/H4rb0r-rbx/Fleasion-pearlscent-textures/raw/refs/heads/main/sparkle.wav",enabled=true,ids={"16737738420"}},
{name="Kill sound (all)",url="https://raw.githubusercontent.com/jakub7-svg/fleasion-custom-kill-sound/main/anime%20sound%20kill%20fleasion.MP3",enabled=true,ids={"16530229616","16530229541","16530229695"}},
{name="Main textures",url="https://raw.githubusercontent.com/jakub7-svg/Fleasion-texture/main/flower_texture_2.0-removebg-preview.png",enabled=true,ids={"7658055825"}},
{name="weapon background",url="https://raw.githubusercontent.com/jakub7-svg/fleasion-custom-bg/main/flower%20gun%20cosmetic.png",enabled=true,ids={"13220167337","13188242420","13220167472","13188153054","13188242287"}},
{name="Jump (all)",url="https://github.com/H4rb0r-rbx/Fleasion-pearlscent-textures/raw/refs/heads/main/bell%20ding%20sfx.ogg",enabled=true,ids={"16770456156","16492958314"}}
}
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local function assetId(s)
    return tostring(s or ""):match("(%d+)")
end
local function download(url, index)
    if not (writefile and (getcustomasset or getsynasset)) then
        error("Requires writefile and getcustomasset/getsynasset")
    end
    local ext = url:lower():match("%.([a-z0-9]+)$") or "png"
    if ext ~= "png" and ext ~= "jpg" and ext ~= "jpeg" and ext ~= "ogg" and ext ~= "wav" and ext ~= "mp3" then ext="png" end
    local path = "yakub_asset_"..index.."."..ext
    local bytes = game:HttpGet(url)
    assert(type(bytes)=="string" and #bytes>0,"Empty download: "..url)
    writefile(path, bytes)
    return (getcustomasset or getsynasset)(path)
end
local function applyPack(setStatus)
    local changes, failures = 0, 0
    local cache = {}
    local objects = game:GetDescendants()
    for i, rule in ipairs(Rules) do
        if rule.enabled then
            setStatus("Loading "..rule.name.." ("..i.."/"..#Rules..")")
            local ok, asset = pcall(function()
                if not cache[rule.url] then cache[rule.url] = download(rule.url,i) end
                return cache[rule.url]
            end)
            if not ok then
                failures = failures + 1
                warn("[YAKUB] "..rule.name..": "..tostring(asset))
            else
                local idSet = {}
                for _, id in ipairs(rule.ids) do idSet[id]=true end
                -- Skybox faces are assigned directly to a Sky instance.
                local face = ({["Skybox bk"]="SkyboxBk",["Skybox dn"]="SkyboxDn",["Skybox ft"]="SkyboxFt",["skybox lf"]="SkyboxLf",["Skybox rt"]="SkyboxRt",["Skybox up"]="SkyboxUp"})[rule.name]
                if face then
                    local sky = Lighting:FindFirstChild("YakubStandaloneSky")
                    if not sky then sky=Instance.new("Sky");sky.Name="YakubStandaloneSky";sky.Parent=Lighting end
                    local success = pcall(function() sky[face]=asset end)
                    if success then changes=changes+1 else failures=failures+1 end
                end
                for _, obj in ipairs(objects) do
                    local property
                    if obj:IsA("Decal") or obj:IsA("Texture") then property="Texture"
                    elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then property="Image"
                    elseif obj:IsA("Sound") then property="SoundId"
                    elseif obj:IsA("MeshPart") then property="TextureID" end
                    if property then
                        local readOk, current = pcall(function() return obj[property] end)
                        if readOk and idSet[assetId(current)] then
                            local changed = pcall(function() obj[property]=asset end)
                            if changed then changes=changes+1 else failures=failures+1 end
                        end
                    end
                end
            end
        end
    end
    setStatus("Done: "..changes.." changed, "..failures.." errors")
    warn("[YAKUB] Applied. Changes: "..changes.."; errors: "..failures)
end
local parent = (gethui and gethui()) or CoreGui
local old=parent:FindFirstChild("YakubStandaloneUI")
if old then old:Destroy() end
local gui=Instance.new("ScreenGui")
gui.Name="YakubStandaloneUI";gui.ResetOnSpawn=false;gui.Parent=parent
local frame=Instance.new("Frame")
frame.Size=UDim2.fromOffset(310,158);frame.Position=UDim2.new(.5,-155,.35,0)
frame.BackgroundColor3=Color3.fromRGB(23,23,28);frame.Parent=gui
Instance.new("UICorner",frame).CornerRadius=UDim.new(0,12)
local function label(text,y,height)
    local l=Instance.new("TextLabel");l.BackgroundTransparency=1;l.Size=UDim2.new(1,-20,0,height)
    l.Position=UDim2.fromOffset(10,y);l.Font=Enum.Font.GothamBold;l.TextColor3=Color3.fromRGB(255,160,42)
    l.TextSize=14;l.TextWrapped=true;l.Text=text;l.Parent=frame;return l
end
label("YAKUB TEXTURES  |  STANDALONE",10,25)
local status=label("Ready - applies to matching loaded assets",42,42)
status.TextColor3=Color3.fromRGB(230,230,230);status.TextSize=12
local apply=Instance.new("TextButton")
apply.Size=UDim2.fromOffset(215,38);apply.Position=UDim2.fromOffset(12,105)
apply.Text="APPLY PACK";apply.TextSize=16;apply.Font=Enum.Font.GothamBold
apply.BackgroundColor3=Color3.fromRGB(255,142,24);apply.TextColor3=Color3.new(0,0,0);apply.Parent=frame
Instance.new("UICorner",apply).CornerRadius=UDim.new(0,8)
local close=Instance.new("TextButton")
close.Size=UDim2.fromOffset(60,38);close.Position=UDim2.fromOffset(237,105)
close.Text="X";close.TextSize=16;close.BackgroundColor3=Color3.fromRGB(65,65,72)
close.TextColor3=Color3.new(1,1,1);close.Parent=frame
Instance.new("UICorner",close).CornerRadius=UDim.new(0,8)
close.Activated:Connect(function() gui:Destroy() end)
local busy=false
apply.Activated:Connect(function()
    if busy then return end
    busy=true;apply.Text="WORKING..."
    task.spawn(function()
        local ok, err=pcall(function() applyPack(function(s) status.Text=s end) end)
        if not ok then status.Text="Error: "..tostring(err);warn("[YAKUB] "..tostring(err)) end
        apply.Text="APPLY AGAIN";busy=false
    end)
end)
