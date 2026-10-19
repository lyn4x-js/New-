-- RIVALS GROUND HYPER SLIDE / iPad experiment
-- Uses the game's EXISTING Slide GUI action; does not spawn platforms or modify speed.
-- Requires executor support for getconnections + firesignal (or a compatible signal firing API).
-- If unsupported, the UI reports UNAVAILABLE rather than pretending it slid.
local Players=game:GetService('Players')
local UIS=game:GetService('UserInputService')
local player=Players.LocalPlayer
if not player then return end
local env=(getgenv and getgenv()) or _G
if env.RIVALS_GROUND_HYPER and env.RIVALS_GROUND_HYPER.Stop then pcall(env.RIVALS_GROUND_HYPER.Stop) end
local s={alive=true,held=false,locked=false,connections={},target=nil,interval=.34,between=.065}
env.RIVALS_GROUND_HYPER=s
local function listen(sig,fn) local c=sig:Connect(fn);table.insert(s.connections,c);return c end
local gui=Instance.new('ScreenGui');gui.Name='RIVALS_GROUND_HYPER_GUI';gui.ResetOnSpawn=false;gui.IgnoreGuiInset=true
pcall(function() gui.Parent=game:GetService('CoreGui') end)
if not gui.Parent then gui.Parent=player:WaitForChild('PlayerGui') end
local function button(name,txt,w,h,x,y)
 local b=Instance.new('TextButton');b.Name=name;b.Text=txt;b.Size=UDim2.fromOffset(w,h);b.Position=UDim2.new(1,x,.56,y)
 b.BackgroundColor3=Color3.fromRGB(25,25,30);b.TextColor3=Color3.fromRGB(255,153,45)
 b.Font=Enum.Font.GothamBold;b.TextSize=13;b.Active=true;b.Parent=gui
 Instance.new('UICorner',b).CornerRadius=UDim.new(0,10)
 local stroke=Instance.new('UIStroke',b);stroke.Color=Color3.fromRGB(255,118,22);stroke.Thickness=1.5
 return b
end
local slide=button('Slide','HOLD: DOUBLE SLIDE',180,58,-245,0)
local lock=button('Lock','UNLOCK',60,42,-62,0)
local move=button('Move','MOVE',60,32,-62,-38)
local scan=button('Scan','FIND SLIDE',180,32,-245,-38)
local status=Instance.new('TextLabel');status.BackgroundTransparency=1;status.Size=UDim2.fromOffset(245,32)
status.Position=UDim2.new(1,-245,.56,65);status.Text='Find the in-game Slide button';status.TextSize=12
status.TextWrapped=true;status.TextColor3=Color3.fromRGB(255,175,85);status.Font=Enum.Font.Gotham;status.Parent=gui
local function setStatus(t) if s.alive then status.Text=t end end
local function validTarget(obj)
 return obj and obj.Parent and obj:IsA('GuiButton') and obj~=slide and obj~=lock and obj~=move and obj~=scan
end
local function findSlide()
 local pg=player:FindFirstChild('PlayerGui');if not pg then return nil end
 local best,score=nil,-100
 for _,obj in ipairs(pg:GetDescendants()) do
  if obj:IsA('GuiButton') and obj.Visible then
   local name=(obj.Name..' '..(obj:IsA('TextButton') and obj.Text or '')):lower()
   local n=0
   if name:find('slide',1,true) then n=n+20 end
   if name:find('crouch',1,true) then n=n-12 end
   if name:find('sprint',1,true) then n=n-12 end
   if n>score and n>0 then best=obj;score=n end
  end
 end
 return best
end
local function fireSlide()
 if not validTarget(s.target) then s.target=findSlide() end
 if not s.target then return false,'Slide button not found' end
 if type(getconnections)~='function' then return false,'Executor cannot fire GUI actions' end
 local ok,connections=pcall(getconnections,s.target.Activated)
 if not ok or type(connections)~='table' or #connections==0 then
  return false,'Slide Activated handlers unavailable'
 end
 local count=0
 for _,c in ipairs(connections) do
  if type(c.Fire)=='function' then
   local fired=pcall(function() c:Fire() end);if fired then count=count+1 end
  end
 end
 if count==0 then return false,'Executor cannot invoke Slide handlers' end
 return true
end
listen(scan.Activated,function()
 s.target=findSlide()
 setStatus(s.target and ('Found: '..s.target.Name..' (not yet verified)') or 'Could not find Slide GUI; open RIVALS controls')
end)
listen(lock.Activated,function() s.locked=not s.locked;lock.Text=s.locked and 'LOCKED' or 'UNLOCK' end)
local slideFinger,dragFinger,dragStart,original
local function xy(i) return Vector2.new(i.Position.X,i.Position.Y) end
listen(slide.InputBegan,function(i)
 if slideFinger or (i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseButton1) then return end
 slideFinger=i;s.held=true;slide.Text='REPEATING...'
end)
listen(move.InputBegan,function(i)
 if s.locked or dragFinger or (i.UserInputType~=Enum.UserInputType.Touch and i.UserInputType~=Enum.UserInputType.MouseButton1) then return end
 dragFinger=i;dragStart=xy(i);original=slide.Position
end)
listen(UIS.InputChanged,function(i)
 if not dragFinger or s.locked then return end
 if i~=dragFinger and not (dragFinger.UserInputType==Enum.UserInputType.MouseButton1 and i.UserInputType==Enum.UserInputType.MouseMovement) then return end
 local d=xy(i)-dragStart;local p=UDim2.new(original.X.Scale,original.X.Offset+d.X,original.Y.Scale,original.Y.Offset+d.Y)
 slide.Position=p;scan.Position=UDim2.new(p.X.Scale,p.X.Offset,p.Y.Scale,p.Y.Offset-38)
 lock.Position=UDim2.new(p.X.Scale,p.X.Offset+183,p.Y.Scale,p.Y.Offset)
 move.Position=UDim2.new(p.X.Scale,p.X.Offset+183,p.Y.Scale,p.Y.Offset-38)
 status.Position=UDim2.new(p.X.Scale,p.X.Offset,p.Y.Scale,p.Y.Offset+65)
end)
listen(UIS.InputEnded,function(i)
 if i==slideFinger then slideFinger=nil;s.held=false;slide.Text='HOLD: DOUBLE SLIDE' end
 if i==dragFinger then dragFinger=nil end
end)
function s.Stop()
 s.alive=false;s.held=false
 for _,c in ipairs(s.connections) do pcall(function() c:Disconnect() end) end
 pcall(function() gui:Destroy() end)
end
task.spawn(function()
 while s.alive do
  if s.held then
   local ok,msg=fireSlide()
   if ok then
    task.wait(s.between)
    if s.held and s.alive then ok,msg=fireSlide() end
   end
   if not ok then
    setStatus('UNAVAILABLE: '..tostring(msg))
    s.held=false;slideFinger=nil;slide.Text='HOLD: DOUBLE SLIDE'
   else
    setStatus('Double Slide sent (game result unverified)')
   end
   task.wait(s.interval)
  else task.wait(.04) end
 end
end)
