-- DEATH NOTE Adaptive Full Pack - Fresh Sky V2
-- Loads the original working texture/SFX pack, then replaces only the sky with the proven fresh-Sky method.

local ok,err=pcall(function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/DEATH_NOTE_iPad_Adaptive_AllInOne_V1.lua"))()
end)
if not ok then warn("[DEATH NOTE V2] base pack failed: "..tostring(err)) return end

local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[DEATH NOTE V2] asset APIs missing") return end

local urls={
 Bk="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/back.tex",
 Dn="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/down.tex",
 Ft="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/front.tex",
 Lf="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/left.tex",
 Rt="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/right.tex",
 Up="https://raw.githubusercontent.com/leitopatatua-lab/death-note/main/up.tex"
}
local a={}
for face,url in pairs(urls) do
 local ok2,d=pcall(function() return game:HttpGet(url) end)
 if not ok2 or type(d)~="string" or #d<50 then warn("[DEATH NOTE V2] sky download failed "..face) return end
 local f="deathnote_fresh_"..face..".tex"
 if not pcall(function() writefile(f,d) end) then return end
 local ok3,x=pcall(function() return G(f) end)
 if not ok3 or not x then return end
 a[face]=x
end

local creating=false
local function fresh()
 if creating then return end
 creating=true
 for _,v in ipairs(Lighting:GetChildren()) do
  if v:IsA("Sky") then pcall(function() v:Destroy() end) end
 end
 local s=Instance.new("Sky")
 s.Name="DeathNoteFreshSky"
 s.SkyboxBk=a.Bk
 s.SkyboxDn=a.Dn
 s.SkyboxFt=a.Ft
 s.SkyboxLf=a.Lf
 s.SkyboxRt=a.Rt
 s.SkyboxUp=a.Up
 s.Parent=Lighting
 creating=false
end

fresh()
for _,t in ipairs({.5,1.5,3,6,10}) do task.delay(t,fresh) end

local last=0
Lighting.ChildAdded:Connect(function(v)
 if v:IsA("Sky") and v.Name~="DeathNoteFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,fresh)
  end
 end
end)

pcall(function()
 StarterGui:SetCore("SendNotification",{
  Title="DEATH NOTE V2",
  Text="Full pack + Fresh Sky loaded",
  Duration=6
 })
end)
