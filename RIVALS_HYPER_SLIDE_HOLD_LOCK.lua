-- RIVALS HYPER SLIDE | HOLD TO REPEAT | iPad / Delta (experimental)
-- Standalone. No TORNHUB dependency. Client-side simulated input may be unsupported.
-- Tap = one sequence; hold = repeat; drag = reposition when unlocked; lock button prevents accidental moves.
local Players = game:GetService('Players')
local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local player = Players.LocalPlayer
if not player then return end
local env = (getgenv and getgenv()) or _G
if env.RIVALS_HYPER_SLIDE and type(env.RIVALS_HYPER_SLIDE.Stop)=='function' then
    pcall(env.RIVALS_HYPER_SLIDE.Stop)
end
local state = {alive=true, running=false, held=false, token=0, connections={}, down={}, locked=false}
env.RIVALS_HYPER_SLIDE = state
local vim
pcall(function() vim = game:GetService('VirtualInputManager') end)
local keyMap = {Ctrl=Enum.KeyCode.LeftControl, Space=Enum.KeyCode.Space, Shift=Enum.KeyCode.LeftShift}
local function sendKey(name, pressed)
    local key = keyMap[name]
    if not key then return false end
    local ok = false
    if vim then ok = pcall(function() vim:SendKeyEvent(pressed,key,false,game) end) end
    if ok then state.down[name] = pressed or nil end
    return ok
end
local function sendMouse(pressed)
    local camera = workspace.CurrentCamera
    local vp = camera and camera.ViewportSize or Vector2.new(400,300)
    local x,y = math.floor(vp.X/2), math.floor(vp.Y/2)
    local ok = false
    if vim then ok = pcall(function() vim:SendMouseButtonEvent(x,y,0,pressed,game,0) end) end
    if ok then state.down.Mouse = pressed or nil end
    return ok
end
local function releaseAll()
    for _,name in ipairs({'Ctrl','Space','Shift'}) do sendKey(name,false) end
    sendMouse(false)
    state.down = {}
end
local function waitMs(ms, token)
    local duration = ms/1000
    local elapsed = 0
    repeat
        if not state.alive or token ~= state.token then return false end
        elapsed = elapsed + RunService.Heartbeat:Wait()
    until elapsed >= duration
    return state.alive and token == state.token
end
-- Each entry is an input transition followed by the screenshot's delay in ms.
local sequence = {
    {'Ctrl',true,15},{'Ctrl',false,15},
    {'Space',true,25},{'Space',false,25},{'Space',true,25},
    {'Ctrl',true,1},{'Ctrl',false,1},{'Ctrl',true,1},{'Ctrl',false,15},
    {'Shift',true,5},{'Shift',false,5},{'Shift',true,5},{'Shift',false,5},
    {'Shift',true,5},{'Shift',false,50},
    {'Mouse',true,5},{'Mouse',false,15},
    {'Shift',true,5},{'Shift',false,5},{'Shift',true,5},{'Shift',false,50},
    {'Mouse',true,5},{'Mouse',false,5}
}
local gui = Instance.new('ScreenGui')
gui.Name = 'RIVALS_HYPER_SLIDE_HOLD_GUI'
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
pcall(function() gui.Parent = game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent = player:WaitForChild('PlayerGui') end
local btn = Instance.new('TextButton')
btn.Name = 'HyperSlideButton'
btn.Size = UDim2.fromOffset(128,55)
btn.Position = UDim2.new(0.75,0,0.65,0)
btn.BackgroundColor3 = Color3.fromRGB(30,22,19)
btn.BorderSizePixel = 0
btn.TextColor3 = Color3.fromRGB(255,165,55)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.Text = '⚡ HYPER SLIDE\nHOLD / TAP'
btn.AutoButtonColor = false
btn.Parent = gui
local lockBtn = Instance.new('TextButton')
lockBtn.Name = 'PositionLock'
lockBtn.Size = UDim2.fromOffset(38,32)
lockBtn.Position = UDim2.new(1,6,0,0)
lockBtn.BackgroundColor3 = Color3.fromRGB(48,32,23)
lockBtn.TextColor3 = Color3.fromRGB(255,172,65)
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextSize = 18
lockBtn.Text = '🔓'
lockBtn.AutoButtonColor = true
lockBtn.Parent = btn
local lockCorner = Instance.new('UICorner'); lockCorner.CornerRadius = UDim.new(0,9); lockCorner.Parent = lockBtn
local lockStroke = Instance.new('UIStroke'); lockStroke.Color = Color3.fromRGB(255,112,14); lockStroke.Thickness = 1; lockStroke.Parent = lockBtn
local function updateLock()
    lockBtn.Text = state.locked and '🔒' or '🔓'
    lockBtn.BackgroundColor3 = state.locked and Color3.fromRGB(112,48,12) or Color3.fromRGB(48,32,23)
end
local corner = Instance.new('UICorner'); corner.CornerRadius = UDim.new(0,13); corner.Parent = btn
local stroke = Instance.new('UIStroke'); stroke.Color = Color3.fromRGB(255,112,14); stroke.Thickness = 2; stroke.Parent = btn
local status = Instance.new('TextLabel')
status.Size = UDim2.fromOffset(180,20)
status.Position = UDim2.new(0.5,-90,1,4)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255,180,90)
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.Text = vim and 'Input support: unverified' or 'Input API unavailable'
status.Parent = btn
local function updateButton()
    btn.BackgroundColor3 = state.running and Color3.fromRGB(115,45,5) or Color3.fromRGB(30,22,19)
    btn.Text = state.running and '⚡ HYPER SLIDE\nRUNNING' or '⚡ HYPER SLIDE\nHOLD / TAP'
