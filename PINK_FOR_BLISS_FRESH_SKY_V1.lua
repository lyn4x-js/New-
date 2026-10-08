-- Pink For Bliss | standalone fresh sky | Delta/iPad
local Lighting = game:GetService('Lighting')
local StarterGui = game:GetService('StarterGui')
local getAsset = getcustomasset or getsynasset
local urls = {
 Bk='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_bk.tex',
 Dn='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_dn.tex',
 Ft='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_ft.tex',
 Lf='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_lf.tex',
 Rt='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_rt.tex',
 Up='https://raw.githubusercontent.com/slappy64/pink-for-bliss/main/sky512_up.tex'
}
local function notify(msg)
 pcall(function() StarterGui:SetCore('SendNotification',{Title='Pink For Bliss Sky',Text=msg,Duration=7}) end)
end
if type(writefile)~='function' or type(getAsset)~='function' then
 notify('Delta file/custom asset support unavailable')
 return
end
local assets={}
for _,face in ipairs({'Bk','Dn','Ft','Lf','Rt','Up'}) do
 local ok,bytes=pcall(function() return game:HttpGet(urls[face]) end)
 if not ok or type(bytes)~='string' or #bytes<64 then
  notify('Download failed: '..face)
  warn('[Pink For Bliss] Failed to download '..face..': '..tostring(bytes))
  return
 end
 local ext='.png'
 if bytes:sub(1,3)=='\255\216\255' then ext='.jpg'
 elseif bytes:sub(1,4)=='RIFF' then ext='.webp'
 elseif bytes:sub(1,4)~='\137PNG' then
  warn('[Pink For Bliss] Unknown image format for '..face..'; trying PNG extension')
 end
 local path='pink_for_bliss_'..face..ext
 local wrote,writeErr=pcall(writefile,path,bytes)
 if not wrote then notify('File save failed: '..face); warn(writeErr); return end
 local loaded,asset=pcall(getAsset,path)
 if not loaded or type(asset)~='string' then
  notify('Custom asset failed: '..face)
  warn('[Pink For Bliss] '..tostring(asset))
  return
 end
 assets[face]=asset
 task.wait()
end
local running=true
local applying=false
local function apply()
 if not running or applying then return end
 applying=true
 for _,child in ipairs(Lighting:GetChildren()) do
  if child:IsA('Sky') then child:Destroy() end
 end
 local sky=Instance.new('Sky')
 sky.Name='PinkForBlissFreshSky'
 for _,face in ipairs({'Bk','Dn','Ft','Lf','Rt','Up'}) do
  sky['Skybox'..face]=assets[face]
 end
 sky.Parent=Lighting
 applying=false
end
apply()
notify('All 6 sky faces loaded!')
local last=0
Lighting.ChildAdded:Connect(function(child)
 if running and child:IsA('Sky') and child.Name~='PinkForBlissFreshSky' then
  local now=os.clock()
  if now-last>.5 then
   last=now
   task.delay(.1,apply)
  end
 end
end)
for _,delaySeconds in ipairs({.5,1.5,3,6,10}) do
 task.delay(delaySeconds,apply)
end
