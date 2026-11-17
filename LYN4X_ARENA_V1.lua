-- LYN4X ARENA V1
-- Based on the texture-ID matching approach used by Pasha's Textures.
-- Replaces only matching textures locally; does not modify map geometry.

local TARGET_ID = "7658055825"
local NEW_TEXTURE = "rbxassetid://124967872055023"
local changed = 0

local function assetId(value)
    if type(value) ~= "string" then return nil end
    return value:match("rbxassetid://(%d+)")
        or value:match("[?&]id=(%d+)")
        or value:match("^(%d+)$")
end

local function replaceProperty(object, property)
    local ok, current = pcall(function() return object[property] end)
    if not ok or assetId(current) ~= TARGET_ID then return end
    local success = pcall(function() object[property] = NEW_TEXTURE end)
    if success then changed = changed + 1 end
end

local function inspect(object)
    if object:IsA("Texture") or object:IsA("Decal") then
        replaceProperty(object, "Texture")
    elseif object:IsA("MeshPart") then
        replaceProperty(object, "TextureID")
    elseif object:IsA("ImageLabel") or object:IsA("ImageButton") then
        replaceProperty(object, "Image")
    elseif object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Beam") then
        replaceProperty(object, "Texture")
    end
end

for index, object in ipairs(game:GetDescendants()) do
    inspect(object)
    if index % 250 == 0 then task.wait() end
end

game.DescendantAdded:Connect(function(object)
    task.defer(function()
        inspect(object)
        task.wait(0.25)
        if object.Parent then inspect(object) end
    end)
end)

print("[LYN4X ARENA V1] Replaced " .. changed .. " matching texture properties during initial scan.")
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LYN4X Arena V1",
        Text = "Texture scan complete: " .. changed .. " replacements",
        Duration = 5
    })
end)
