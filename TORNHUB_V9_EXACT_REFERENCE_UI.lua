-- TORNHUB V9 ARENA SAFE UPDATE | iPad / Delta
-- Fast boot: no large skybox downloads until APPLY. Reuse scripts within session.
-- Preserves V8 via launch button; 19 texture links, 5 JSON sky configurations.
-- Reference-art banner is optional; upload the accompanying PNG to GitHub in the same repo.
-- Executor needs writefile and getcustomasset for local image display.
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local env=(getgenv and getgenv()) or _G
if env.TORNHUB_V9 and env.TORNHUB_V9.Stop then pcall(env.TORNHUB_V9.Stop) end
local S={alive=true,connections={},fps="OFF",saved={},modified={},skyEngine=nil,activeAir=nil,scriptCache={},texturePacksLaunched={},fpsCount=0,skyOriginals={},skySaved=false}
env.TORNHUB_V9=S
local function track(c) table.insert(S.connections,c) return c end
local ORANGE=Color3.fromRGB(255,115,16)
local DARK=Color3.fromRGB(12,12,16)
local PANEL=Color3.fromRGB(22,22,29)
local WHITE=Color3.fromRGB(247,242,237)
local BANNER_ASSET="" -- Optional: Roblox-hosted image asset ID (preferred if available)
local BANNER_URL="https://raw.githubusercontent.com/lyn4x-js/New-/main/TORNHUB_V9_GIRLS_BANNER.png"
local function bannerImage()
 if BANNER_ASSET~="" then return BANNER_ASSET end
 if type(writefile)~="function" or type(getcustomasset)~="function" then return nil end
 local ok,asset=pcall(function()
  local filename="TORNHUB_V9_GIRLS_BANNER.png"
  local data=game:HttpGet(BANNER_URL)
  if type(data)~="string" or #data<1000 then error("Banner not uploaded yet") end
  writefile(filename,data)
  return getcustomasset(filename)
 end)
 if ok then return asset end
 warn("[TORNHUB V9] Banner unavailable: "..tostring(asset))
 return nil
end
local v8url="https://raw.githubusercontent.com/lyn4x-js/New-/main/TORNHUB_V8_MAIN_NEW.lua"
local packs={
 {"Mahiru","Full Pack","https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/Mahiru_iPad_Adaptive_Batch_V1.lua"},
 {"DETERMINATION","Textures + SFX","https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/DETERMINATION_Mirc5K_iPad_Adaptive_Selector_V1.lua"},
 {"Alya","Textures Only","https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/Alya_iPad_Adaptive_Standalone_V1.lua"},
 {"Miku","Full Pack","https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/MIKU_iPad_Adaptive_AllInOne_V1.lua"},
 {"Zelda","Full Pack","https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/ZELDA_iPad_Adaptive_AllInOne_V1.lua"},
 {"Death Note","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/DEATH_NOTE_FULL_PACK_FRESH_SKY_V2.lua"},
 {"PIRXCY","Textures","https://raw.githubusercontent.com/lyn4x-js/Textures/main/PIRXCY_iPad_Adaptive_AllInOne_V1.lua"},
 {"Blue Like the Ocean","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/BLUE_LIKE_THE_OCEAN_FULL_PACK_FRESH_SKY_V2.lua"},
 {"Re:Zero","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/REZERO_FULL_PACK_FRESH_SKY_V2.lua"},
 {"Sailor Moon","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/SAILOR_MOON_FULL_PACK_FRESH_SKY_V2.lua"},
 {"Bocchi the Rock","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/BOCCHI_THE_ROCK_FULL_PACK_FRESH_SKY_V2.lua"},
 {"Love","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/LOVE_FULL_PACK_FRESH_SKY_V3_FIXED.lua"},
 {"Pashas","Textures","https://raw.githubusercontent.com/lyn4x-js/New-/main/PASHAS_TEXTURES_iPad_ADAPTIVE_V2.lua"},
 {"Dark Heaven","Full Pack","https://raw.githubusercontent.com/lyn4x-js/New-/main/DARK_HEAVEN_FULL_PACK_FRESH_SKY_V2.lua"},
 {"Shades","Textures","https://raw.githubusercontent.com/lyn4x-js/New-/main/SHADES_TEXTURE_PACK_IPAD_V1.lua"},
 {"Halloween SAFE V2","Arena Safe","https://raw.githubusercontent.com/lyn4x-js/New-/main/HALLOWEEN_TEXTURES_iPad_SAFE_V2.lua"},
 {"Minecraft SAFE V2","Arena Safe","https://raw.githubusercontent.com/lyn4x-js/New-/main/MINECRAFT_TEXTURES_iPad_SAFE_V2.lua"},
 {"Flow","New","https://raw.githubusercontent.com/lyn4x-js/New-/main/FLOW_TEXTURES_iPad_ADAPTIVE_V1.lua"},
 {"Hello Kitty","New","https://raw.githubusercontent.com/lyn4x-js/New-/main/HELLO_KITTY_TEXTURES_iPad_ADAPTIVE_V1.lua"}
}
local extraSkies={
 {"Chill Pink","Chill Pink.json"},
 {"Black Starry Night","Black Starry night.json"},
 {"Empty Sky","Empty Sky.json"},
 {"Purple Flow Sky","PurpleFlowSky.json"},
 {"Hatsune Miku","AtsuneMikuSkybox.json"}
}
local function runUrl(url)
 if type(loadstring)~="function" then return false,"loadstring unavailable" end
 local ok,err=pcall(function() local fn=S.scriptCache[url]; if not fn then local code=game:HttpGet(url); local msg;fn,msg=loadstring(code); if not fn then error(msg) end;S.scriptCache[url]=fn end;fn() end)
 return ok,err
