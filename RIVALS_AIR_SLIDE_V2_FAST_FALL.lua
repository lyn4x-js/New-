-- RIVALS AIR SLIDE V2 FAST FALL - V2 physics with lower catch surface
-- Does NOT change workspace.Gravity or Humanoid movement values.
-- The game server may not recognize client-created platforms as slide surfaces.
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UIS = game:GetService('UserInputService')
local player = Players.LocalPlayer
if not player then return end
local env = (type(getgenv) == 'function' and getgenv()) or _G
if env.RIVALS_AIR_SLIDE_V3 and type(env.RIVALS_AIR_SLIDE_V3.Stop) == 'function' then
    pcall(env.RIVALS_AIR_SLIDE_V3.Stop)
end
if env.RIVALS_AIR_SLIDE_V2_FAST_FALL and type(env.RIVALS_AIR_SLIDE_V2_FAST_FALL.Stop) == 'function' then
    pcall(env.RIVALS_AIR_SLIDE_V2_FAST_FALL.Stop)
end
if env.RIVALS_AIR_SLIDE_V2 and type(env.RIVALS_AIR_SLIDE_V2.Stop) == 'function' then
    pcall(env.RIVALS_AIR_SLIDE_V2.Stop)
end
if env.RIVALS_AIR_SLIDE_V1 and type(env.RIVALS_AIR_SLIDE_V1.Stop) == 'function' then
    pcall(env.RIVALS_AIR_SLIDE_V1.Stop)
end
local state = {enabled=false, connections={}, parts={}, active=false}
env.RIVALS_AIR_SLIDE_V2_FAST_FALL = state
local gui = Instance.new('ScreenGui')
gui.Name = 'RIVALS_AIR_SLIDE_V2_FAST_FALL_GUI'
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
pcall(function() gui.Parent = game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent = player:WaitForChild('PlayerGui') end
local button = Instance.new('TextButton')
button.Name = 'AirSlideToggle'
button.Size = UDim2.fromOffset(170, 52)
button.Position = UDim2.new(1, -184, 0.55, 0)
button.BackgroundColor3 = Color3.fromRGB(24,24,30)
button.TextColor3 = Color3.fromRGB(255,157,60)
button.TextSize = 15
button.Font = Enum.Font.GothamBold
button.Text = 'AIR SLIDE: OFF'
button.Active = true
button.Parent = gui
Instance.new('UICorner', button).CornerRadius = UDim.new(0, 12)
local outline = Instance.new('UIStroke', button)
outline.Color = Color3.fromRGB(255,125,20)
outline.Thickness = 2
local folder = Instance.new('Folder')
folder.Name = 'AirSlideV2FastFall_LocalOnly'
folder.Parent = workspace
-- Single continuous pad prevents seams, collision jitter, and excessive parts.
local pad = Instance.new('Part')
pad.Name = 'AirSlideSurface'
pad.Anchored = true
pad.CanCollide = false
pad.CanTouch = false
pad.CanQuery = false
pad.Transparency = 1
pad.Size = Vector3.new(25, 0.3, 25)
pad.Parent = folder
state.parts[1] = pad
local function disablePad()
    state.active = false
    pad.CanCollide = false
end
local function updateButton()
    button.Text = state.enabled and 'AIR SLIDE: ON' or 'AIR SLIDE: OFF'
    button.BackgroundColor3 = state.enabled and Color3.fromRGB(78,42,20) or Color3.fromRGB(24,24,30)
end
-- Track the exact input that started the gesture; dragging must not toggle.
local gesture, moved = nil, false
local startPointer, startButton
local function pos(input) return Vector2.new(input.Position.X, input.Position.Y) end
local function begin(input)
    if input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    gesture = input
    moved = false
    startPointer = pos(input)
    startButton = button.Position
end
local function change(input)
    if not gesture then return end
    if input ~= gesture and not (gesture.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement) then return end
    local delta = pos(input) - startPointer
    if delta.Magnitude > 10 then moved = true end
    if moved then
        button.Position = UDim2.new(startButton.X.Scale, startButton.X.Offset + delta.X, startButton.Y.Scale, startButton.Y.Offset + delta.Y)
    end
end
local function finish(input)
    if not gesture or input ~= gesture then return end
    local tapped = not moved and (pos(input) - startPointer).Magnitude <= 10
    gesture = nil
    if tapped then
        state.enabled = not state.enabled
        if not state.enabled then disablePad() end
        updateButton()
    end
end
table.insert(state.connections, button.InputBegan:Connect(begin))
table.insert(state.connections, UIS.InputChanged:Connect(change))
table.insert(state.connections, UIS.InputEnded:Connect(finish))
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.IgnoreWater = true
local accumulator = 0
local airSince = nil
local lastY = nil
local lastCharacter = nil
-- Position is sampled at 30 Hz to reduce physics jitter.
table.insert(state.connections, RunService.Heartbeat:Connect(function(dt)
    accumulator = accumulator + dt
    if accumulator < 1/30 then return end
    accumulator = 0
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass('Humanoid')
    local root = character and character:FindFirstChild('HumanoidRootPart')
    if character ~= lastCharacter then
        lastCharacter = character
        airSince = nil
        lastY = nil
        disablePad()
    end
    if not state.enabled or not root or not humanoid or humanoid.Health <= 0 then
        airSince = nil
        lastY = nil
        disablePad()
        return
    end
    local hstate = humanoid:GetState()
    if hstate == Enum.HumanoidStateType.Seated or hstate == Enum.HumanoidStateType.Swimming or hstate == Enum.HumanoidStateType.Climbing or hstate == Enum.HumanoidStateType.Dead then
        airSince = nil
        lastY = nil
        disablePad()
        return
    end
    params.FilterDescendantsInstances = {character, folder}
    local hit = workspace:Raycast(root.Position, Vector3.new(0,-6,0), params)
    -- Only activate when well away from actual map geometry and falling.
    local falling = root.AssemblyLinearVelocity.Y < -1.5
    if hit or not falling then
        airSince = nil
        lastY = nil
        disablePad()
        return
    end
    airSince = airSince or os.clock()
    -- Small grace period ensures jump takeoff is not obstructed.
    if os.clock() - airSince < 0.16 then
        disablePad()
        return
    end
    local desiredY = root.Position.Y - 4.45
    -- A collidable platform must never be moved upward into the character.
    -- Once activated, keep its height until the player drops beneath it.
    if not lastY or desiredY < lastY - 0.7 then
        lastY = desiredY
    end
    pad.CanCollide = false
    pad.CFrame = CFrame.new(root.Position.X, lastY, root.Position.Z)
    pad.CanCollide = true
    state.active = true
end))
function state.Stop()
    state.enabled = false
    disablePad()
    for _, conn in ipairs(state.connections) do pcall(function() conn:Disconnect() end) end
    pcall(function() folder:Destroy() end)
    pcall(function() gui:Destroy() end)
    if env.RIVALS_AIR_SLIDE_V2_FAST_FALL == state then env.RIVALS_AIR_SLIDE_V2_FAST_FALL = nil end
end
updateButton()
print('[Air Slide V2 Fast Fall] Loaded. Gravity unchanged. Lower catch surface; experimental local-only collisions.')
