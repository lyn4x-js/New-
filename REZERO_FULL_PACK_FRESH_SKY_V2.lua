-- RE:ZERO FULL PACK - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting");local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset;if not writefile or not G then return end
local function rid(v)return tostring(v or ""):match("(%d+)")end
local function fetch(u,f)local ok,b=pcall(function()return game:HttpGet(u)end);if not ok or type(b)~="string"or #b<4 then return end;if not pcall(function()writefile(f,b)end)then return end;local o,a=pcall(function()return G(f)end);if o then return a end end
local R,D={},{}

D["16530229616"]="rbxassetid://71784668532977"
D["16530229541"]="rbxassetid://71784668532977"
D["16530229695"]="rbxassetid://71784668532977"
local a1=fetch("https://github.com/TexPackSearcher/didactic-telegram/blob/main/image-removebg-preview%20-%202026-09-11T120825.986.png?raw=true","rezero_1.png");if a1 then R["17803962335"]=a1;end
D["6384899588"]="rbxassetid://134384473797057"
local a2=fetch("https://github.com/TexPackSearcher/friendly-spoonm/blob/main/image-removebg-preview%20-%202026-09-17T161618.205.png?raw=true","rezero_2.png");if a2 then R["133917828562858"]=a2;end
local a3=fetch("https://github.com/TexPackSearcher/redesigned-wafflev/blob/main/image-removebg-preview%20-%202026-09-17T161814.405.png?raw=true","rezero_3.png");if a3 then R["121503061771505"]=a3;end
local a4=fetch("https://github.com/TexPackSearcher/probable-enigma/blob/main/image-removebg-preview%20-%202026-09-17T163525.000.png?raw=true","rezero_4.png");if a4 then R["13854780042"]=a4;end
local a5=fetch("https://github.com/TexPackSearcher/refactored-octo-invention/blob/main/image-removebg-preview%20-%202026-09-17T163720.967.png?raw=true","rezero_5.png");if a5 then R["13854780213"]=a5;end
local a6=fetch("https://github.com/TexPackSearcher/effective-parakeet/blob/main/image-removebg-preview%20-%202026-09-17T165053.144.png?raw=true","rezero_6.png");if a6 then R["7658055825"]=a6;end
D["6384899588"]="rbxassetid://137385031681735"
local a7=fetch("https://github.com/TexPackSearcher/literate-spoon/blob/main/image-removebg-preview%20-%202026-09-17T174525.414.png?raw=true","rezero_7.png");if a7 then R["17619445340"]=a7;end
local a8=fetch("https://raw.githubusercontent.com/TexPackSearcher/musical-octo-fishstick/main/Bounce%20Dash.otf?utm_source=chatgpt.com","rezero_8.otf");if a8 then R["111599878354131"]=a8;R["106623367501544"]=a8;R["131795064007344"]=a8;R["73543520622815"]=a8;R["80716950169934"]=a8;R["136100661820261"]=a8;R["107898816876115"]=a8;R["134520747948636"]=a8;R["114166096331502"]=a8;R["90039594400813"]=a8;R["133903971285645"]=a8;R["82834564754747"]=a8;R["73345783863790"]=a8;R["113997689031026"]=a8;R["88059506918419"]=a8;R["112183171942172"]=a8;R["104871954739030"]=a8;R["109012386782238"]=a8;R["127982903682334"]=a8;R["116941545385923"]=a8;R["133793956251748"]=a8;end
local a9=fetch("https://github.com/TexPackSearcher/solid-octo-rotary-phone/blob/main/image-removebg-preview%20-%202026-09-11T150751.946.png?raw=true","rezero_9.png");if a9 then R["17838290166"]=a9;R["17619444538"]=a9;R["108220438104376"]=a9;end
D["18525513345"]="rbxassetid://128891284954593"
D["16770456156"]="rbxassetid://120089981011454"
D["16492958314"]="rbxassetid://120089981011454"
local a10=fetch("https://github.com/TexPackSearcher/silver-waddle/blob/main/image-removebg-preview%20-%202026-09-11T144426.957.png?raw=true","rezero_10.png");if a10 then R["77908042044589"]=a10;end
local a11=fetch("https://github.com/TexPackSearcher/bookish-broccoli-./blob/main/image-removebg-preview%20-%202026-09-18T085711.571.png?raw=true","rezero_11.png");if a11 then R["14641612286"]=a11;R["17619445191"]=a11;end
local a12=fetch("https://github.com/TexPackSearcher/improved-funicular/blob/main/image-removebg-preview%20-%202026-09-18T090330.294.png?raw=true","rezero_12.png");if a12 then R["71490041005019"]=a12;end
D["16737738420"]="rbxassetid://115858660899251"
local a13=fetch("https://github.com/TexPackSearcher/miniature-guide/blob/main/image-removebg-preview%20-%202026-09-18T095424.342.png?raw=true","rezero_13.png");if a13 then R["81461991645938"]=a13;end
local a14=fetch("https://github.com/TexPackSearcher/refactored-broccoli/blob/main/image-removebg-preview%20-%202026-09-18T095558.194.png?raw=true","rezero_14.png");if a14 then R["17175092502"]=a14;R["17094014569"]=a14;end
local a15=fetch("https://github.com/TexPackSearcher/symmetrical-lamp/blob/main/image-removebg-preview%20-%202026-09-18T101928.871.png?raw=true","rezero_15.png");if a15 then R["18185474596"]=a15;end
local a16=fetch("https://github.com/TexPackSearcher/special-guacamole/blob/main/image-removebg-preview%20-%202026-09-18T102432.923.png?raw=true","rezero_16.png");if a16 then R["17860400428"]=a16;R["17860673529"]=a16;end
local a17=fetch("https://github.com/TexPackSearcher/special-guacamole/blob/main/image-removebg-preview%20-%202026-09-18T102432.923.png?raw=true","rezero_17.png");if a17 then R["17495953350"]=a17;R["17495953455"]=a17;end
D["16810041280"]="rbxassetid://11053494832437"
local a18=fetch("https://raw.githubusercontent.com/TexPackSearcher/verbose-pancake/main/speech_1789751822555.mp3","rezero_18.mp3");if a18 then R["6384899588"]=a18;end
local Q,H={},1
local function rep(v)local i=rid(v);return i and(R[i]or D[i])end
local function ins(o)local ps;if o:IsA("Sound")then ps={"SoundId"}elseif o:IsA("Texture")or o:IsA("Decal")then ps={"Texture"}elseif o:IsA("MeshPart")then ps={"TextureID"}elseif o:IsA("ImageLabel")or o:IsA("ImageButton")then ps={"Image"}elseif o:IsA("ParticleEmitter")or o:IsA("Trail")or o:IsA("Beam")then ps={"Texture"}elseif o:IsA("SpecialMesh")then ps={"TextureId","MeshId"}end;if ps then for _,p in ipairs(ps)do local ok,v=pcall(function()return o[p]end);local n=ok and rep(v);if n then Q[#Q+1]={o,p,n}end end end;if o:IsA("TextLabel")or o:IsA("TextButton")or o:IsA("TextBox")then pcall(function()local f=o.FontFace;local n=rep(f.Family);if n then o.FontFace=Font.new(n,f.Weight,f.Style)end end)end end
for i,o in ipairs(game:GetDescendants())do ins(o);if i%250==0 then task.wait()end end
game.DescendantAdded:Connect(function(o)task.defer(function()if o.Parent then ins(o)end end)end)
task.spawn(function()while true do local n=0;while H<=#Q and n<8 do local x=Q[H];H+=1;n+=1;if x[1]and x[1].Parent then pcall(function()x[1][x[2]]=x[3]end)end end;task.wait(.1)end end)
local U={
Bk="https://raw.githubusercontent.com/TexPackSearcher/redesigned-lamp/main/sky512_bk.tex?utm_source=chatgpt.com",
Dn="https://raw.githubusercontent.com/TexPackSearcher/didactic-octo-couscous/main/sky512_dn.tex?utm_source=chatgpt.com",
Ft="https://raw.githubusercontent.com/TexPackSearcher/fantastic-fiesta/main/sky512_ft.tex",
Lf="https://raw.githubusercontent.com/TexPackSearcher/bookish-train/main/sky512_lf.tex",
Rt="https://raw.githubusercontent.com/TexPackSearcher/ubiquitous-invention/main/sky512_rt.tex",
Up="https://raw.githubusercontent.com/TexPackSearcher/solid-octo-umbrellad/main/sky512_up.tex",
};local A={}
for f,u in pairs(U)do local a=fetch(u,"rezero_sky_"..f..".tex");if not a then return end;A[f]=a end
local busy=false;local function fresh()if busy then return end;busy=true;for _,x in ipairs(Lighting:GetChildren())do if x:IsA("Sky")then pcall(function()x:Destroy()end)end end;local s=Instance.new("Sky");s.Name="ReZeroFreshSky";s.SkyboxBk=A.Bk;s.SkyboxDn=A.Dn;s.SkyboxFt=A.Ft;s.SkyboxLf=A.Lf;s.SkyboxRt=A.Rt;s.SkyboxUp=A.Up;s.Parent=Lighting;busy=false end
fresh();for _,t in ipairs({.5,1.5,3,6,10})do task.delay(t,fresh)end
local last=0;Lighting.ChildAdded:Connect(function(x)if x:IsA("Sky")and x.Name~="ReZeroFreshSky"then local n=os.clock();if n-last>.5 then last=n;task.delay(.15,fresh)end end end)
pcall(function()StarterGui:SetCore("SendNotification",{Title="Re:Zero V2",Text="Full pack + Fresh Sky loaded",Duration=6})end)