end
local skyNames={}
-- Sky labels parsed from V8. Replaced by the exact list below for consistency.
skyNames={"Pink Bliss","Cool Black","Breakcore Cat","Alya Flushie","Makima","Nazuna V2 Lite","Alya Sky V3","Shiina Mahiru","Kasane Teto","Zero Two (02)","Miku Galaxy","Hoshino Ai V1","Shikimori V1","Purple Chill","Blackhole","Pink Cloud","Rem & Ram","Ado Sky V1","Suo Yuki V2","Yuki Aim V1","World Is Mine Miku V5.1","Shiroko Giveaway","Miku Aim","Mahiru Shiina V1","Nino Nakano V1","Miku Nakano","Rat Sky","Megumin Explosion Sky V1","Re:Zero Rem & Ram V1","Nazuna Nanakusa","Yuki V1","Kaiju Princess Daigneux"}
for _,n in ipairs({'Chill Pink','Black Starry Night','Empty Sky','Purple Flow Sky','Hatsune Miku'}) do table.insert(skyNames,n) end
local function ensureSkyEngine()
 if S.skyEngine then return S.skyEngine end
 local env=(getgenv and getgenv()) or _G
 if env.TORNHUB_V9_SKY_ENGINE then S.skyEngine=env.TORNHUB_V9_SKY_ENGINE;return S.skyEngine end
 local url='https://raw.githubusercontent.com/lyn4x-js/New-/main/TORNHUB_V9_SKY_ENGINE.lua' -- downloaded only on first sky APPLY
 local code=game:HttpGet(url)
 local fn,err=loadstring(code);if not fn then error(err)end
 local module=fn();assert(type(module)=='table' and type(module.Apply)=='function','Invalid sky module')
 S.skyEngine=module;return module
