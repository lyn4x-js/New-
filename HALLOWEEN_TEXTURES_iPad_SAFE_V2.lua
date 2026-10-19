-- TORNHUB Halloween V2 SAFE / iPad Delta
-- Arena-safe edition: leaves all 3D world textures and geometry untouched.
-- Uses the original Halloween replacement catalog; changes UI images and sounds only.
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local RAW = [==[[{"name":"kill sfx","replace_ids":[16530229616,16530229541,16530229695],"mode":"cdn","cdn_url":"https://github.com/sj8d44wbfk-glitch/dsadasd/raw/refs/heads/main/spooky.mp3"},{"name":"round win","replace_ids":[16810041280],"mode":"id","with_id":127039883737564},{"name":"load in sound","replace_ids":[6384899588],"mode":"id","with_id":71042715593043},{"name":"matchmaking","replace_ids":[18525513345],"mode":"id","with_id":97579569793218},{"name":"countdown","replace_ids":[17259538274],"mode":"id","with_id":139937992176184},{"name":"map chosen","replace_ids":[103035811146294],"mode":"id","with_id":83545626082037},{"name":"elimination","replace_ids":[17016581922],"mode":"cdn","cdn_url":"https://github.com/sj8d44wbfk-glitch/cccvv/raw/refs/heads/main/elimination%20sound.mp4"},{"name":"slide","replace_ids":[16737738420],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/halloween/raw/refs/heads/main/slide.mp3"},{"name":"jumps","replace_ids":[16770456156,16492958314],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/halloween/raw/refs/heads/main/jump.mp3"},{"name":"Round loss","replace_ids":[16810321565],"mode":"id","with_id":9114657434},{"name":"sudden death","replace_ids":[17467242617],"mode":"id","with_id":8503454443},{"name":"Heal","replace_ids":[17138490999],"mode":"id","with_id":132889570462667},{"name":"10 secods left","replace_ids":[17826470563],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/sj8d44wbfk-glitch/cccvv/refs/heads/main/10%20seconds%20left.mp4"},{"name":"ambience","replace_ids":[17813065011,12099785239,17813065464],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/sj8d44wbfk-glitch/cccvv/refs/heads/main/Final%20Duet_spotdown.org.mp3"},{"name":"ui click sound","replace_ids":[177266782],"mode":"id","with_id":79751504186543},{"name":"footsteps 2","replace_ids":[16621776521],"mode":"id","with_id":114768473003662},{"name":"footsteps 1","replace_ids":[16621776051],"mode":"id","with_id":131412978408311},{"name":"Lobby sound","replace_ids":[17697682466,17733314783,100081814360953,86062306109271,82135261819112,96771526359691,120824068504773,114306049661290,91718252417630,91718252417630,119694504935889],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/raw/refs/heads/main/lobby%20sound.mp3"},{"name":"double jump","replace_ids":[16770456156],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/raw/refs/heads/main/double%20jump.wav"},{"name":"PC","replace_ids":[17136633356],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/PC.png"},{"name":"PC centered","replace_ids":[88012714630436],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/PCcentered.png"},{"name":"Gamepad","replace_ids":[17136633629],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/Gamepad.png"},{"name":"Gamepad Centered","replace_ids":[110291144710849],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/GamepadCentered.png"},{"name":"Mobile","replace_ids":[17136633510,113510944677126],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/Mobile.png"},{"name":"close icon (non 3d)","replace_ids":[17838290166,108220438104376],"mode":"id","with_id":133109856518061},{"name":"item backround","replace_ids":[13220167337,13188242420,13220167472,13188153054,13188242287],"mode":"id","with_id":6959362636},{"name":"loading chicken, loading bandoboy","replace_ids":[133917828562858,121503061771505],"mode":"id","with_id":119314436005585},{"name":"streak","replace_ids":[17175092502,17094014569],"mode":"id","with_id":122988249096435},{"name":"scary loading character","replace_ids":[133917828562858,121503061771505],"mode":"id","with_id":111074270119042},{"name":"left side pumpkin","replace_ids":[13854780042],"mode":"id","with_id":111129958294654},{"name":"right side pumpkin","replace_ids":[13854780213],"mode":"id","with_id":83307514386645},{"name":"pumpkin level","replace_ids":[81461991645938],"mode":"id","with_id":124919713093667},{"name":"skull","replace_ids":[16802957270],"mode":"id","with_id":1564120517},{"name":"speed lines","replace_ids":[16469372946],"mode":"id","with_id":122250265541546},{"name":"speed lines (small)","replace_ids":[124819138379714],"mode":"id","with_id":70851299170792},{"name":"fonts","replace_ids":[12187323909,12187323909,12187320363,12187354260,12187342816,12187280273,12187303601,12187262242,12187288714,12187341500,12187271237,12187341020],"mode":"cdn","cdn_url":"https://github.com/sj8d44wbfk-glitch/cccvv/raw/refs/heads/main/Scary%20House.ttf"},{"name":"scary rivals load in","replace_ids":[17803962335],"mode":"id","with_id":132689682699518},{"name":"battle pass","replace_ids":[74965952714478],"mode":"id","with_id":140243872537540},{"name":"task","replace_ids":[17653923757],"mode":"id","with_id":101132881297918},{"name":"backpack","replace_ids":[18185474596],"mode":"id","with_id":96246732591868},{"name":"settings","replace_ids":[17619445191],"mode":"id","with_id":131243518610147},{"name":"basket","replace_ids":[17619445340],"mode":"id","with_id":72554446274272},{"name":"spooky gift","replace_ids":[18723333955],"mode":"id","with_id":101426962265276},{"name":"Servers icon","replace_ids":[12343093905],"mode":"id","with_id":97961276597177},{"name":"Settings Icon","replace_ids":[14641612286],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/SettingsIcon%20(1).png"},{"name":"Spooky Range","replace_ids":[112533350155197],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/ShootingRangeIcon%20(1).png"},{"name":"Book Icon","replace_ids":[18457336026],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/BookIcon.png"},{"name":"Mailbox Icon","replace_ids":[96509180790493],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/MailboxIcon.png"},{"name":"Inf Icon","replace_ids":[16782323002],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/InfIcon.png"},{"name":"Timer Icon","replace_ids":[18195730712],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/sky-assets/main/TimerIcon%20(1).png"},{"name":"textures","replace_ids":[7658055825],"mode":"cdn","cdn_url":"https://github.com/H4rb0r-rbx/Fleasion-pearlscent-textures/blob/main/Unknown.png?raw=true"},{"name":"SkyBK","replace_ids":[2108482005,14147881792,135908632589654,84214501374682,10196550937,12261809766],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_bk.tex"},{"name":"SkyDN","replace_ids":[2108545280,10196550667,14147882149,103020541883227,89972436184102,12261813110],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_dn.tex"},{"name":"SkyFT","replace_ids":[14147882761,12261809766,135908632589654,84214501374682,10196550367,2108482231],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_ft.tex"},{"name":"SkyLF","replace_ids":[14147883091,135908632589654,84214501374682,2108482395,12261809766,10196550128],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_lf.tex"},{"name":"SkyRT","replace_ids":[14147882405,135908632589654,84214501374682,2108482542,12261809766,10196549902],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_rt.tex"},{"name":"SkyUP","replace_ids":[14147881297,72960281658487,92138082970751,2108482676,10196567794,12261813678],"mode":"cdn","cdn_url":"https://raw.githubusercontent.com/slappy64/assets/main/sky512_up.tex"},{"name":"b1","replace_ids":[106623367501544],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/b1.png?raw=true"},{"name":"b2","replace_ids":[131795064007344],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/b2.png?raw=true"},{"name":"b3","replace_ids":[73543520622815],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/b3.png?raw=true"},{"name":"s1","replace_ids":[80716950169934],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/s1.png?raw=true"},{"name":"s2","replace_ids":[136100661820261],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/s2.png?raw=true"},{"name":"s3","replace_ids":[107898816876115],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/s3.png?raw=true"},{"name":"g1","replace_ids":[134520747948636],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/g1.png?raw=true"},{"name":"g2","replace_ids":[114166096331502],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/g2.png?raw=true"},{"name":"g3","replace_ids":[90039594400813],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/g3.png?raw=true"},{"name":"p1","replace_ids":[133903971285645],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/p1.png?raw=true"},{"name":"p2","replace_ids":[82834564754747],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/p2.png?raw=true"},{"name":"p3","replace_ids":[73345783863790],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/p3.png?raw=true"},{"name":"d1","replace_ids":[113997689031026],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/d1.png?raw=true"},{"name":"d2","replace_ids":[88059506918419],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/d2.png?raw=true"},{"name":"d3","replace_ids":[112183171942172],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/d3.png?raw=true"},{"name":"o1","replace_ids":[104871954739030],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/o1.png?raw=true"},{"name":"o2","replace_ids":[109012386782238],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/o2.png?raw=true"},{"name":"o3","replace_ids":[127982903682334],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/o3.png?raw=true"},{"name":"boneclaw icon","replace_ids":[17160682738],"mode":"id","with_id":105683695887301},{"name":"weapon background","replace_ids":[13220167337,13220167472,13188242420],"mode":"cdn","cdn_url":"https://github.com/leitopatatua-lab/ranks/blob/main/weapon%20bakground.png?raw=true"}]]==]
local rules = HttpService:JSONDecode(RAW)
local env = (getgenv and getgenv()) or _G
if env.TORNHUB_HALLOWEEN_SAFE and env.TORNHUB_HALLOWEEN_SAFE.Stop then
    pcall(env.TORNHUB_HALLOWEEN_SAFE.Stop)
end
local state = {active=true, changed={}, connections={}, cache={}, applied=0, skipped=0}
env.TORNHUB_HALLOWEEN_SAFE = state
local mapping = {}
for _,rule in ipairs(rules) do
    for _,id in ipairs(rule.replace_ids or {}) do
        -- First match wins, avoiding collisions between Halloween entries.
        if not mapping[tostring(id)] then mapping[tostring(id)] = rule end
    end
end
local function idOf(value)
    if type(value) ~= "string" then return nil end
    return value:match("(%d+)")
end
local function extOf(url)
    return ((url:match("^[^?]+") or url):match("%.([%w]+)$") or ""):lower()
end
local function customAsset(url, audio)
    if state.cache[url] then return state.cache[url] end
    local ext = extOf(url)
    if audio then
        if ext ~= "mp3" and ext ~= "wav" and ext ~= "ogg" then return nil end
    elseif ext ~= "png" and ext ~= "jpg" and ext ~= "jpeg" then
        return nil
    end
    if type(writefile) ~= "function" or type(getcustomasset) ~= "function" then return nil end
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if not ok or type(body) ~= "string" or #body < 32 then return nil end
    -- Reject obvious HTML error pages instead of setting them as textures.
    if body:sub(1,200):lower():find("<html",1,true) then return nil end
    local name = "TORNHUB_HalloweenSafe_" .. tostring(#body) .. "_" .. tostring(#url) .. "." .. ext
    if not pcall(writefile,name,body) then return nil end
    local valid, asset = pcall(getcustomasset,name)
    if not valid or type(asset) ~= "string" or asset == "" then return nil end
    state.cache[url] = asset
    return asset
end
local function replacementFor(rule, audio)
    if rule.mode == "id" and rule.with_id then
        return "rbxassetid://" .. tostring(rule.with_id)
    end
    if rule.mode == "cdn" and rule.cdn_url then
        return customAsset(rule.cdn_url, audio)
    end
end
local function apply(obj)
    if not state.active then return end
    -- Intentionally do NOT touch Decal, Texture, MeshPart, SpecialMesh,
    -- Sky, ParticleEmitter, Trail, Beam or any world geometry.
    local prop, audio
    if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
        prop, audio = "Image", false
    elseif obj:IsA("Sound") then
        prop, audio = "SoundId", true
    else
        return
    end
    local ok, original = pcall(function() return obj[prop] end)
    if not ok then return end
    local rule = mapping[idOf(original) or ""]
    if not rule then return end
    local replacement = replacementFor(rule, audio)
    if not replacement or replacement == original then state.skipped += 1; return end
    if not state.changed[obj] then state.changed[obj] = {} end
    if state.changed[obj][prop] then return end
    local success = pcall(function() obj[prop] = replacement end)
    if success then
        state.changed[obj][prop] = original
        state.applied += 1
    else
        state.skipped += 1
    end
end
local function watch(root)
    for _,obj in ipairs(root:GetDescendants()) do pcall(apply,obj) end
    table.insert(state.connections, root.DescendantAdded:Connect(function(obj)
        task.defer(function() pcall(apply,obj) end)
    end))
end
function state.Stop()
    state.active = false
    for _,connection in ipairs(state.connections) do pcall(function() connection:Disconnect() end) end
    for obj,props in pairs(state.changed) do
        for prop,original in pairs(props) do
            pcall(function() obj[prop] = original end)
        end
    end
    state.changed = {}
    warn("[Halloween Safe V2] Stopped; restored modified UI/audio properties.")
end
local player = Players.LocalPlayer
local gui = player and (player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui",10))
if gui then watch(gui) end
watch(SoundService)
-- Intentionally avoid workspace, ReplicatedStorage and StarterGui scanning.
warn("[Halloween Safe V2] Enabled. UI/audio replacements: " .. state.applied .. "; skipped: " .. state.skipped .. ". Arena textures untouched.")
warn("[Halloween Safe V2] To undo: getgenv().TORNHUB_HALLOWEEN_SAFE.Stop()")
