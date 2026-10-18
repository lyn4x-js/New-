-- TORNHUB V9 FAST LOAD | iPad / Delta
-- Fast boot: no large skybox downloads until APPLY. Reuse scripts within session.
-- Preserves V8 via launch button; 19 texture links, 5 JSON sky configurations.
-- Art asset must be uploaded to Roblox and set in BANNER_ASSET below.
local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local RunService=game:GetService("RunService")
local player=Players.LocalPlayer
local env=(getgenv and getgenv()) or _G
if env.TORNHUB_V9 and env.TORNHUB_V9.Stop then pcall(env.TORNHUB_V9.Stop) end
local S={alive=true,connections={},fps="OFF",saved={},modified={},skyEngine=nil,activeAir=nil,scriptCache={}}
env.TORNHUB_V9=S
local function track(c) table.insert(S.connections,c) return c end
local ORANGE=Color3.fromRGB(255,115,16)
local DARK=Color3.fromRGB(12,12,16)
local PANEL=Color3.fromRGB(22,22,29)
local WHITE=Color3.fromRGB(247,242,237)
local BANNER_ASSET="" -- set to rbxassetid://YOUR_UPLOADED_IMAGE_ID
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
 {"Halloween","New","https://raw.githubusercontent.com/lyn4x-js/New-/main/HALLOWEEN_TEXTURES_iPad_ADAPTIVE_V1.lua"},
 {"Minecraft","New","https://raw.githubusercontent.com/lyn4x-js/New-/main/MINECRAFT_TEXTURES_iPad_ADAPTIVE_V1.lua"},
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
local function clearTextures()
 local count=0
 -- Newer texture modules expose cleanup functions; legacy packs may not.
 for key,mod in pairs(env) do
  if type(key)=='string' and (key:find('TEXTURE') or key:find('Texture')) and type(mod)=='table' then
   local fn=mod.remove or mod.Remove or mod.close or mod.Close
   if type(fn)=='function' then
    local ok=pcall(fn);if ok then count=count+1 end
   end
  end
 end
 return count
end
local gui=Instance.new("ScreenGui")
gui.Name="TORNHUB_V9_GUI";gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true
gui.Parent=player:WaitForChild("PlayerGui")
local function mk(cl,parent,props)
 local o=Instance.new(cl)
 for k,v in pairs(props or {}) do o[k]=v end
 o.Parent=parent;return o
end
local function round(o,r)mk("UICorner",o,{CornerRadius=UDim.new(0,r or 10)});return o end
local function stroke(o,col,th)mk("UIStroke",o,{Color=col or ORANGE,Thickness=th or 1,Transparency=.25})end
local function label(parent,t,sz,props)
 local p={BackgroundTransparency=1,Text=t,TextColor3=WHITE,TextSize=sz or 14,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left}
 for k,v in pairs(props or {}) do p[k]=v end
 return mk("TextLabel",parent,p)
end
local function button(parent,t,props)
 local p={Text=t,TextColor3=WHITE,TextSize=13,Font=Enum.Font.GothamBold,BackgroundColor3=PANEL,AutoButtonColor=true,BorderSizePixel=0}
 for k,v in pairs(props or {}) do p[k]=v end
 return round(mk("TextButton",parent,p),8)
end
local win=round(mk("Frame",gui,{Size=UDim2.fromOffset(800,510),Position=UDim2.new(.5,-400,.5,-255),BackgroundColor3=DARK,BorderSizePixel=0,ClipsDescendants=true}),14)
stroke(win,ORANGE,2)
local scale=mk("UIScale",win,{Scale=1})
local function autoscale()
 local cam=workspace.CurrentCamera
 if not cam then return end
 local v=cam.ViewportSize
 scale.Scale=math.clamp(math.min(v.X/840,v.Y/555),.46,1.05)
