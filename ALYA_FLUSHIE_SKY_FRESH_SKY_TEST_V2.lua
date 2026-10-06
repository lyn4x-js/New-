-- Alya / Flushie Sky - FRESH SKY TEST V2 - iPad/Delta
local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Alya V2] missing file/customasset support") return end

local urls={
 Bk="https://github.com/Ankkouu/flushie/raw/refs/heads/main/bk.tex",
 Dn="https://github.com/Ankkouu/flushie/raw/refs/heads/main/dn.tex",
 Ft="https://github.com/Ankkouu/flushie/raw/refs/heads/main/ft.tex",
 Lf="https://github.com/Ankkouu/flushie/raw/refs/heads/main/lt.tex",
 Rt="https://github.com/Ankkouu/flushie/raw/refs/heads/main/rt.tex",
 Up="https://github.com/Ankkouu/flushie/raw/refs/heads/main/up.tex"
}
local a={}
for face,url in pairs(urls) do
 local ok,d=pcall(function() return game:HttpGet(url) end)
 if not ok or type(d)~="string" or #d<50 then warn("[Alya V2] download failed "..face) return end
 local f="alya_v2_"..face..".tex"
 if not pcall(function() writefile(f,d) end) then warn("[Alya V2] write failed "..face) return end
 local ok2,x=pcall(function() return G(f) end)
 if not ok2 or not x then warn("[Alya V2] asset failed "..face) return end
 a[face]=x
end

local creating=false
local function fresh()
 if creating then return end
 creating=true
 for _,x in ipairs(Lighting:GetChildren()) do
  if x:IsA("Sky") then pcall(function() x:Destroy() end) end
 end
 local s=Instance.new("Sky")
 s.Name="AlyaFlushieFreshSky"
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
Lighting.ChildAdded:Connect(function(x)
 if x:IsA("Sky") and x.Name~="AlyaFlushieFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,fresh)
  end
 end
end)

pcall(function()
 StarterGui:SetCore("SendNotification",{Title="Alya Fresh Sky V2",Text="Fresh Sky created",Duration=6})
end)
