
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local v1 = nil
local v2 = false
local f1
local enabled = true
local uiRoot


local function f2()
 local character = localPlayer.Character
 local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")


 local humanoid = character
 humanoid = character and character:FindFirstChildOfClass("Humanoid")


 local v3 = not humanoidRootPart
 local v4 = humanoid


 if v3 or not v4 or v2 or not enabled then
  return
 end


 if v4.FloorMaterial == Enum.Material.Air then
  v2 = true
  f1(humanoidRootPart)
  local total = 0


  while enabled and v2 and total < 0.4 do
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


  if not enabled or not v2 or not index or not index.Parent or v1 ~= rivalsAntiStuckAirFloor then
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
 if not enabled or p1 then return end
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


-- Mobile control panel. Drag header while unlocked; Lock prevents movement.
local playerGui = localPlayer:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("LYN4X_Airslide_Control")
if old then old:Destroy() end
local gui = Instance.new("ScreenGui")
gui.Name = "LYN4X_Airslide_Control"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui
uiRoot = gui
local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(220, 94)
panel.Position = UDim2.new(0.5, -110, 0.28, 0)
panel.BackgroundColor3 = Color3.fromRGB(22,22,26)
panel.BorderSizePixel = 0
panel.Active = true
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1,-12,0,31)
header.Position = UDim2.fromOffset(6,3)
header.BackgroundTransparency = 1
header.Text = "LYN4X AIRSLIDE  •  DRAG"
header.TextColor3 = Color3.fromRGB(245,245,245)
header.Font = Enum.Font.GothamBold
header.TextSize = 13
header.Active = true
header.Parent = panel
local function makeButton(text, x)
 local b = Instance.new("TextButton")
 b.Size = UDim2.fromOffset(98,42)
 b.Position = UDim2.fromOffset(x,43)
 b.BackgroundColor3 = Color3.fromRGB(52,52,59)
 b.TextColor3 = Color3.new(1,1,1)
 b.Font = Enum.Font.GothamBold
 b.TextSize = 14
 b.Text = text
 b.Parent = panel
 Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
 return b
end
local toggle = makeButton("ON",8)
local lock = makeButton("UNLOCKED",114)
local locked = false
local function refresh()
 toggle.Text = enabled and "ON" or "OFF"
 toggle.BackgroundColor3 = enabled and Color3.fromRGB(37,135,85) or Color3.fromRGB(148,55,55)
 lock.Text = locked and "LOCKED" or "UNLOCKED"
 lock.BackgroundColor3 = locked and Color3.fromRGB(135,90,34) or Color3.fromRGB(52,52,59)
 header.Text = locked and "LYN4X AIRSLIDE  •  LOCKED" or "LYN4X AIRSLIDE  •  DRAG"
end
refresh()
toggle.Activated:Connect(function()
 enabled = not enabled
 if not enabled then
  v2 = false
  if v1 then v1:Destroy(); v1=nil end
 end
 refresh()
end)
lock.Activated:Connect(function()
 locked = not locked
 refresh()
end)
local dragging, dragStart, startPos, dragInput = false, nil, nil, nil
header.InputBegan:Connect(function(input)
 if locked then return end
 if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
  dragging = true
  dragStart = input.Position
  startPos = panel.Position
  input.Changed:Connect(function()
   if input.UserInputState == Enum.UserInputState.End then dragging=false end
  end)
 end
end)
header.InputChanged:Connect(function(input)
 if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
  dragInput = input
 end
end)
userInputService.InputChanged:Connect(function(input)
 if not dragging or locked or input ~= dragInput then return end
 local delta = input.Position - dragStart
 panel.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end)
