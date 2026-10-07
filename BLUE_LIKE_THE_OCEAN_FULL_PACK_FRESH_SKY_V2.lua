-- BLUE LIKE THE OCEAN - Full Pack Fresh Sky V2 - iPad/Delta
-- Original texture/SFX logic stays in the V1 pack; this overlays the proven fresh Sky method.

local ok,err=pcall(function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/lyn4x-js/Textures/main/BLUE_LIKE_THE_OCEAN_iPad_Adaptive_V1.lua"))()
end)
if not ok then warn("[Ocean V2] base pack failed: "..tostring(err)) return end

local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local G=getcustomasset or getsynasset
if not writefile or not G then warn("[Ocean V2] missing file/customasset support") return end

local urls={
 Bk="https://files.catbox.moe/qkq4l5.tex",
 Dn="https://files.catbox.moe/b7jt17.tex",
 Ft="https://files.catbox.moe/m1pkri.tex",
 Lf="https://files.catbox.moe/0bijwb.tex",
 Rt="https://files.catbox.moe/krfi08.tex",
 Up="https://files.catbox.moe/tj733n.tex"
}
local a={}
for face,url in pairs(urls) do
 local ok2,d=pcall(function() return game:HttpGet(url) end)
 if not ok2 or type(d)~="string" or #d<20 then warn("[Ocean V2] sky download failed "..face) return end
 local f="ocean_fresh_"..face..".tex"
 if not pcall(function() writefile(f,d) end) then warn("[Ocean V2] write failed "..face) return end
 local ok3,x=pcall(function() return G(f) end)
 if not ok3 or not x then warn("[Ocean V2] asset failed "..face) return end
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
 s.Name="BlueOceanFreshSky"
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
 if x:IsA("Sky") and x.Name~="BlueOceanFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,fresh)
  end
 end
end)

pcall(function()
 StarterGui:SetCore("SendNotification",{Title="Blue Like The Ocean V2",Text="Full pack + Fresh Sky loaded",Duration=6})
end)
