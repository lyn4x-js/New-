-- RIVALS AIR SLIDE V3: experimental, client-side platform test.
-- Never changes workspace.Gravity, humanoid movement settings or velocities.
-- Local parts may not be accepted as legitimate RIVALS slide surfaces.
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UIS = game:GetService('UserInputService')
local player = Players.LocalPlayer
if not player then return end
local env = (type(getgenv)=='function' and getgenv()) or _G
for _,key in ipairs({'RIVALS_AIR_SLIDE_V1','RIVALS_AIR_SLIDE_V2','RIVALS_AIR_SLIDE_V3'}) do
    local old = env[key]
    if old and type(old.Stop)=='function' then pcall(old.Stop) end
end
local state = {enabled=false, active=false, connections={}}
env.RIVALS_AIR_SLIDE_V3 = state
local gui = Instance.new('ScreenGui')
gui.Name = 'RIVALS_AIR_SLIDE_V3_GUI'
gui.ResetOnSpawn = false
pcall(function() gui.Parent = game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent = player:WaitForChild('PlayerGui') end
local button = Instance.new('TextButton')
button.Name='Toggle'; button.Size=UDim2.fromOffset(176,52)
button.Position=UDim2.new(1,-190,0.55,0)
button.BackgroundColor3=Color3.fromRGB(23,23,29)
button.TextColor3=Color3.fromRGB(255,155,60)
button.TextSize=15; button.Font=Enum.Font.GothamBold
button.Active=true; button.Parent=gui
Instance.new('UICorner',button).CornerRadius=UDim.new(0,12)
local stroke=Instance.new('UIStroke',button)
stroke.Color=Color3.fromRGB(255,125,20); stroke.Thickness=2
local folder=Instance.new('Folder'); folder.Name='AirSlideV3_Local'; folder.Parent=workspace
local pad=Instance.new('Part')
pad.Name='StationaryAirSurface'; pad.Size=Vector3.new(26,0.35,26)
pad.Anchored=true; pad.CanCollide=false; pad.CanTouch=false; pad.CanQuery=false
pad.Transparency=1; pad.Parent=folder
local function clear()
    pad.CanCollide=false
    state.active=false
end
local function updateButton()
    button.Text=state.enabled and 'AIR SLIDE: ON' or 'AIR SLIDE: OFF'
    button.BackgroundColor3=state.enabled and Color3.fromRGB(77,41,19) or Color3.fromRGB(23,23,29)
end
-- Touch-drag moves the button; short taps toggle it.
local gesture, origin, initial, dragged
local function xy(input) return Vector2.new(input.Position.X,input.Position.Y) end
table.insert(state.connections,button.InputBegan:Connect(function(input)
    if input.UserInputType~=Enum.UserInputType.Touch and input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
    gesture=input; origin=xy(input); initial=button.Position; dragged=false
end))
table.insert(state.connections,UIS.InputChanged:Connect(function(input)
    if not gesture then return end
    if input~=gesture and not (gesture.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement) then return end
    local delta=xy(input)-origin
    if delta.Magnitude>12 then dragged=true end
    if dragged then button.Position=UDim2.new(initial.X.Scale,initial.X.Offset+delta.X,initial.Y.Scale,initial.Y.Offset+delta.Y) end
end))
table.insert(state.connections,UIS.InputEnded:Connect(function(input)
    if input~=gesture then return end
    local tap=not dragged and (xy(input)-origin).Magnitude<=12
    gesture=nil
    if tap then
        state.enabled=not state.enabled
        if not state.enabled then clear() end
        updateButton()
    end
end))
local params=RaycastParams.new()
params.FilterType=Enum.RaycastFilterType.Exclude
params.IgnoreWater=true
local airStart=nil
local cooldownUntil=0
local placedAt=0
local lastChar=nil
local elapsed=0
local function reset()
    airStart=nil; clear()
end
-- Platform stays fixed once created. It is never moved while collidable.
table.insert(state.connections,RunService.Heartbeat:Connect(function(dt)
    elapsed=elapsed+dt
    if elapsed<1/30 then return end
    elapsed=0
    local char=player.Character
    local hum=char and char:FindFirstChildOfClass('Humanoid')
    local root=char and char:FindFirstChild('HumanoidRootPart')
    if char~=lastChar then lastChar=char; reset(); cooldownUntil=0 end
    if not state.enabled or not hum or not root or hum.Health<=0 then reset(); return end
    local hs=hum:GetState()
    if hs==Enum.HumanoidStateType.Dead or hs==Enum.HumanoidStateType.Seated or hs==Enum.HumanoidStateType.Swimming or hs==Enum.HumanoidStateType.Climbing then reset(); return end
    params.FilterDescendantsInstances={char,folder}
    local realGround=workspace:Raycast(root.Position,Vector3.new(0,-6,0),params)
    if realGround then reset(); cooldownUntil=os.clock()+0.25; return end
    if state.active then
        -- Do not reposition under the player's feet: this avoids physics impulses.
        local d=root.Position-pad.Position
        if math.abs(d.X)>11 or math.abs(d.Z)>11 or root.Position.Y<pad.Position.Y-1.0 or os.clock()-placedAt>2.0 then
            clear(); cooldownUntil=os.clock()+0.22
        end
        return
    end
    if os.clock()<cooldownUntil then return end
    if root.AssemblyLinearVelocity.Y>=-2 then airStart=nil; return end
    local flatVelocity=Vector3.new(root.AssemblyLinearVelocity.X,0,root.AssemblyLinearVelocity.Z).Magnitude
    if flatVelocity<2 then airStart=nil; return end
    airStart=airStart or os.clock()
    if os.clock()-airStart<0.15 then return end
    -- Spawn below feet only after free fall begins, not during jump takeoff.
    pad.CFrame=CFrame.new(root.Position.X,root.Position.Y-3.8,root.Position.Z)
    pad.CanCollide=true
    state.active=true
    placedAt=os.clock()
    airStart=nil
end))
function state.Stop()
    state.enabled=false; clear()
    for _,conn in ipairs(state.connections) do pcall(function() conn:Disconnect() end) end
    pcall(function() folder:Destroy() end)
    pcall(function() gui:Destroy() end)
    if env.RIVALS_AIR_SLIDE_V3==state then env.RIVALS_AIR_SLIDE_V3=nil end
end
updateButton()
print('[Air Slide V3] Loaded: gravity unchanged, stationary temporary platforms.')