end
autoscale()
if workspace.CurrentCamera then track(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(autoscale)) end
local header=mk("Frame",win,{Size=UDim2.new(1,0,0,116),BackgroundColor3=Color3.fromRGB(25,14,12),BorderSizePixel=0})
local grad=mk("UIGradient",header,{Color=ColorSequence.new(Color3.fromRGB(48,21,13),Color3.fromRGB(10,10,15)),Rotation=0})
if BANNER_ASSET~="" then mk("ImageLabel",header,{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Image=BANNER_ASSET,ScaleType=Enum.ScaleType.Crop,ImageTransparency=.18}) end
label(header,"♛  TORNHUB V9",29,{Position=UDim2.fromOffset(18,20),Size=UDim2.fromOffset(430,40),Font=Enum.Font.GothamBlack,TextColor3=ORANGE})
label(header,"ROBLOX RIVALS  •  Dominate Differently",13,{Position=UDim2.fromOffset(22,64),Size=UDim2.fromOffset(450,22)})
label(header,"✦  ✧  ◇  ✦  ✧",20,{Position=UDim2.fromOffset(495,45),Size=UDim2.fromOffset(210,30),TextColor3=ORANGE})
local close=button(header,"✕",{Position=UDim2.new(1,-40,0,9),Size=UDim2.fromOffset(30,30),BackgroundColor3=Color3.fromRGB(97,38,12)})
local minimize=button(header,"—",{Position=UDim2.new(1,-78,0,9),Size=UDim2.fromOffset(30,30)})
local nav=mk("Frame",win,{Position=UDim2.fromOffset(9,123),Size=UDim2.fromOffset(152,348),BackgroundColor3=Color3.fromRGB(17,17,21),BorderSizePixel=0})
round(nav,10)
local content=mk("Frame",win,{Position=UDim2.fromOffset(169,123),Size=UDim2.new(1,-181,1,-166),BackgroundTransparency=1})
local footer=label(win,"● TORNHUB V9 ACTIVE    |    iPad / Delta    |    Drag header • Resize corner",11,{Position=UDim2.new(0,15,1,-32),Size=UDim2.new(1,-35,0,25),TextColor3=ORANGE})
local search=round(mk("TextBox",content,{Size=UDim2.new(1,-8,0,34),Position=UDim2.fromOffset(3,0),Text="",PlaceholderText="⌕ Search skies, textures, options...",TextColor3=WHITE,PlaceholderColor3=Color3.fromRGB(150,150,158),TextSize=13,Font=Enum.Font.Gotham,BackgroundColor3=PANEL,ClearTextOnFocus=false,BorderSizePixel=0}),8)
local body=mk("ScrollingFrame",content,{Position=UDim2.fromOffset(3,43),Size=UDim2.new(1,-8,1,-44),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=4,ScrollBarImageColor3=ORANGE,CanvasSize=UDim2.new()})
local layout=mk("UIListLayout",body,{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder})
track(layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()body.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y+12)end))
local function clearBody()for _,o in ipairs(body:GetChildren())do if o~=layout then o:Destroy()end end end
local status="Fast boot: skies load when selected"
local function rowTitle(t)
 label(body,t,16,{Size=UDim2.new(1,-10,0,28),Font=Enum.Font.GothamBold,TextColor3=ORANGE})
end
local function action(t,desc,fn)
 local r=round(mk("Frame",body,{Size=UDim2.new(1,-8,0,54),BackgroundColor3=PANEL,BorderSizePixel=0}),8)
 label(r,t,14,{Position=UDim2.fromOffset(12,6),Size=UDim2.new(1,-120,0,23),Font=Enum.Font.GothamBold})
 label(r,desc,10,{Position=UDim2.fromOffset(12,30),Size=UDim2.new(1,-120,0,17),TextColor3=Color3.fromRGB(170,165,160)})
 local b=button(r,"APPLY",{Position=UDim2.new(1,-102,.5,-17),Size=UDim2.fromOffset(90,34),BackgroundColor3=Color3.fromRGB(156,66,13)})
 b.MouseButton1Click:Connect(function()
  b.Text="WAIT...";task.spawn(function()local ok,msg=pcall(fn);b.Text=ok and "DONE" or "ERROR";if not ok then warn("[TORNHUB V9]",msg)end;task.wait(1.4);if b.Parent then b.Text="APPLY"end end)
 end)
 return r
