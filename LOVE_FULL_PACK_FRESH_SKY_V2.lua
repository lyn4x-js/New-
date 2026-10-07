-- LOVE FULL PACK - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local env=(getgenv and getgenv()) or _G
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Love V2] missing asset support") return end

local KEY="__LOVE_FULL_PACK_FRESH_SKY_V2"
if env[KEY] and env[KEY].connections then
 for _,c in ipairs(env[KEY].connections) do pcall(function() c:Disconnect() end) end
end
local state={connections={},running=true}
env[KEY]=state
local function keep(c) if c then table.insert(state.connections,c) end end

local function rid(v) return tostring(v or ""):match("(%d+)") end
local function fetch(u,f)
 local ok,b=pcall(function() return game:HttpGet(u) end)
 if not ok or type(b)~="string" or #b<4 then return nil end
 if not pcall(function() writefile(f,b) end) then return nil end
 local ok2,a=pcall(function() return G(f) end)
 if ok2 then return a end
end

local R,D={},{}
local a1=fetch("https://github.com/TexPackSearcher/reimagined-invention/blob/main/image-removebg-preview%20-%202026-09-19T005439.943.png?raw=true","love_1.png")
if a1 then R["7658055825"]=a1; end
local a2=fetch("https://github.com/TexPackSearcher/supreme-memory/blob/main/image-removebg-preview%20-%202026-09-19T111622.413.png?raw=true","love_2.png")
if a2 then R["133917828562858"]=a2;R["121503061771505"]=a2; end
local a3=fetch("https://github.com/TexPackSearcher/expert-octo-train/blob/main/image-removebg-preview%20-%202026-09-19T112209.075.png?raw=true","love_3.png")
if a3 then R["138558684155020"]=a3; end
local a4=fetch("https://github.com/TexPackSearcher/psychic-chainsaw/blob/main/image-removebg-preview%20-%202026-09-19T112747.123.png?raw=true","love_4.png")
if a4 then R["80370960369204"]=a4; end
local a5=fetch("https://github.com/TexPackSearcher/musical-fiesta/blob/main/image-removebg-preview%20-%202026-09-19T113014.186.png?raw=true","love_5.png")
if a5 then R["91611814756850"]=a5; end
D["16737738420"]="rbxassetid://115858660899251"
local a6=fetch("https://github.com/TexPackSearcher/sturdy-journey/blob/main/image-removebg-preview%20-%202026-09-19T114913.185.png?raw=true","love_6.png")
if a6 then R["92965690658072"]=a6; end
local a7=fetch("https://github.com/TexPackSearcher/supreme-memory/blob/main/image-removebg-preview%20-%202026-09-19T111622.413.png?raw=true","love_7.png")
if a7 then R["102193196101741"]=a7; end
local a8=fetch("https://github.com/TexPackSearcher/ea/blob/main/image-removebg-preview%20-%202026-09-19T115444.584.png?raw=true","love_8.png")
if a8 then R["112615701583145"]=a8; end
local a9=fetch("https://github.com/TexPackSearcher/bookish-palm-treed/blob/main/image-removebg-preview%20-%202026-09-19T115817.236.png?raw=true","love_9.png")
if a9 then R["110291144710849"]=a9; end
local a10=fetch("https://github.com/TexPackSearcher/shiny-barnacles/blob/main/image-removebg-preview%20-%202026-09-19T124035.244.png?raw=true","love_10.png")
if a10 then R["113510944677126"]=a10; end
local a11=fetch("https://github.com/TexPackSearcher/shiny-barnacles/blob/main/image-removebg-preview%20-%202026-09-19T124035.244.png?raw=true","love_11.png")
if a11 then R["17136633510"]=a11; end
local a12=fetch("https://github.com/TexPackSearcher/vigilant-spoon/blob/main/image-removebg-preview%20-%202026-09-19T124243.707.png?raw=true","love_12.png")
if a12 then R["88012714630436"]=a12; end
local a13=fetch("https://github.com/TexPackSearcher/vigilant-spoon/blob/main/image-removebg-preview%20-%202026-09-19T124243.707.png?raw=true","love_13.png")
if a13 then R["17136633356"]=a13; end
local a14=fetch("https://github.com/TexPackSearcher/sturdy-octo-fortnight/blob/main/image-removebg-preview%20-%202026-09-19T124447.195.png?raw=true","love_14.png")
if a14 then R["14641612286"]=a14;R["17619445191"]=a14; end
local a15=fetch("https://github.com/TexPackSearcher/congenial-octo-engine/blob/main/image-removebg-preview%20-%202026-09-19T124604.490.png?raw=true","love_15.png")
if a15 then R["17619445340"]=a15; end
local a16=fetch("https://github.com/TexPackSearcher/congenial-octo-umbrella/blob/main/image-removebg-preview%20-%202026-09-19T124849.488.png?raw=true","love_16.png")
if a16 then R["17838290166"]=a16;R["17619444538"]=a16;R["108220438104376"]=a16; end
local a17=fetch("https://raw.githubusercontent.com/TexPackSearcher/verbose-pancake/main/speech_1789751822555.mp3","love_17.mp3")
if a17 then R["6384899588"]=a17;R["6384899588"]=a17; end
D["16530229616"]="rbxassetid://71784668532977"
D["16530229541"]="rbxassetid://71784668532977"
D["16530229695"]="rbxassetid://71784668532977"
local a18=fetch("https://github.com/TexPackSearcher/symmetrical-winner/blob/main/image-removebg-preview%20-%202026-09-19T125817.829.png?raw=true","love_18.png")
if a18 then R["17495953350"]=a18;R["17495953455"]=a18;R["17860400428"]=a18;R["17860673529"]=a18; end
local a19=fetch("https://github.com/TexPackSearcher/super-bassoon/blob/main/image-removebg-preview%20-%202026-09-19T125948.035.png?raw=true","love_19.png")
if a19 then R["18185474596"]=a19; end
local a20=fetch("https://github.com/TexPackSearcher/legendary-funicular/blob/main/image-removebg-preview%20-%202026-09-19T130553.013.png?raw=true","love_20.png")
if a20 then R["13854780213"]=a20; end
local a21=fetch("https://github.com/TexPackSearcher/super-duper-octo-engine/blob/main/image-removebg-preview%20-%202026-09-19T130736.126.png?raw=true","love_21.png")
if a21 then R["92965690658072"]=a21; end
local a22=fetch("https://github.com/TexPackSearcher/crispy-system/blob/main/image-removebg-preview%20-%202026-09-19T142809.396.png?raw=true","love_22.png")
if a22 then R["17803962335"]=a22; end

