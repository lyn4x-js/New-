-- DARK HEAVEN FULL PACK - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local env=(getgenv and getgenv()) or _G
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Dark Heaven V2] missing asset support") return end

local KEY="__DARK_HEAVEN_FRESH_SKY_V2"
if env[KEY] and env[KEY].connections then
 for _,c in ipairs(env[KEY].connections) do pcall(function() c:Disconnect() end) end
end
local state={connections={},running=true}; env[KEY]=state
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
local a1=fetch("https://files.catbox.moe/5ctk9w.png","darkheaven_1.png")
if a1 then R["7658055825"]=a1; end
local a2=fetch("https://files.catbox.moe/w01jtv.otf","darkheaven_2.otf")
if a2 then R["12187323909"]=a2;R["12187323909"]=a2;R["12187320363"]=a2;R["12187354260"]=a2;R["12187342816"]=a2;R["12187280273"]=a2;R["12187303601"]=a2;R["12187262242"]=a2;R["12187288714"]=a2;R["12187341500"]=a2;R["12187271237"]=a2;R["12187341020"]=a2; end
local a3=fetch("https://files.catbox.moe/ub7f65.mp3","darkheaven_3.mp3")
if a3 then R["16530229616"]=a3;R["16530229541"]=a3;R["16530229695"]=a3; end
local a4=fetch("https://files.catbox.moe/e25tbs.png","darkheaven_4.png")
if a4 then R["13854780042"]=a4; end
local a5=fetch("https://files.catbox.moe/hw44jm.jpeg","darkheaven_5.jpeg")
if a5 then R["13854780213"]=a5; end
local a6=fetch("https://files.catbox.moe/lt4npd.png","darkheaven_6.png")
if a6 then R["13220167337"]=a6;R["13188242420"]=a6;R["13220167472"]=a6;R["13188153054"]=a6;R["13188242287"]=a6; end
local a7=fetch("https://files.catbox.moe/mz5kbm.png","darkheaven_7.png")
if a7 then R["133917828562858"]=a7;R["121503061771505"]=a7; end
D["13110130082"]="rbxassetid://7149255551"
D["16810041280"]="rbxassetid://8573766100"
D["177266782"]="rbxassetid://15675059323"
D["6384899588"]="rbxassetid://128842283247970"
D["16770456156"]="rbxassetid://139862334730263"
D["16492958314"]="rbxassetid://139862334730263"
local a8=fetch("https://files.catbox.moe/tkv2hj.mp3","darkheaven_8.mp3")
if a8 then R["16737738420"]=a8; end
D["16810321565"]="rbxassetid://117549414117960"

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

 if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
  pcall(function()
   local f=o.FontFace
   local n=rep(f.Family)
   if n then o.FontFace=Font.new(n,f.Weight,f.Style) end
  end)
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
   local x=Q[H]; H+=1; n+=1
   if x[1] and x[1].Parent then pcall(function() x[1][x[2]]=x[3] end) end
  end
  task.wait(.10)
 end
end)

local U={
 Bk="https://files.catbox.moe/zf8vzl.png",
 Dn="https://files.catbox.moe/5bcuo3.png",
 Ft="https://files.catbox.moe/u4fieb.png",
 Lf="https://files.catbox.moe/fnj2yp.png",
 Rt="https://files.catbox.moe/3lznl9.png",
 Up="https://files.catbox.moe/3mohks.png",
}
local A={}
for f,u in pairs(U) do
 local a=fetch(u,"darkheaven_sky_"..f..".png")
 if not a then warn("[Dark Heaven V2] sky failed "..f) return end
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
 s.Name="DarkHeavenFreshSky"
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
 if x:IsA("Sky") and x.Name~="DarkHeavenFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,freshSky)
  end
 end
end))

pcall(function()
 StarterGui:SetCore("SendNotification",{Title="Dark Heaven V2",Text="Full pack + Fresh Sky loaded",Duration=6})
end)