end
local function launch(t,url)action(t,"Runs the linked Lua script",function()local ok,err=runUrl(url);if not ok then error(err)end end)end
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
 for index,obj in ipairs(workspace:GetDescendants())do
  if index % 350 == 0 then task.wait() end
  if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then change(obj,"Enabled",false)
  elseif mode=="MAX" and (obj:IsA("BloomEffect") or obj:IsA("SunRaysEffect") or obj:IsA("DepthOfFieldEffect")) then change(obj,"Enabled",false)
  elseif mode=="MAX" and obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character or player) then
   change(obj,"CastShadow",false)
  end
 end
end
local tabs={"HOME","SKIES","TEXTURES","AIR SLIDES","PERFORMANCE","CHARACTERS","SETTINGS"}
local navButtons={};local current="HOME";local render
for i,name in ipairs(tabs)do
 local b=button(nav,name,{Position=UDim2.fromOffset(6,6+(i-1)*46),Size=UDim2.fromOffset(140,39),TextXAlignment=Enum.TextXAlignment.Left,BackgroundColor3=PANEL})
 navButtons[name]=b
 b.MouseButton1Click:Connect(function()current=name;search.Text="";render()end)
end
local function renderRowFilter(q)
 for _,item in ipairs(body:GetChildren())do
  if item:IsA("Frame") then local title=item:FindFirstChildWhichIsA("TextLabel");item.Visible=not title or q=="" or string.find(string.lower(title.Text),q,1,true)~=nil end
 end
end
render=function()
 clearBody()
 for name,b in pairs(navButtons)do b.BackgroundColor3=name==current and Color3.fromRGB(175,68,10) or PANEL end
 if current=="HOME" then
  rowTitle("WELCOME TO TORNHUB V9")
  action("SKIES  •  37 PRESETS","Choose a sky inside V9",function()current="SKIES";render()end)
  action("TEXTURES  •  19 PACKS","Launch packs inside V9",function()current="TEXTURES";render()end)
  action("AIR SLIDES  •  2 MODES","Turn either mode ON or OFF",function()current="AIR SLIDES";render()end)
  action("FPS BOOSTER","Off / Balanced / Max",function()current="PERFORMANCE";render()end)
  action("CLEAR TEXTURES","Restore supported texture changes",function()local n=clearTextures();print('[V9] Texture cleanup handlers:',n)end)
  rowTitle("NEON ORANGE  •  IPAD  •  TOUCH FRIENDLY")
 elseif current=="TEXTURES" then
  rowTitle("TEXTURE PACKS  •  19")
  action("CLEAR TEXTURES","Calls supported pack cleanup handlers",function()local n=clearTextures();print('[V9] Cleaned texture handlers:',n)end)
  for _,p in ipairs(packs)do launch(p[1],p[3])end
 elseif current=="SKIES" then
  rowTitle("SKYBOXES  •  37")
  action("RESTORE ORIGINAL SKY","Undo V9 sky selection",function()local e=ensureSkyEngine();local ok,msg=e.Reset();if not ok then error(msg)end end)
  for _,name in ipairs(skyNames) do
   action(name,"Apply sky directly from V9",function()
    local e=ensureSkyEngine();local ok,msg=e.Apply(name);if not ok then error(msg)end
   end)
  end
 elseif current=="AIR SLIDES" then
  rowTitle("AIR SLIDE  •  DIRECT TOGGLES")
  for i,entry in ipairs(airVersions) do
   action(entry[1]..(S.activeAir==i and "  [ON]" or "  [OFF]"),"Tap to toggle • only one active",function()setAir(i);render()end)
  end
  action("TURN AIR SLIDES OFF","Disable and clean up all slide platforms",function()stopAir();render()end)
  label(body,"Air-slide platforms are local-only; RIVALS may reject them.",12,{Size=UDim2.new(1,-15,0,42),TextWrapped=true,TextColor3=ORANGE})
 elseif current=="PERFORMANCE" then
  rowTitle("FPS BOOSTER  •  PERFORMANCE MODES")
  for _,mode in ipairs({"OFF","BALANCED","MAX"})do
   action(mode..(S.fps==mode and "  ✓" or ""),mode=="OFF" and "Restore saved graphics" or mode=="BALANCED" and "Reduce particles and shadows" or "Also disable post effects and part shadows",function()applyFps(mode);render()end)
  end
  label(body,"Graphics changes are client-side. FPS gains vary by device.\nTurning OFF restores saved properties where possible.",12,{Size=UDim2.new(1,-12,0,56),TextWrapped=true})
 elseif current=="CHARACTERS" then
  rowTitle("CHARACTER THEMES")
  label(body,"Catgirl • Nurse • Gothic Twin-Tail\nUpload the approved artwork as a Roblox image asset and set BANNER_ASSET in this script. No avatar changes are made.",13,{Size=UDim2.new(1,-15,0,95),TextWrapped=true})
 elseif current=="SETTINGS" then
  rowTitle("WINDOW CONTROLS")
  action("Minimize menu","Use floating V9 button to reopen",function()win.Visible=false end)
  action("Reset menu size","Restore standard size and position",function()win.Size=UDim2.fromOffset(800,510);win.Position=UDim2.new(.5,-400,.5,-255);autoscale()end)
  action("FPS Booster OFF","Restore saved graphics properties",function()applyFps("OFF")end)
 end
 if search.Text~="" then renderRowFilter(string.lower(search.Text))end