end
local airVersions={
 {'V1 Original','RIVALS_AIR_SLIDE_V1','https://raw.githubusercontent.com/lyn4x-js/New-/main/RIVALS_AIR_SLIDE_V1.lua'},
 {'V2 Fast Fall','RIVALS_AIR_SLIDE_V2_FAST_FALL','https://raw.githubusercontent.com/lyn4x-js/New-/main/RIVALS_AIR_SLIDE_V2_FAST_FALL.lua'}
}
local function stopAir()
 for _,entry in ipairs(airVersions) do
  local st=env[entry[2]]
  if st and type(st.Stop)=='function' then pcall(function()st.Stop()end) end
 end
 S.activeAir=nil
end
local function setAir(which)
 if S.activeAir==which then stopAir();return end
 stopAir()
 local entry=airVersions[which]
 local ok,err=runUrl(entry[3]);if not ok then error(err)end
 local st=env[entry[2]]
 if not st then error('Air Slide script did not expose its controls') end
 st.enabled=true
 S.activeAir=which
 -- Hide the original floating Air Slide GUI: V9 controls it now.
 local function hide(parent)
  if parent then local g=parent:FindFirstChild(entry[2]..'_GUI')
   if g then g.Enabled=false end
  end
 end
 pcall(function()hide(game:GetService('CoreGui'))end)
 pcall(function()hide(player:FindFirstChild('PlayerGui'))end)
end
-- Clear supported packs via their public close/remove API; never claim a universal reset.
local function clearTextures()
 local count,errors=0,0
 for key,mod in pairs(env) do
  if type(key)=='string' and (key:find('TEXTURE') or key:find('Texture') or key:find('texture')) and type(mod)=='table' then
   local fn=mod.close or mod.Close or mod.remove or mod.Remove or mod.Stop
   if type(fn)=='function' then
    local ok=pcall(fn)
    if not ok then ok=pcall(fn,mod) end
    if ok then count=count+1 else errors=errors+1 end
   end
  end
 end
 return count,errors
end
local function rememberSky()
 if S.skySaved then return end
 S.skySaved=true
 S.skyOriginals={}
 for _,obj in ipairs(Lighting:GetChildren()) do
  if obj:IsA('Sky') or obj:IsA('Atmosphere') then
   table.insert(S.skyOriginals,obj:Clone())
  end
 end
 S.skyLighting={ClockTime=Lighting.ClockTime,Ambient=Lighting.Ambient,OutdoorAmbient=Lighting.OutdoorAmbient}
end
local function restoreNativeSky()
 if not S.skySaved then return end
 for _,obj in ipairs(Lighting:GetChildren()) do
  if obj:IsA('Sky') or obj:IsA('Atmosphere') then obj:Destroy() end
 end
 for _,obj in ipairs(S.skyOriginals) do obj:Clone().Parent=Lighting end
 for prop,value in pairs(S.skyLighting) do pcall(function()Lighting[prop]=value end) end
end
local function applyNativeSky(preset)
 rememberSky()
 for _,obj in ipairs(Lighting:GetChildren()) do
  if obj:IsA('Atmosphere') then obj:Destroy() end
 end
 local atmosphere=Instance.new('Atmosphere')
 atmosphere.Name='TORNHUB_V9_ATMOSPHERE'
 atmosphere.Color=preset[2];atmosphere.Decay=preset[3]
 atmosphere.Density=.33;atmosphere.Haze=1.5
 atmosphere.Parent=Lighting
 Lighting.ClockTime=preset[4]
 Lighting.Ambient=preset[2]
 Lighting.OutdoorAmbient=preset[3]
end

