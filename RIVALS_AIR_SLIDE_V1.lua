-- RIVALS AIR SLIDE V1 - experimental client-side air platforms
-- For Roblox Lua executors that support local scripts. No guarantee RIVALS server accepts sliding on these.
-- Tap the floating toggle to enable/disable. Execute again to replace the previous instance.

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local player = Players.LocalPlayer
if not player then return end

local old = getgenv and getgenv().RIVALS_AIR_SLIDE_V1
if old and type(old.Stop) == 'function' then pcall(old.Stop) end

local state = { enabled = false, airborne = false, connections = {}, parts = {} }
if getgenv then getgenv().RIVALS_AIR_SLIDE_V1 = state end

local gui = Instance.new('ScreenGui')
gui.Name = 'RIVALS_AIR_SLIDE_V1_GUI'
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
pcall(function() gui.Parent = game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent = player:WaitForChild('PlayerGui') end

local button = Instance.new('TextButton')
button.Name = 'AirSlideToggle'
button.Size = UDim2.fromOffset(166, 52)
button.Position = UDim2.new(1, -180, 0.55, 0)
button.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
button.TextColor3 = Color3.fromRGB(255, 150, 50)
button.Font = Enum.Font.GothamBold
button.TextSize = 15
button.Text = 'AIR SLIDE: OFF'
button.Active = true
button.Parent = gui
Instance.new('UICorner', button).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new('UIStroke', button)
stroke.Color = Color3.fromRGB(255, 125, 20)
stroke.Thickness = 2

-- Fixed-size reusable grid: enough overlap for 360-degree coverage, without endlessly creating parts.
local container = Instance.new('Folder')
container.Name = 'LocalAirSlidePlatforms'
container.Parent = workspace
local spacing, tileSize = 7, 8
for x = -1, 1 do
    for z = -1, 1 do
        local p = Instance.new('Part')
        p.Name = 'AirSlide_' .. x .. '_' .. z
        p.Anchored = true
        p.CanCollide = false
        p.CanTouch = false
        p.CanQuery = false
        p.Transparency = 1
        p.Size = Vector3.new(tileSize, 0.35, tileSize)
        p.Parent = container
        table.insert(state.parts, {part = p, x = x, z = z})
    end
end

local function setPads(active)
    for _, entry in ipairs(state.parts) do
        entry.part.CanCollide = active
    end
end

local function refreshButton()
    button.Text = state.enabled and 'AIR SLIDE: ON' or 'AIR SLIDE: OFF'
    button.BackgroundColor3 = state.enabled and Color3.fromRGB(70, 38, 20) or Color3.fromRGB(28, 28, 33)
end

local function onToggle()
    state.enabled = not state.enabled
    if not state.enabled then
        state.airborne = false
        setPads(false)
    end
    refreshButton()
end

table.insert(state.connections, button.MouseButton1Click:Connect(onToggle))

-- Dragging support for mouse and touch; short taps still toggle.
local dragging, startPos, startInput
local function inputPosition(input)
    return Vector2.new(input.Position.X, input.Position.Y)
end
table.insert(state.connections, button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startInput = inputPosition(input)
        startPos = button.Position
    end
end))
table.insert(state.connections, UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = inputPosition(input) - startInput
        button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end))
table.insert(state.connections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end))

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
rayParams.IgnoreWater = true
local elapsed = 0

table.insert(state.connections, RunService.Heartbeat:Connect(function(dt)
    elapsed = elapsed + dt
    if elapsed < 1/30 then return end
    elapsed = 0
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass('Humanoid')
    local root = character and character:FindFirstChild('HumanoidRootPart')
    if not state.enabled or not humanoid or not root or humanoid.Health <= 0 then
        state.airborne = false
        setPads(false)
        return
    end

    -- Check for *real* map ground, excluding locally created platforms.
    rayParams.FilterDescendantsInstances = {character, container}
    local groundHit = workspace:Raycast(root.Position, Vector3.new(0, -4.5, 0), rayParams)
    local humanoidState = humanoid:GetState()
    local jumping = humanoidState == Enum.HumanoidStateType.Jumping or humanoidState == Enum.HumanoidStateType.Freefall
    if groundHit then
        state.airborne = false
    elseif jumping or state.airborne then
        state.airborne = true
    end

    if not state.airborne then
        setPads(false)
        return
    end

    -- Flat overlapping grid centered on the player; a little below the feet.
    local center = root.Position - Vector3.new(0, 3.2, 0)
    for _, entry in ipairs(state.parts) do
        entry.part.CFrame = CFrame.new(center + Vector3.new(entry.x * spacing, 0, entry.z * spacing))
        entry.part.CanCollide = true
    end
end))

function state.Stop()
    state.enabled = false
    setPads(false)
    for _, connection in ipairs(state.connections) do pcall(function() connection:Disconnect() end) end
    pcall(function() container:Destroy() end)
    pcall(function() gui:Destroy() end)
    if getgenv and getgenv().RIVALS_AIR_SLIDE_V1 == state then getgenv().RIVALS_AIR_SLIDE_V1 = nil end
end

refreshButton()
print('[Air Slide V1] Loaded. Local-only prototype; RIVALS server may reject platform collisions/sliding.')
