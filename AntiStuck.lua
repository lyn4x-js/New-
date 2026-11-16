
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local v1 = nil
local v2 = false
local f1


local function f2()
 local character = localPlayer.Character
 local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")


 local humanoid = character
 humanoid = character and character:FindFirstChildOfClass("Humanoid")


 local v3 = not humanoidRootPart
 local v4 = humanoid


 if v3 or not v4 or v2 then
  return
 end


 if v4.FloorMaterial == Enum.Material.Air then
  v2 = true
  f1(humanoidRootPart)
  local total = 0


  while v2 and total < 0.4 do
    task.wait(0.01)
    total = total + 0.01
  end


  v2 = false


  if v1 then
    v1:Destroy()
    v1 = nil
  end
 end
end


function f1(index)
 if v1 then
  v1:Destroy()
 end


 local rivalsAntiStuckAirFloor = Instance.new("Part")
 rivalsAntiStuckAirFloor.Name = "RivalsAntiStuckAirFloor"
 rivalsAntiStuckAirFloor.Size = Vector3.new(8, 0.2, 8)
 rivalsAntiStuckAirFloor.Anchored = true
 rivalsAntiStuckAirFloor.CanCollide = true
 rivalsAntiStuckAirFloor.Transparency = 1
 rivalsAntiStuckAirFloor.Material = Enum.Material.SmoothPlastic
 rivalsAntiStuckAirFloor.Friction = 0
 rivalsAntiStuckAirFloor.Parent = workspace


 v1 = rivalsAntiStuckAirFloor


 local connect


 connect = runService.PreRender:Connect(function()
  if index and index.Parent then
   if Vector3.new(
      index.AssemblyLinearVelocity.X, 0, index.AssemblyLinearVelocity.Z
   ).Magnitude < 5 then
      v2 = false
   end
  end


  if not v2 or not index or not index.Parent or v1 ~= rivalsAntiStuckAirFloor then
   if connect then
      connect:Disconnect()
   end


   rivalsAntiStuckAirFloor:Destroy()
   return
  end


  rivalsAntiStuckAirFloor.CFrame = index.CFrame * CFrame.new(0, -3, 0)
 end)
end


userInputService.InputBegan:Connect(function(input, p1)
 if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.C
  or input.UserInputType == Enum.UserInputType.Touch then
  task.defer(function()
   local character2 = localPlayer.Character
   local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")


   if humanoid2 and humanoid2.FloorMaterial == Enum.Material.Air then
       f2()
   end
  end)
 end
end)
