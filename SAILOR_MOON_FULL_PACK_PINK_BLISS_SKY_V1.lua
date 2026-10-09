-- SAILOR MOON FULL PACK - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting");local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset;if not writefile or not G then warn("[Sailor Moon V2] missing asset support")return end
local function rid(v)return tostring(v or ""):match("(%d+)")end
local function fetch(u,f)local ok,b=pcall(function()return game:HttpGet(u)end);if not ok or type(b)~="string"or #b<4 then return end;if not pcall(function()writefile(f,b)end)then return end;local o,a=pcall(function()return G(f)end);if o then return a end end
local R,D={},{}

local a1=fetch("https://github.com/TexPackSearcher/sturdy-octo-meme/blob/main/citrus-enhanced__37_-removebg-preview.png?raw=true","sailormoon_1.png");if a1 then R["133917828562858"]=a1;end
local a2=fetch("https://github.com/TexPackSearcher/animated-garbanzo/blob/main/image-removebg-preview%20(80).png?raw=true","sailormoon_2.png");if a2 then R["121503061771505"]=a2;end
D["18525513345"]="rbxassetid://128891284954593"
local a3=fetch("https://github.com/TexPackSearcher/laughing-enigma/blob/main/image-removebg-preview%20(82).png?raw=true","sailormoon_3.png");if a3 then R["13854780042"]=a3;end
D["177266782"]="rbxassetid://107344784680901"
D["6384899588"]="rbxassetid://117557487340994"
D["17697682466"]="rbxassetid://81106462951841"
D["17733314783"]="rbxassetid://81106462951841"
D["100081814360953"]="rbxassetid://81106462951841"
D["86062306109271"]="rbxassetid://81106462951841"
D["82135261819112"]="rbxassetid://81106462951841"
D["96771526359691"]="rbxassetid://81106462951841"
D["120824068504773"]="rbxassetid://81106462951841"
D["114306049661290"]="rbxassetid://81106462951841"
D["91718252417630"]="rbxassetid://81106462951841"
D["91718252417630"]="rbxassetid://81106462951841"
D["119694504935889"]="rbxassetid://81106462951841"
local a4=fetch("https://github.com/TexPackSearcher/studious-broccoli/blob/main/image-removebg-preview%20(83).png?raw=true","sailormoon_4.png");if a4 then R["16802957270"]=a4;end
local a5=fetch("https://github.com/TexPackSearcher/legendary-giggle/blob/main/image-removebg-preview%20(84).png?raw=true","sailormoon_5.png");if a5 then R["17175092502"]=a5;R["17094014569"]=a5;end
local a6=fetch("https://raw.githubusercontent.com/TexPackSearcher/fantastic-carnival/main/Shardee.ttf?utm_source=chatgpt.com","sailormoon_6.ttf");if a6 then R["12187323909"]=a6;R["12187323909"]=a6;R["12187320363"]=a6;R["12187354260"]=a6;R["12187342816"]=a6;R["12187280273"]=a6;R["12187303601"]=a6;R["12187262242"]=a6;R["12187288714"]=a6;R["12187341500"]=a6;R["12187271237"]=a6;R["12187341020"]=a6;end
local a7=fetch("https://github.com/TexPackSearcher/super-invention/blob/main/image-removebg-preview%20(85).png?raw=true","sailormoon_7.png");if a7 then R["77908042044589"]=a7;end
local a8=fetch("https://github.com/TexPackSearcher/fantastic-chainsaw/blob/main/image-removebg-preview%20(86).png?raw=true","sailormoon_8.png");if a8 then R["75502723232812"]=a8;end
local a9=fetch("https://github.com/TexPackSearcher/expert-robot/blob/main/image-removebg-preview%20(87).png?raw=true","sailormoon_9.png");if a9 then R["7658055825"]=a9;end
D["16530229616"]="rbxassetid://135097031120155"
D["16530229541"]="rbxassetid://135097031120155"
D["16530229695"]="rbxassetid://135097031120155"
local a10=fetch("https://github.com/TexPackSearcher/fantastic-chainsaw/blob/main/image-removebg-preview%20(86).png?raw=true","sailormoon_10.png");if a10 then R["106699686969017"]=a10;end
local a11=fetch("https://github.com/TexPackSearcher/studious-spork/blob/main/image-removebg-preview%20(88).png?raw=true","sailormoon_11.png");if a11 then R["17860400428"]=a11;R["17860400428"]=a11;R["17860673529"]=a11;end
local a12=fetch("https://github.com/TexPackSearcher/solid-broccoli/blob/main/image-removebg-preview%20(89).png?raw=true","sailormoon_12.png");if a12 then R["18185474596"]=a12;end
local a13=fetch("https://github.com/TexPackSearcher/friendly-octo-meme/blob/main/image-removebg-preview%20(90).png?raw=true","sailormoon_13.png");if a13 then R["112615701583145"]=a13;end
D["16770456156"]="rbxassetid://120089981011454"
D["16492958314"]="rbxassetid://120089981011454"
local a14=fetch("https://github.com/TexPackSearcher/silver-octo-giggle/blob/main/image-removebg-preview%20(91).png?raw=true","sailormoon_14.png");if a14 then R["14641612286"]=a14;R["17619445191"]=a14;end
local a15=fetch("https://github.com/TexPackSearcher/fantastic-chainsaw/blob/main/image-removebg-preview%20(86).png?raw=true","sailormoon_15.png");if a15 then R["75502723232812"]=a15;end
local a16=fetch("https://github.com/TexPackSearcher/fuzzy-rotary-phone/blob/main/image-removebg-preview%20(93).png?raw=true","sailormoon_16.png");if a16 then R["17619445340"]=a16;end
local a17=fetch("https://github.com/TexPackSearcher/expert-octo-rotary-phone/blob/main/image-removebg-preview%20(95).png?raw=true","sailormoon_17.png");if a17 then R["14580701813"]=a17;R["14580701813"]=a17;end
local a18=fetch("https://github.com/TexPackSearcher/turbo-system/blob/main/22543f3c-ee3e-454e-82d8-890157de57e9.jpg?raw=true","sailormoon_18.jpg");if a18 then R["108088064658436"]=a18;R["108088064658436"]=a18;end
local a19=fetch("https://github.com/TexPackSearcher/turbo-chainsaw/blob/main/cd685059e2bea390859f64e2f517e4d6-removebg-preview.png?raw=true","sailormoon_19.png");if a19 then R["130876360212411"]=a19;end
local a20=fetch("https://github.com/TexPackSearcher/glowing-octo-dollop/blob/main/6d40ab4e-f46d-46e1-9fcc-f3224ed1a43c.jpg?raw=true","sailormoon_20.jpg");if a20 then R["115188828715635"]=a20;end
local a21=fetch("https://github.com/TexPackSearcher/musical-octo-eureka/blob/main/1f1e34ac-6965-4286-ae28-0d15dbad2678.jpg?raw=true","sailormoon_21.jpg");if a21 then R["78144981625266"]=a21;end
local a22=fetch("https://github.com/TexPackSearcher/didactic-robot/blob/main/bd94b99a-2b45-4f40-8af9-202a787e6e34.jpg?raw=true","sailormoon_22.jpg");if a22 then R["75765063500610"]=a22;end
local a23=fetch("https://github.com/TexPackSearcher/symmetrical-doodle/blob/main/image-removebg-preview%20(96).png?raw=true","sailormoon_23.png");if a23 then R["81461991645938"]=a23;end
local a24=fetch("https://github.com/TexPackSearcher/miniature-disco/blob/main/image-removebg-preview%20-%202026-09-05T161307.594.png?raw=true","sailormoon_24.png");if a24 then R["13220167337"]=a24;R["13188242420"]=a24;R["13220167472"]=a24;R["13188153054"]=a24;R["13188242287"]=a24;end
local a25=fetch("https://github.com/TexPackSearcher/legendary-lamp/blob/main/image-removebg-preview%20-%202026-09-05T180849.718.png?raw=true","sailormoon_25.png");if a25 then R["94935866997293"]=a25;end
local Q,H={},1
local function rep(v)local i=rid(v);return i and(R[i]or D[i])end
local function ins(o)local ps;if o:IsA("Sound")then ps={"SoundId"}elseif o:IsA("Texture")or o:IsA("Decal")then ps={"Texture"}elseif o:IsA("MeshPart")then ps={"TextureID"}elseif o:IsA("ImageLabel")or o:IsA("ImageButton")then ps={"Image"}elseif o:IsA("ParticleEmitter")or o:IsA("Trail")or o:IsA("Beam")then ps={"Texture"}elseif o:IsA("SpecialMesh")then ps={"TextureId","MeshId"}end;if ps then for _,p in ipairs(ps)do local ok,v=pcall(function()return o[p]end);local n=ok and rep(v);if n then Q[#Q+1]={o,p,n}end end end;if o:IsA("TextLabel")or o:IsA("TextButton")or o:IsA("TextBox")then pcall(function()local f=o.FontFace;local n=rep(f.Family);if n then o.FontFace=Font.new(n,f.Weight,f.Style)end end)end end
for i,o in ipairs(game:GetDescendants())do ins(o);if i%250==0 then task.wait()end end
game.DescendantAdded:Connect(function(o)task.defer(function()if o.Parent then ins(o)end end)end)
task.spawn(function()while true do local n=0;while H<=#Q and n<8 do local x=Q[H];H+=1;n+=1;if x[1]and x[1].Parent then pcall(function()x[1][x[2]]=x[3]end)end end;task.wait(.1)end end)
local U={
 Bk="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_bk.tex",
 Dn="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_dn.tex",
 Ft="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_ft.tex",
 Lf="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_lf.tex",
 Rt="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_rt.tex",
 Up="https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_up.tex",
}

local A={}
for _,f in ipairs({"Bk","Dn","Ft","Lf","Rt","Up"}) do
 local u=U[f]
 local ok,bytes=pcall(function() return game:HttpGet(u) end)
 if not ok or type(bytes)~="string" or #bytes<64 then
  warn("[Sailor Moon + Bliss] sky download failed: "..f.." "..tostring(bytes))
  return
 end
 local ext=".png"
 if bytes:sub(1,3)=="\255\216\255" then ext=".jpg"
 elseif bytes:sub(1,4)=="RIFF" then ext=".webp" end
 local path="sailormoon_bliss_sky_"..f..ext
 local wrote,err=pcall(writefile,path,bytes)
 if not wrote then warn("[Sailor Moon + Bliss] save failed "..f..": "..tostring(err));return end
 local got,asset=pcall(G,path)
 if not got or type(asset)~="string" then warn("[Sailor Moon + Bliss] asset failed "..f..": "..tostring(asset));return end
 A[f]=asset
 task.wait()
end

local busy=false
local function freshSky()
 if busy then return end
 busy=true
 for _,x in ipairs(Lighting:GetChildren()) do
  if x:IsA("Sky") then pcall(function() x:Destroy() end) end
 end
 local s=Instance.new("Sky")
 s.Name="SailorMoonPinkBlissFreshSky"
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
Lighting.ChildAdded:Connect(function(x)
 if x:IsA("Sky") and x.Name~="SailorMoonPinkBlissFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,freshSky)
  end
 end
end)

pcall(function()
 StarterGui:SetCore("SendNotification",{Title="Sailor Moon + Pink Bliss",Text="Sailor Moon pack + Pink Bliss sky loaded",Duration=6})
end)