end
local function start()
    if not state.alive or state.running then return end
    state.running = true
    state.token = state.token + 1
    local token = state.token
    updateButton()
    task.spawn(function()
        repeat
            for _,entry in ipairs(sequence) do
                if token ~= state.token or not state.alive then break end
                local name,pressed,ms = entry[1],entry[2],entry[3]
                if name == 'Mouse' then sendMouse(pressed) else sendKey(name,pressed) end
                if not waitMs(ms,token) then break end
            end
            releaseAll()
            if token ~= state.token or not state.alive or not state.held then break end
            if not waitMs(40,token) then break end
        until false
        if token == state.token then state.running = false; updateButton() end
    end)
end
local function stop()
    state.held = false
    state.token = state.token + 1
    state.running = false
    releaseAll()
    updateButton()
end
-- Drag requires >12 px movement and unlocked state, otherwise it counts as a tap.
-- Lock remains available beside the button even while holding the slide button.
local activeInput, origin, startPosition, dragging, pressedAt
local function posOf(input) return Vector2.new(input.Position.X,input.Position.Y) end
local function move(input)
    if not activeInput or input ~= activeInput then return end
    local delta = posOf(input)-origin
    if not state.locked and delta.Magnitude > 12 then dragging=true end
    if dragging then
        btn.Position = UDim2.new(startPosition.X.Scale,startPosition.X.Offset+delta.X,startPosition.Y.Scale,startPosition.Y.Offset+delta.Y)
    end
end
local function finish(input)
    if not activeInput or input ~= activeInput then return end
    local wasDrag=dragging
    activeInput=nil; dragging=false
    if wasDrag then stop(); return end
    -- Quick tap completes one sequence; a longer hold stops on release.
    if os.clock() - pressedAt < 0.22 then
        state.held = false
    else
        stop()
    end
end
local function connect(signal,fn)
    local c=signal:Connect(fn)
    table.insert(state.connections,c)
    return c
end
connect(lockBtn.Activated,function()
    state.locked = not state.locked
    updateLock()
end)
connect(btn.InputBegan,function(input)
    if input.UserInputType ~= Enum.UserInputType.Touch and input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if activeInput then return end
    -- Lock button has its own input; don't start the macro when toggling lock.
    local p = posOf(input)
    local lp,ls = lockBtn.AbsolutePosition,lockBtn.AbsoluteSize
    if p.X >= lp.X and p.X <= lp.X+ls.X and p.Y >= lp.Y and p.Y <= lp.Y+ls.Y then return end
    activeInput=input
    origin=posOf(input)
    startPosition=btn.Position
    dragging=false
    pressedAt=os.clock()
    state.held=true
    start()
end)
connect(UIS.InputChanged,function(input)
    if not activeInput then return end
    if input==activeInput then move(input) end
    -- Mouse movement uses a separate MouseMovement input.
    if activeInput.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseMovement then
        local delta=posOf(input)-origin
        if not state.locked and delta.Magnitude>12 then dragging=true end
        if dragging then btn.Position=UDim2.new(startPosition.X.Scale,startPosition.X.Offset+delta.X,startPosition.Y.Scale,startPosition.Y.Offset+delta.Y) end
    end
end)
connect(UIS.InputEnded,function(input)
    if activeInput and (input==activeInput or (activeInput.UserInputType==Enum.UserInputType.MouseButton1 and input.UserInputType==Enum.UserInputType.MouseButton1)) then finish(activeInput) end
end)
function state.Stop()
    state.alive=false
    stop()
    for _,c in ipairs(state.connections) do pcall(function() c:Disconnect() end) end
    pcall(function() gui:Destroy() end)
    if env.RIVALS_HYPER_SLIDE==state then env.RIVALS_HYPER_SLIDE=nil end
end
