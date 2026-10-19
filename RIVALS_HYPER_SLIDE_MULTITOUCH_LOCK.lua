-- RIVALS HYPER SLIDE TOUCH / iPad: no keyboard or mouse simulation.
-- Hold the slide button for repeated short local air-floor bursts; release to stop.
-- Experimental: server-side collision and movement validation may prevent effects.
local Players=game:GetService('Players')
local UIS=game:GetService('UserInputService')
local RunService=game:GetService('RunService')
local player=Players.LocalPlayer
if not player then return end
local env=(getgenv and getgenv()) or _G
if env.RIVALS_HYPER_SLIDE_TOUCH and type(env.RIVALS_HYPER_SLIDE_TOUCH.Stop)=='function' then pcall(env.RIVALS_HYPER_SLIDE_TOUCH.Stop) end
local s={alive=true,held=false,locked=false,connections={},parts={}}
env.RIVALS_HYPER_SLIDE_TOUCH=s
local gui=Instance.new('ScreenGui')
gui.Name='RIVALS_HYPER_SLIDE_TOUCH_GUI';gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true
pcall(function() gui.Parent=game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent=player:WaitForChild('PlayerGui') end
local btn=Instance.new('TextButton')
btn.Size=UDim2.fromOffset(164,58);btn.Position=UDim2.new(1,-240,0.58,0)
btn.BackgroundColor3=Color3.fromRGB(29,25,29);btn.TextColor3=Color3.fromRGB(255,155,45)
btn.Text='HOLD: HYPER SLIDE';btn.TextSize=14;btn.Font=Enum.Font.GothamBold;btn.Active=true;btn.Parent=gui
Instance.new('UICorner',btn).CornerRadius=UDim.new(0,12)
local outline=Instance.new('UIStroke',btn);outline.Color=Color3.fromRGB(255,120,18);outline.Thickness=2
local lock=Instance.new('TextButton')
lock.Size=UDim2.fromOffset(56,58);lock.Position=UDim2.new(1,-69,0.58,0)
lock.BackgroundColor3=Color3.fromRGB(30,30,34);lock.TextColor3=Color3.fromRGB(255,160,55)
lock.Text='UNLOCK';lock.TextSize=10;lock.Font=Enum.Font.GothamBold;lock.Parent=gui
Instance.new('UICorner',lock).CornerRadius=UDim.new(0,12)
local folder=Instance.new('Folder');folder.Name='LocalHyperSlidePads';folder.Parent=workspace
for x=-1,1 do for z=-1,1 do
 local p=Instance.new('Part');p.Name='HyperPad';p.Size=Vector3.new(8,0.3,8)
 p.Anchored=true;p.CanCollide=false;p.CanTouch=false;p.CanQuery=false;p.Transparency=1;p.Parent=folder
 table.insert(s.parts,{p=p,x=x,z=z})
end end
local function pads(on)
 for _,e in ipairs(s.parts) do if e.p.Parent then e.p.CanCollide=on end end
end
local function connect(signal,fn) local c=signal:Connect(fn);table.insert(s.connections,c);return c end
-- Multitouch: only the finger that began on the slide button controls sliding.
-- Movement/camera fingers are ignored. Moving the UI uses a separate drag handle.
local slideFinger=nil
local dragFinger=nil
local dragOrigin=nil
local dragButtonOrigin=nil
local function pos(i) return Vector2.new(i.Position.X,i.Position.Y) end
local function display()
 btn.Text=s.held and 'SLIDING...' or 'HOLD: HYPER SLIDE'
 btn.BackgroundColor3=s.held and Color3.fromRGB(83,40,20) or Color3.fromRGB(29,25,29)
 lock.Text=s.locked and 'LOCKED' or 'UNLOCK'
end
local handle=Instance.new('TextButton')
handle.Name='MoveHandle'
handle.Size=UDim2.fromOffset(56,28)
handle.Position=UDim2.new(1,-69,0.58,-34)
handle.BackgroundColor3=Color3.fromRGB(30,30,34)
handle.TextColor3=Color3.fromRGB(255,160,55)
handle.Text='MOVE'
handle.TextSize=11
handle.Font=Enum.Font.GothamBold
handle.Active=true
handle.Parent=gui
Instance.new('UICorner',handle).CornerRadius=UDim.new(0,9)
connect(lock.Activated,function()
 s.locked=not s.locked
 if s.locked then dragFinger=nil end
 display()
end)
connect(btn.InputBegan,function(i)
 if slideFinger or (i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseButton1) then return end
 slideFinger=i
 s.held=true
 display()
end)
connect(handle.InputBegan,function(i)
 if s.locked or dragFinger or (i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseButton1) then return end
 dragFinger=i
 dragOrigin=pos(i)
 dragButtonOrigin=btn.Position
end)
connect(UIS.InputChanged,function(i)
 if not dragFinger or s.locked then return end
 if i~=dragFinger and not (dragFinger.UserInputType==Enum.UserInputType.MouseButton1 and i.UserInputType==Enum.UserInputType.MouseMovement) then return end
 local delta=pos(i)-dragOrigin
 local newPos=UDim2.new(dragButtonOrigin.X.Scale,dragButtonOrigin.X.Offset+delta.X,dragButtonOrigin.Y.Scale,dragButtonOrigin.Y.Offset+delta.Y)
 btn.Position=newPos
 lock.Position=UDim2.new(newPos.X.Scale,newPos.X.Offset+171,newPos.Y.Scale,newPos.Y.Offset)
 handle.Position=UDim2.new(newPos.X.Scale,newPos.X.Offset+171,newPos.Y.Scale,newPos.Y.Offset-34)
end)
connect(UIS.InputEnded,function(i)
 if i==slideFinger then
  slideFinger=nil
  s.held=false
  pads(false)
  display()
 end
 if i==dragFinger then dragFinger=nil end
end)
local ray=RaycastParams.new();ray.FilterType=Enum.RaycastFilterType.Exclude;ray.IgnoreWater=true
local burst,rest,slow,acc=0,0,0,0
connect(RunService.Heartbeat,function(dt)
 acc=acc+dt;if acc<1/30 then return end;dt=acc;acc=0
 if not s.alive or not s.held then burst=0;rest=0;slow=0;pads(false);return end
 local char=player.Character
 local hum=char and char:FindFirstChildOfClass('Humanoid')
 local root=char and char:FindFirstChild('HumanoidRootPart')
 if not hum or not root or hum.Health<=0 then pads(false);return end
 ray.FilterDescendantsInstances={char,folder}
 if workspace:Raycast(root.Position,Vector3.new(0,-4.5,0),ray) then pads(false);burst=0;return end
 local hs=Vector3.new(root.AssemblyLinearVelocity.X,0,root.AssemblyLinearVelocity.Z).Magnitude
 slow=hs<5 and slow+dt or 0
 if slow>=0.16 then pads(false);burst=0;rest=0.12;return end
 if rest>0 then rest=math.max(0,rest-dt);pads(false);return end
 local st=hum:GetState()
 if st~=Enum.HumanoidStateType.Freefall and st~=Enum.HumanoidStateType.Jumping then pads(false);return end
 if hs<5 then pads(false);return end
 burst=burst+dt
 if burst>=0.40 then burst=0;rest=0.12;pads(false);return end
 local center=root.Position-Vector3.new(0,3.2,0)
 for _,e in ipairs(s.parts) do e.p.CFrame=CFrame.new(center+Vector3.new(e.x*7,0,e.z*7));e.p.CanCollide=true end
end)
function s.Stop()
 s.alive=false;s.held=false;pads(false)
 for _,c in ipairs(s.connections) do pcall(function() c:Disconnect() end) end
 pcall(function() folder:Destroy() end);pcall(function() gui:Destroy() end)
 if env.RIVALS_HYPER_SLIDE_TOUCH==s then env.RIVALS_HYPER_SLIDE_TOUCH=nil end
end
display()
print('[Hyper Slide Multitouch] Slide finger independent from joystick/camera. MOVE handle + lock. Local physics; not guaranteed in RIVALS.')
