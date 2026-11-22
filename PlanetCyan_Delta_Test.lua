-- PlanetCyan skybox test (Voidstrap SkyboxPackV2, pack #12)
-- Upload this Lua and the six PlanetCyan_*.png images to lyn4x-js/New- (main branch).
-- Requires Delta support for writefile and getcustomasset.
local BASE = "https://raw.githubusercontent.com/lyn4x-js/New-/main/"
local Lighting = game:GetService("Lighting")
local faces = {Bk="bk", Dn="dn", Ft="ft", Lf="lf", Rt="rt", Up="up"}
if not (writefile and getcustomasset and game.HttpGet) then
    warn("[PlanetCyan] Missing writefile/getcustomasset/HttpGet support")
    return
end
local sky = Lighting:FindFirstChild("PlanetCyan_Test") or Instance.new("Sky")
sky.Name = "PlanetCyan_Test"
local applied = 0
for prop, suffix in pairs(faces) do
    local filename = "PlanetCyan_" .. suffix .. ".png"
    local ok, err = pcall(function()
        local data = game:HttpGet(BASE .. filename)
        assert(data:sub(1,8) == "\137PNG\r\n\26\n", "Not a PNG: " .. filename .. " (upload images first)")
        local localpath = "PlanetCyan_" .. suffix .. ".png"
        writefile(localpath, data)
        sky["Skybox" .. prop] = getcustomasset(localpath)
    end)
    if ok then applied = applied + 1 else warn("[PlanetCyan] " .. suffix .. ": " .. tostring(err)) end
end
if applied == 6 then
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") and obj ~= sky then obj.Parent = nil end
    end
    sky.Parent = Lighting
    print("[PlanetCyan] Applied 6/6 faces. Check the sky!")
else
    warn("[PlanetCyan] Only " .. applied .. "/6 faces loaded; not applying incomplete sky")
end