local EXACT_URL="https://raw.githubusercontent.com/lyn4x-js/New-/main/TORNHUB_V9_EXACT_BACKGROUND.jpg"
local function getBackground()
 if type(writefile)~="function" or type(getcustomasset)~="function" then return nil,"Delta needs writefile + getcustomasset" end
 local ok,result=pcall(function()
  local data=game:HttpGet(EXACT_URL)
  assert(type(data)=="string" and #data>10000,"Background JPG missing on GitHub")
  writefile("TORNHUB_V9_EXACT_BACKGROUND.jpg",data)
  return getcustomasset("TORNHUB_V9_EXACT_BACKGROUND.jpg")
 end)
 if ok then return result end
 return nil,tostring(result)
end

local gui=Instance.new("ScreenGui")
gui.Name="TORNHUB_V9_EXACT_GUI";gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true
gui.Parent=player:WaitForChild("PlayerGui")
local function mk(cl,parent,props)
 local o=Instance.new(cl)
 for k,v in pairs(props or {}) do o[k]=v end
 o.Parent=parent;return o
end
local function round(o,r) mk("UICorner",o,{CornerRadius=UDim.new(0,r or 8)});return o end
local function label(parent,t,sz,pos,size,col)
 return mk("TextLabel",parent,{BackgroundTransparency=1,Text=t,TextColor3=col or WHITE,TextSize=sz or 15,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,Position=pos or UDim2.new(),Size=size or UDim2.fromScale(1,1),ZIndex=12})
end
local function btn(parent,t,pos,size,fn,visible)
 local b=mk("TextButton",parent,{Text=t or "",TextColor3=WHITE,TextSize=14,Font=Enum.Font.GothamBold,BackgroundColor3=Color3.fromRGB(180,65,8),BackgroundTransparency=visible and .08 or 1,BorderSizePixel=0,Position=pos,Size=size,ZIndex=15,AutoButtonColor=true})
 if visible then round(b,7) end
 b.MouseButton1Click:Connect(fn)
 return b
end
-- Reference image dimensions: 1536 x 1024. All clickable hitboxes use relative coordinates.
local function xy(x,y,w,h) return UDim2.fromScale(x/1536,y/1024),UDim2.fromScale(w/1536,h/1024) end
local root=mk("Frame",gui,{Size=UDim2.fromOffset(960,640),Position=UDim2.new(.5,-480,.5,-320),BackgroundColor3=Color3.fromRGB(9,8,10),BorderSizePixel=0,ClipsDescendants=true})
round(root,14)
local scaler=mk("UIScale",root,{Scale=1})
local function fit()
 local camera=workspace.CurrentCamera
 if not camera then return end
 local v=camera.ViewportSize
 scaler.Scale=math.clamp(math.min(v.X/990,v.Y/670),.36,1.6)
end
fit()
if workspace.CurrentCamera then track(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)) end
local backdrop=mk("ImageLabel",root,{Size=UDim2.fromScale(1,1),Image="",BackgroundTransparency=1,ScaleType=Enum.ScaleType.Stretch,ZIndex=1})
local fallback=label(root,"TORNHUB V9  •  REFERENCE DESIGN",25,UDim2.fromScale(.1,.09),UDim2.fromScale(.8,.1),ORANGE)
local notice=label(root,"Loading reference artwork...",13,UDim2.fromScale(.21,.93),UDim2.fromScale(.65,.045),ORANGE)
task.spawn(function()
 local asset,err=getBackground()
 if not S.alive then return end
 if asset then backdrop.Image=asset;fallback.Visible=false;notice.Text="" else notice.Text="Artwork unavailable: "..tostring(err):sub(1,85) end
end)
local panel=round(mk("Frame",root,{Position=UDim2.fromScale(.205,.355),Size=UDim2.fromScale(.505,.52),BackgroundColor3=Color3.fromRGB(11,9,12),BackgroundTransparency=.035,Visible=false,ZIndex=10,BorderSizePixel=0}),10)
mk("UIStroke",panel,{Color=ORANGE,Thickness=1.5,Transparency=.08})
local ptitle=label(panel,"TEXTURES",19,UDim2.fromScale(.035,.025),UDim2.fromScale(.83,.085),ORANGE)
local pclose=btn(panel,"✕",UDim2.fromScale(.91,.02),UDim2.fromScale(.07,.08),function()panel.Visible=false end,true)
local scroller=mk("ScrollingFrame",panel,{Position=UDim2.fromScale(.025,.13),Size=UDim2.fromScale(.95,.84),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=ORANGE,CanvasSize=UDim2.fromOffset(0,0),ZIndex=11})
local stack=mk("UIListLayout",scroller,{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder})
track(stack:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()scroller.CanvasSize=UDim2.fromOffset(0,stack.AbsoluteContentSize.Y+12)end))
local function clear() for _,c in ipairs(scroller:GetChildren()) do if c~=stack then c:Destroy() end end end
local function status(t)notice.Text=tostring(t);print("[TORNHUB V9]",t)end
local function row(name,description,callback)
 local frame=round(mk("Frame",scroller,{Size=UDim2.new(1,-8,0,58),BackgroundColor3=Color3.fromRGB(28,20,19),BorderSizePixel=0,ZIndex=12}),7)
 label(frame,name,13,UDim2.fromScale(.025,.08),UDim2.fromScale(.72,.42))
 label(frame,description or "",10,UDim2.fromScale(.025,.55),UDim2.fromScale(.72,.34),Color3.fromRGB(188,167,153))
 local b=btn(frame,"APPLY",UDim2.fromScale(.78,.18),UDim2.fromScale(.20,.64),function()
  task.spawn(function()
   local ok,err=pcall(callback)
   if ok then status("Applied: "..name) else status("Error: "..tostring(err):sub(1,80)) end
  end)
 end,true)
 return frame
