-- LYN4X ARENA V1 - GitHub image loader
-- Based on Pasha's texture-ID matching and local custom-asset approach.
-- Only replaces matching properties locally. Does not change arena geometry.

local URL = "https://raw.githubusercontent.com/lyn4x-js/New-/main/LYN4X_ARENA_V1.png"
local IDS = { ["7658055825"] = true }
local env = (getgenv and getgenv()) or _G
local write = (env and env.writefile) or writefile
local custom = (env and env.getcustomasset) or getcustomasset or getsynasset

if type(write) ~= "function" or type(custom) ~= "function" then
    warn("[LYN4X] writefile/getcustomasset unavailable")
    return
end

local ok, asset = pcall(function()
    local body = game:HttpGet(URL)
    assert(type(body) == "string" and #body > 100, "empty/invalid PNG response")
    write("LYN4X_ARENA_V1.png", body)
    return custom("LYN4X_ARENA_V1.png")
end)
if not ok or type(asset) ~= "string" or asset == "" then
    warn("[LYN4X] Could not load PNG: " .. tostring(asset))
    return
end

local function getid(v)
    if type(v) ~= "string" then return nil end
    return v:match("rbxassetid://(%d+)") or v:match("[?&]id=(%d+)") or v:match("^(%d+)$")
end

local queue, head = {}, 1
local queued = 0
local function qp(o, p)
    local success, v = pcall(function() return o[p] end)
    local id = success and getid(v)
    if id and IDS[id] then
        queue[#queue + 1] = {o, p, asset}
        queued = queued + 1
    end
end

local function inspect(o)
    if o:IsA("Texture") or o:IsA("Decal") then qp(o, "Texture")
    elseif o:IsA("MeshPart") then qp(o, "TextureID")
    elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then qp(o, "Image")
    elseif o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then qp(o, "Texture")
    end
end

for i, o in ipairs(game:GetDescendants()) do
    inspect(o)
    if i % 250 == 0 then task.wait() end
end

game.DescendantAdded:Connect(function(o)
    task.defer(function()
        inspect(o)
        task.wait(0.25)
        if o.Parent then inspect(o) end
    end)
end)

task.spawn(function()
    local applied = 0
    while true do
        local n = 0
        while head <= #queue and n < 8 do
            local x = queue[head]
            head = head + 1
            n = n + 1
            if x[1] and x[1].Parent then
                local success = pcall(function() x[1][x[2]] = x[3] end)
                if success then applied = applied + 1 end
            end
        end
        if n > 0 then print("[LYN4X] Applied: " .. applied .. " / queued: " .. queued) end
        task.wait(0.10)
    end
end)

print("[LYN4X] Image loaded; initial matches queued: " .. queued)
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "LYN4X Arena V1",
        Text = "Image loaded; queued " .. queued .. " matches",
        Duration = 5
    })
end)
