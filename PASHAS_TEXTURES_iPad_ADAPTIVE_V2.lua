-- PASHA'S TEXTURES - iPad/Delta Adaptive V2
local env=(getgenv and getgenv()) or _G
local G=getcustomasset or getsynasset
if not writefile or not G then
    warn("[Pasha V2] missing writefile/getcustomasset")
    return
end

local KEY="__PASHA_TEXTURES_V2"
if env[KEY] and env[KEY].connections then
    for _,c in ipairs(env[KEY].connections) do
        pcall(function() c:Disconnect() end)
    end
end

local state={connections={},running=true}
env[KEY]=state

local function keep(c)
    if c then table.insert(state.connections,c) end
end

local function fetch(url,file)
    local ok,body=pcall(function()
        return game:HttpGet(url)
    end)
    if not ok or type(body)~="string" or #body<20 then
        warn("[Pasha V2] texture download failed")
        return nil
    end
    if not pcall(function() writefile(file,body) end) then
        warn("[Pasha V2] texture write failed")
        return nil
    end
    local ok2,asset=pcall(function()
        return G(file)
    end)
    if ok2 then return asset end
end

local texture=fetch(
    "https://github.com/pashagamer23221-spec/texture/blob/main/texture.png?raw=true",
    "pasha_texture_v2.png"
)
if not texture then return end

local TARGET="7658055825"
local queue,head={},1

local function rid(v)
    return tostring(v or ""):match("(%d+)")
end

local function queueProp(obj,prop)
    local ok,v=pcall(function() return obj[prop] end)
    if ok and rid(v)==TARGET and v~=texture then
        queue[#queue+1]={obj,prop,texture}
    end
end

local function inspect(obj)
    if obj:IsA("Texture") or obj:IsA("Decal") then
        queueProp(obj,"Texture")
    elseif obj:IsA("MeshPart") then
        queueProp(obj,"TextureID")
    elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        queueProp(obj,"Image")
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
        queueProp(obj,"Texture")
    elseif obj:IsA("SpecialMesh") then
        queueProp(obj,"TextureId")
    end
end

for i,obj in ipairs(game:GetDescendants()) do
    inspect(obj)
    if i%250==0 then task.wait() end
end

keep(game.DescendantAdded:Connect(function(obj)
    task.defer(function()
        if env[KEY]==state and obj.Parent then
            inspect(obj)
            task.wait(.25)
            if obj.Parent then inspect(obj) end
        end
    end)
end))

task.spawn(function()
    while state.running and env[KEY]==state do
        local n=0
        while head<=#queue and n<8 do
            local item=queue[head]
            head+=1
            n+=1
            if item[1] and item[1].Parent then
                pcall(function()
                    item[1][item[2]]=item[3]
                end)
            end
        end
        task.wait(.10)
    end
end)

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title="Pasha Textures V2",
        Text="Texture pack loaded",
        Duration=6
    })
end)
