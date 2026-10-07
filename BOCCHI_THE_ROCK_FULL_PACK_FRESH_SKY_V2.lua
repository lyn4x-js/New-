-- BOCCHI THE ROCK FULL PACK - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting");local StarterGui=game:GetService("StarterGui")
local env=(getgenv and getgenv()) or _G;local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Bocchi V2] missing asset support")return end
local KEY="__BOCCHI_FRESH_SKY_V2"
if env[KEY]and env[KEY].connections then for _,c in ipairs(env[KEY].connections)do pcall(function()c:Disconnect()end)end end
local state={connections={},running=true};env[KEY]=state
local function keep(c)if c then table.insert(state.connections,c)end end
local function rid(v)return tostring(v or ""):match("(%d+)")end
local function fetch(u,f)local ok,b=pcall(function()return game:HttpGet(u)end);if not ok or type(b)~="string"or #b<4 then return end;if not pcall(function()writefile(f,b)end)then return end;local o,a=pcall(function()return G(f)end);if o then return a end end
local R,D={},{}
local a1=fetch("https://github.com/TexPackSearcher/refactored-spoon/blob/main/image-removebg-preview%20-%202026-09-05T124017.269.png?raw=true","bocchi_1.png");if a1 then R["7658055825"]=a1;end
local a2=fetch("https://github.com/TexPackSearcher/ubiquitous-octo-dollop/blob/main/image-removebg-preview%20-%202026-09-05T124403.181.png?raw=true","bocchi_2.png");if a2 then R["17803962335"]=a2;end
local a3=fetch("https://github.com/TexPackSearcher/fictional-spork/blob/main/image-removebg-preview%20-%202026-09-05T124814.561.png?raw=true","bocchi_3.png");if a3 then R["13854780042"]=a3;end
local a4=fetch("https://github.com/TexPackSearcher/scaling-chainsaw/blob/main/image-removebg-preview%20-%202026-09-05T125242.303.png?raw=true","bocchi_4.png");if a4 then R["18185474596"]=a4;end
local a5=fetch("https://github.com/TexPackSearcher/probable-spork/blob/main/image-removebg-preview%20-%202026-09-05T125432.088.png?raw=true","bocchi_5.png");if a5 then R["14641612286"]=a5;R["17619445191"]=a5;end
local a6=fetch("https://github.com/TexPackSearcher/shiny-engine/blob/main/image-removebg-preview%20-%202026-09-05T125639.538.png?raw=true","bocchi_6.png");if a6 then R["17619445340"]=a6;end
local a7=fetch("https://github.com/TexPackSearcher/fantastic-spoon/blob/main/image-removebg-preview%20-%202026-09-05T125927.967.png?raw=true","bocchi_7.png");if a7 then R["17838290166"]=a7;R["17619444538"]=a7;R["108220438104376"]=a7;end
local a8=fetch("https://github.com/TexPackSearcher/congenial-garbanzo/blob/main/image-removebg-preview%20-%202026-09-05T133133.514.png?raw=true","bocchi_8.png");if a8 then R["126928245743331"]=a8;R["126928245743331"]=a8;end
local a9=fetch("https://github.com/TexPackSearcher/ubiquitous-octo-dollop/blob/main/image-removebg-preview%20-%202026-09-05T124403.181.png?raw=true","bocchi_9.png");if a9 then R["17803962335"]=a9;end
local a10=fetch("https://github.com/TexPackSearcher/musical-umbrella/blob/main/image-removebg-preview%20-%202026-09-05T134735.649.png?raw=true","bocchi_10.png");if a10 then R["16782728353"]=a10;end
local a11=fetch("https://github.com/TexPackSearcher/musical-umbrella/blob/main/image-removebg-preview%20-%202026-09-05T134735.649.png?raw=true","bocchi_11.png");if a11 then R["16802957270"]=a11;end
local a12=fetch("https://github.com/TexPackSearcher/potential-happiness/blob/main/image-removebg-preview%20-%202026-09-05T135041.635.png?raw=true","bocchi_12.png");if a12 then R["71490041005019"]=a12;end
local a13=fetch("https://github.com/TexPackSearcher/potential-waffle/blob/main/image-removebg-preview%20-%202026-09-05T135450.480.png?raw=true","bocchi_13.png");if a13 then R["89570813431745"]=a13;end
local a14=fetch("https://github.com/TexPackSearcher/curly-invention/blob/main/image-removebg-preview%20-%202026-09-05T140654.049.png?raw=true","bocchi_14.png");if a14 then R["77908042044589"]=a14;end
D["16770456156"]="rbxassetid://120089981011454"
D["16492958314"]="rbxassetid://120089981011454"
D["18525513345"]="rbxassetid://128891284954593"
D["177266782"]="rbxassetid://107344784680901"
local a15=fetch("https://github.com/TexPackSearcher/shiny-pancake/blob/main/image-removebg-preview%20-%202026-09-05T141405.238.png?raw=true","bocchi_15.png");if a15 then R["133917828562858"]=a15;end
local a16=fetch("https://github.com/TexPackSearcher/urban-pancake/blob/main/image-removebg-preview%20-%202026-09-05T141611.734.png?raw=true","bocchi_16.png");if a16 then R["121503061771505"]=a16;end
D["6384899588"]="rbxassetid://136440776569658"
local Q,H={},1
local function rep(v)local i=rid(v);return i and(R[i]or D[i])end
local function ins(o)local ps;if o:IsA("Sound")then ps={"SoundId"}elseif o:IsA("Texture")or o:IsA("Decal")then ps={"Texture"}elseif o:IsA("MeshPart")then ps={"TextureID"}elseif o:IsA("ImageLabel")or o:IsA("ImageButton")then ps={"Image"}elseif o:IsA("ParticleEmitter")or o:IsA("Trail")or o:IsA("Beam")then ps={"Texture"}elseif o:IsA("SpecialMesh")then ps={"TextureId","MeshId"}end;if ps then for _,p in ipairs(ps)do local ok,v=pcall(function()return o[p]end);local n=ok and rep(v);if n then Q[#Q+1]={o,p,n}end end end end
for i,o in ipairs(game:GetDescendants())do ins(o);if i%250==0 then task.wait()end end
keep(game.DescendantAdded:Connect(function(o)task.defer(function()if env[KEY]==state and o.Parent then ins(o)end end)end))
task.spawn(function()while state.running and env[KEY]==state do local n=0;while H<=#Q and n<8 do local x=Q[H];H+=1;n+=1;if x[1]and x[1].Parent then pcall(function()x[1][x[2]]=x[3]end)end end;task.wait(.1)end end)
local U={Bk="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skybk.png",Dn="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skydn.png",Ft="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyft.png",Lf="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skylf.png",Rt="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyrt.png",Up="https://raw.githubusercontent.com/YuriAlwaysOnRL/LegoPack/main/skyup.png",};local A={}
for f,u in pairs(U)do local a=fetch(u,"bocchi_sky_"..f..".png");if not a then warn("[Bocchi V2] sky failed "..f)return end;A[f]=a end
local busy=false
local function fresh()if busy then return end;busy=true;for _,x in ipairs(Lighting:GetChildren())do if x:IsA("Sky")then pcall(function()x:Destroy()end)end end;local s=Instance.new("Sky");s.Name="BocchiFreshSky";s.SkyboxBk=A.Bk;s.SkyboxDn=A.Dn;s.SkyboxFt=A.Ft;s.SkyboxLf=A.Lf;s.SkyboxRt=A.Rt;s.SkyboxUp=A.Up;s.Parent=Lighting;busy=false end
fresh();for _,t in ipairs({.5,1.5,3,6,10})do task.delay(t,fresh)end
local last=0;keep(Lighting.ChildAdded:Connect(function(x)if x:IsA("Sky")and x.Name~="BocchiFreshSky"then local n=os.clock();if n-last>.5 then last=n;task.delay(.15,fresh)end end end))
pcall(function()StarterGui:SetCore("SendNotification",{Title="Bocchi the Rock V2",Text="Full pack + Fresh Sky loaded",Duration=6})end)