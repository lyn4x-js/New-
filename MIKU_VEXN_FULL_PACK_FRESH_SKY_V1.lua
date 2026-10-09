-- Miku Vexn full pack | Delta iPad
local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Miku] Missing local asset functions") return end
local function fetch(u,f)
 local ok,b=pcall(function()return game:HttpGet(u)end)
 if not ok or type(b)~="string" or #b<32 then warn("[Miku] Download failed "..f);return end
 if not pcall(writefile,f,b) then warn("[Miku] Save failed "..f);return end
 local yes,a=pcall(G,f);if yes and type(a)=="string" then return a end
end
local R={}
-- textures
local a1=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/lv_0_20260927112424.png?raw=true","miku_vexn_1.png")
if a1 then R["7658055825"]=a1; end
-- slide
local a2=fetch("https://github.com/jadrentillo04-ai/Fleasion-/raw/refs/heads/main/sparkle.wav","miku_vexn_2.wav")
if a2 then R["16737738420"]=a2; end
-- all backround
local a3=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/image_2840f8f8.png?raw=true","miku_vexn_3.png")
if a3 then R["13220167337"]=a3;R["13188242420"]=a3;R["13220167472"]=a3;R["13188153054"]=a3;R["13188242287"]=a3; end
-- kILL SOUND
local a4=fetch("https://github.com/jadrentillo04-ai/Fleasion-/raw/refs/heads/main/0911.MP3","miku_vexn_4.mp3")
if a4 then R["16530229616"]=a4;R["16530229541"]=a4;R["16530229695"]=a4; end
-- load in sound
local a5=fetch("https://github.com/jadrentillo04-ai/miku/raw/refs/heads/main/Screen_Recording_20260927_113857~2.mp3","miku_vexn_5.mp3")
if a5 then R["6384899588"]=a5; end
-- N to miku
local a6=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/Split%201.png?raw=true","miku_vexn_6.png")
if a6 then R["13854780042"]=a6; end
-- Double jump
local a7=fetch("https://github.com/jadrentillo04-ai/Fleasion-/raw/refs/heads/main/mario-meow.mp3","miku_vexn_7.mp3")
if a7 then R["16770456156"]=a7; end
-- G to nino
local a8=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/Split%202.png?raw=true","miku_vexn_8.png")
if a8 then R["13854780213"]=a8; end
-- small mikuuu!
local a9=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/small%20miku%20XD.png?raw=true","miku_vexn_9.png")
if a9 then R["133917828562858"]=a9; end
-- rivals to miku
local a10=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/miku.png?raw=true","miku_vexn_10.png")
if a10 then R["17803962335"]=a10; end
-- font
local a11=fetch("https://github.com/jadrentillo04-ai/miku/raw/refs/heads/main/Yellow_Banana%5B1%5D.otf","miku_vexn_11.otf")
if a11 then R["12187320363"]=a11; end
-- fonts
local a12=fetch("https://github.com/jadrentillo04-ai/miku/raw/refs/heads/main/Yellow_Banana%5B1%5D.otf","miku_vexn_12.otf")
if a12 then R["12187323909"]=a12;R["12187320363"]=a12;R["12187354260"]=a12;R["12187342816"]=a12;R["12187280273"]=a12;R["12187303601"]=a12;R["12187262242"]=a12;R["12187288714"]=a12;R["12187341500"]=a12;R["12187271237"]=a12;R["12187341020"]=a12; end
-- you died
local a13=fetch("https://github.com/jadrentillo04-ai/miku/blob/main/miku.png?raw=true","miku_vexn_13.png")
if a13 then R["16802957270"]=a13; end
local function inspect(o)
 local ps
 if o:IsA("Sound") then ps={"SoundId"} elseif o:IsA("Decal") or o:IsA("Texture") then ps={"Texture"} elseif o:IsA("MeshPart") then ps={"TextureID"} elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then ps={"Image"} elseif o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then ps={"Texture"} elseif o:IsA("SpecialMesh") then ps={"TextureId"} end
 if ps then for _,prop in ipairs(ps) do local ok,v=pcall(function()return o[prop]end);local id=ok and tostring(v):match("(%d+)");local n=id and R[id];if n then pcall(function()o[prop]=n end) end end end
 if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then pcall(function()local f=o.FontFace;local id=tostring(f.Family):match("(%d+)");local n=id and R[id];if n then o.FontFace=Font.new(n,f.Weight,f.Style) end end) end
end
for i,o in ipairs(game:GetDescendants()) do inspect(o);if i%250==0 then task.wait() end end
game.DescendantAdded:Connect(function(o)task.defer(function()if o.Parent then inspect(o)end end)end)
local U={
Bk="https://github.com/jadrentillo04-ai/miku/blob/main/lv_0_20260927090156.jpg?raw=true",
Dn="https://github.com/jadrentillo04-ai/miku/blob/main/b2a5b0e35439b3e4b54b0858d064936f%20(2).jpg?raw=true",
Ft="https://github.com/jadrentillo04-ai/miku/blob/main/lv_0_20260927043432.jpg?raw=true",
Lf="https://github.com/jadrentillo04-ai/miku/blob/main/hfhhghnyghunrhnghnhgjun.jpg?raw=true",
Rt="https://github.com/jadrentillo04-ai/miku/blob/main/lv_0_20260927085914.jpg?raw=true",
Up="https://github.com/jadrentillo04-ai/miku/blob/main/b2a5b0e35439b3e4b54b0858d064936f%20(2).jpg?raw=true",
}
local A={};local good=true
for _,f in ipairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
 local a=fetch(U[f],"miku_vexn_sky_"..f..".jpg")
 if not a then good=false;break end
 A[f]=a
end
if good then
 local busy=false
 local function fresh()
  if busy then return end;busy=true
  local s=Instance.new("Sky");s.Name="MikuVexnFreshSky"
  s.SkyboxBk=A.Bk;s.SkyboxDn=A.Dn;s.SkyboxFt=A.Ft;s.SkyboxLf=A.Lf;s.SkyboxRt=A.Rt;s.SkyboxUp=A.Up
  for _,x in ipairs(Lighting:GetChildren()) do if x:IsA("Sky") then x:Destroy() end end
  s.Parent=Lighting;busy=false
 end
 fresh();for _,t in ipairs({.5,1.5,3,6,10}) do task.delay(t,fresh) end
 local last=0
 Lighting.ChildAdded:Connect(function(x)if x:IsA("Sky") and x.Name~="MikuVexnFreshSky" then local n=os.clock();if n-last>.5 then last=n;task.delay(.15,fresh) end end end)
else warn("[Miku] Sky download failed; original sky kept") end
pcall(function()StarterGui:SetCore("SendNotification",{Title="Miku Vexn",Text=good and "Miku pack and sky applied" or "Miku pack loaded; sky failed",Duration=6})end)
