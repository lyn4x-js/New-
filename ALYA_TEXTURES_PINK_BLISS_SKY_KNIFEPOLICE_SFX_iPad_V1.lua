-- Alya Textures + Pink For Bliss Sky + KnifePolice SFX - iPad/Delta
local function run(url, name)
 local ok, err = pcall(function()
  local src = game:HttpGet(url)
  local fn = loadstring(src)
  assert(type(fn) == "function", "loadstring failed")
  fn()
 end)
 if not ok then warn("[" .. name .. "] failed: " .. tostring(err)) end
 return ok
end

local alya = run("https://raw.githubusercontent.com/lyn4x-js/I-pad-ez/main/Alya_iPad_Adaptive_Standalone_V1.lua", "Alya Textures")
task.wait(0.5)
local sky = run("https://raw.githubusercontent.com/lyn4x-js/New-/main/PINK_FOR_BLISS_FRESH_SKY_V1.lua", "Pink For Bliss Sky")
task.wait(0.5)
local sfx = run("https://raw.githubusercontent.com/lyn4x-js/Textures/main/KNIFEPOLICE_SFX_ONLY_iPad_V1.lua", "KnifePolice SFX")

pcall(function()
 game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "Alya + Pink Bliss + KnifePolice",
  Text = (alya and sky and sfx) and "Scripts started; check in-game results" or "One or more scripts failed; check console",
  Duration = 6
 })
end)
