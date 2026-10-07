-- COOL BLACK SKY - Fresh Sky V2 - iPad/Delta
local Lighting=game:GetService("Lighting")
local StarterGui=game:GetService("StarterGui")
local SKY="rbxassetid://7658055825"

local creating=false
local function fresh()
 if creating then return end
 creating=true
 for _,v in ipairs(Lighting:GetChildren()) do
  if v:IsA("Sky") then
   pcall(function() v:Destroy() end)
  end
 end
 local s=Instance.new("Sky")
 s.Name="CoolBlackFreshSky"
 s.SkyboxBk=SKY
 s.SkyboxDn=SKY
 s.SkyboxFt=SKY
 s.SkyboxLf=SKY
 s.SkyboxRt=SKY
 s.SkyboxUp=SKY
 s.Parent=Lighting
 creating=false
end

fresh()
for _,t in ipairs({.5,1.5,3,6,10}) do task.delay(t,fresh) end

local last=0
Lighting.ChildAdded:Connect(function(v)
 if v:IsA("Sky") and v.Name~="CoolBlackFreshSky" then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.15,fresh)
  end
 end
end)

pcall(function()
 StarterGui:SetCore("SendNotification",{
  Title="Cool Black Sky V2",
  Text="Fresh Sky created",
  Duration=6
 })
end)