end
local function applyFps(mode)
 -- Changes only client-visible properties; does not alter gravity, movement or physics.
 if S.fps==mode then return end
 for inst,props in pairs(S.saved)do if inst and inst.Parent then for prop,val in pairs(props)do pcall(function()inst[prop]=val end)end end end
 S.saved={};S.fps=mode
 if mode=="OFF" then return end
 local function change(obj,prop,value)
  if not S.saved[obj] then S.saved[obj]={} end
  if S.saved[obj][prop]==nil then local ok,old=pcall(function()return obj[prop]end);if ok then S.saved[obj][prop]=old end end
  pcall(function()obj[prop]=value end)
 end
 change(Lighting,"GlobalShadows",false)
 for index,obj in ipairs(game:GetDescendants())do
  if index % 350 == 0 then task.wait() end
  if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then change(obj,"Enabled",false)
  elseif mode=="MAX" and (obj:IsA("BloomEffect") or obj:IsA("SunRaysEffect") or obj:IsA("DepthOfFieldEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("BlurEffect")) then change(obj,"Enabled",false)
  elseif mode=="MAX" and obj:IsA("BasePart") and (not player.Character or not obj:IsDescendantOf(player.Character)) then
   change(obj,"CastShadow",false)
  end
 end
end

local current="HOME"
local function openTab(tab)
 current=tab;panel.Visible=true;ptitle.Text=tab;clear()
 if tab=="SKIES" then
  row("RESTORE ORIGINAL SKY","Restore supported sky changes",function()
   if S.skyEngine then local ok,msg=S.skyEngine.Reset();if not ok then error(msg)end end
   restoreNativeSky()
  end)
  for _,name in ipairs(skyNames) do
   row(name,"Original V8 sky entry",function()
    local e=ensureSkyEngine();local ok,msg=e.Apply(name);if not ok then error(msg)end
   end)
  end
 elseif tab=="TEXTURES" then
  row("CLEAR TEXTURES","Calls supported texture cleanup functions",function()local n,e=clearTextures();status("Cleared "..n.." packs; "..e.." errors")end)
  for _,pack in ipairs(packs) do
   local p=pack
   row(p[1],p[2],function()local ok,err=runUrl(p[3]);if not ok then error(err)end end)
  end
 elseif tab=="PERFORMANCE" then
  for _,mode in ipairs({"OFF","BALANCED","MAX"}) do
   local m=mode
   row("FPS BOOST: "..m,"Current mode: "..S.fps,function()applyFps(m);openTab("PERFORMANCE")end)
  end
 elseif tab=="AIR SLIDES" then
  for i,entry in ipairs(airVersions) do
   local index=i
   row(entry[1],"Toggle air slide",function()setAir(index);openTab("AIR SLIDES")end)
  end
  row("STOP AIR SLIDES","Remove platforms",function()stopAir()end)
 elseif tab=="CHARACTERS" then
  row("Reference character art","Shown in the original menu artwork",function()status("Character art is decorative")end)
 elseif tab=="SETTINGS" then
  row("RESET GRAPHICS","Turn FPS booster off",function()applyFps("OFF")end)
  row("RELOAD BACKGROUND","Refresh GitHub JPG",function()local a,e=getBackground();if a then backdrop.Image=a else error(e)end end)
 elseif tab=="HOME" then
  panel.Visible=false
 end
end
-- Reference screenshot's original controls are pixels; touch hitboxes below make them functional.
local function hotspot(x,y,w,h,fn) local p,s=xy(x,y,w,h);local b=btn(root,"",p,s,fn,false);b.ZIndex=4;return b end
hotspot(90,358,220,55,function()openTab("HOME")end)
hotspot(90,415,220,53,function()openTab("SKIES")end)
hotspot(90,469,220,55,function()openTab("TEXTURES")end)
hotspot(90,526,220,54,function()openTab("CHARACTERS")end)
hotspot(90,581,220,56,function()openTab("PERFORMANCE")end)
hotspot(90,636,220,54,function()openTab("SETTINGS")end)
hotspot(320,785,220,94,function()openTab("SKIES")end)
hotspot(550,785,218,94,function()openTab("TEXTURES")end)
hotspot(774,785,218,94,function()openTab("CHARACTERS")end)
hotspot(995,785,95,94,function()openTab("SETTINGS")end)
hotspot(1085,534,355,63,function()local n,e=clearTextures();status("Cleared "..n.." packs; "..e.." errors")end)
hotspot(1112,656,106,41,function()applyFps("OFF");status("FPS OFF")end)
hotspot(1220,656,111,41,function()applyFps("BALANCED");status("FPS BALANCED")end)
hotspot(1334,656,109,41,function()applyFps("MAX");status("FPS MAX")end)
-- Sky and texture card art is illustrative; each tap opens only real existing entries.
for i=0,4 do
 hotspot(345+i*145,420,125,148,function()openTab("SKIES")end)
 hotspot(345+i*145,614,125,151,function()openTab("TEXTURES")end)
end
hotspot(1368,116,72,73,function()S.Stop()end)
local floating
floating=btn(gui,"♛ V9",UDim2.new(0,14,.5,0),UDim2.fromOffset(80,45),function()root.Visible=true;floating.Visible=false end,true)
floating.Visible=false
hotspot(1328,116,40,73,function()root.Visible=false;floating.Visible=true end)
-- Position changes only from the decorative header, not from game joystick touches.
local dragging=false;local dragInput=nil;local dragStart=nil;local origin=nil
local dragArea=hotspot(325,115,995,180,function()end)
track(dragArea.InputBegan:Connect(function(input)
 if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then
  dragging=true;dragInput=input;dragStart=input.Position;origin=root.Position
 end
end))
track(UIS.InputChanged:Connect(function(input)
 if dragging and dragStart and (input==dragInput or (dragInput.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement)) then
  local d=input.Position-dragStart
  root.Position=UDim2.new(origin.X.Scale,origin.X.Offset+d.X/scaler.Scale,origin.Y.Scale,origin.Y.Offset+d.Y/scaler.Scale)
 end
end))
track(UIS.InputEnded:Connect(function(input)if input==dragInput then dragging=false;dragInput=nil end end))
function S.Stop()
 if not S.alive then return end
 S.alive=false;stopAir();applyFps("OFF");restoreNativeSky()
 for _,c in ipairs(S.connections) do pcall(function()c:Disconnect()end) end
 pcall(function()gui:Destroy()end)
end
print("[TORNHUB V9] Exact reference artwork UI loaded; original 37 skies, 19 texture packs")