end
track(search:GetPropertyChangedSignal("Text"):Connect(function()renderRowFilter(string.lower(search.Text))end))
local floating=button(gui,"♛ V9",{Size=UDim2.fromOffset(76,43),Position=UDim2.new(0,14,.5,0),BackgroundColor3=Color3.fromRGB(175,68,10),Visible=false,ZIndex=20})
stroke(floating)
local function toggle()win.Visible=not win.Visible;floating.Visible=not win.Visible end
minimize.MouseButton1Click:Connect(toggle)
floating.MouseButton1Click:Connect(toggle)
local dragging=false;local dragStart;local origin
track(header.InputBegan:Connect(function(input)
 if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=input.Position;origin=win.Position end
end))
track(UIS.InputChanged:Connect(function(input)
 if dragging and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseMovement) then
  local delta=input.Position-dragStart
  win.Position=UDim2.new(origin.X.Scale,origin.X.Offset+delta.X/scale.Scale,origin.Y.Scale,origin.Y.Offset+delta.Y/scale.Scale)
 end
end))
track(UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end))
local grip=button(win,"◢",{Size=UDim2.fromOffset(32,30),Position=UDim2.new(1,-34,1,-32),BackgroundTransparency=1,TextColor3=ORANGE,ZIndex=11})
local resizing=false;local startPos;local startSize
track(grip.InputBegan:Connect(function(input)if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then resizing=true;startPos=input.Position;startSize=win.Size end end))
track(UIS.InputChanged:Connect(function(input)
 if resizing and (input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseMovement) then
  local d=(input.Position-startPos)/scale.Scale
  win.Size=UDim2.fromOffset(math.clamp(startSize.X.Offset+d.X,550,1050),math.clamp(startSize.Y.Offset+d.Y,380,730))
 end
end))
track(UIS.InputEnded:Connect(function(input)if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then resizing=false end end))
function S.Stop()
 if not S.alive then return end
 S.alive=false;stopAir();applyFps("OFF")
 for _,c in ipairs(S.connections)do pcall(function()c:Disconnect()end)end
 pcall(function()gui:Destroy()end)
end
close.MouseButton1Click:Connect(function()S.Stop()end)
render()
print("[TORNHUB V9] Integrated controls loaded: 37 skies, 19 texture launchers, two Air Slides, FPS modes")