local Q,H={},1
local function rep(v)
 local i=rid(v)
 return i and (R[i] or D[i])
end

local function inspect(o)
 local ps
 if o:IsA("Sound") then ps={"SoundId"}
 elseif o:IsA("Texture") or o:IsA("Decal") then ps={"Texture"}
 elseif o:IsA("MeshPart") then ps={"TextureID"}
 elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then ps={"Image"}
 elseif o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then ps={"Texture"}
 elseif o:IsA("SpecialMesh") then ps={"TextureId","MeshId"}
 elseif o:IsA("Shirt") then ps={"ShirtTemplate"}
 elseif o:IsA("Pants") then ps={"PantsTemplate"}
 elseif o:IsA("ShirtGraphic") then ps={"Graphic"} end

 if ps then
  for _,p in ipairs(ps) do
   local ok,v=pcall(function() return o[p] end)
   local n=ok and rep(v)
   if n and n~=v then Q[#Q+1]={o,p,n} end
  end
 end
end

for i,o in ipairs(game:GetDescendants()) do
 inspect(o)
 if i%250==0 then task.wait() end
end

keep(game.DescendantAdded:Connect(function(o)
 task.defer(function()
  if env[KEY]==state and o.Parent then inspect(o) end
 end)
end))

task.spawn(function()
 while state.running and env[KEY]==state do
  local n=0
  while H<=#Q and n<8 do
   local x=Q[H]
   H+=1
   n+=1
   if x[1] and x[1].Parent then
    pcall(function() x[1][x[2]]=x[3] end)
   end
  end
  task.wait(.10)
 end
end)

local U={
 Bk="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skybk.png",
 Dn="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skydn.png",
 Ft="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyft.png",
 Lf="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skylf.png",
 Rt="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyrt.png",
 Up="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyup.png",
}
}

local A={}
for f,u in pairs(U) do
 local a=fetch(u,"love_sky_"..f..".png")
 if not a then warn("[Love V2] sky failed "..f) return end
 A[f]=a
end

local busy=false
local function freshSky()
 if busy then return end
 busy=true
 for _,x in ipairs(Lighting:GetChildren()) do
  if x:IsA("Sky") then pcall(function() x:Destroy() end) end
 end
 local s=Instance.new("Sky")
 s.Name="LoveFreshSky"
 s.SkyboxBk=A.Bk
 s.SkyboxDn=A.Dn
 s.SkyboxFt=A.Ft
 s.SkyboxLf=A.Lf
 s.SkyboxRt=A.Rt
 s.SkyboxUp=A.Up
 s.Parent=Lighting
 busy=false
end

freshSky()
for _,t in ipairs({.5,1.5,3,6,10}) do task.delay(t,freshSky) end

local last=0
keep(Lighting.ChildAdded:Connect(function(x)
 if x:IsA("Sky") and x.Name~="LoveFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,freshSky)
  end
 end
end))

pcall(function()
 StarterGui:SetCore("SendNotification",{Title="Love Pack V2",Text="Full pack + Fresh Sky loaded",Duration=6})
end)

print("[Love V2] full pack loaded")
