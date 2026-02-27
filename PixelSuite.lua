local red = "\27[31m"
local reset = "\27[0m"
local theme = "\27[36m"
local green = "\27[32m"
local yellow = "\27[33m"
local purple = "\27[35m"
local cyan = "\27[36m"

local version = "Pixel Suite vF1.3.2: Polished"
math.randomseed(os.time())

-- --- DATABASE ENGINE --- --
local db_file = "pixel_db.txt"
local backup_file = "pixel_db.bak"
local users = { Ahmed = {pass = "1234", isAdmin = true} }

-- --- QoL FUNCTIONS --- --
local function get_input()
    local input = io.read()
    if input == nil or input == "" then
        print(red .. "Input cannot be blank!" .. reset)
        return get_input()
    end
    return input
end

local function encrypt(pass)
    local secret = ""
    for i = 1, #pass do
        secret = secret .. string.char(string.byte(pass, i) + 1)
    end
    return secret
end

local function decrypt(secret)
    local pass = ""
    for i = 1, #secret do
        pass = pass .. string.char(string.byte(secret, i) - 1)
    end
    return pass
end

local function save_db()
    os.remove(backup_file)
    os.rename(db_file, backup_file)
    local f = io.open(db_file, "w")
    if f then
        for k, v in pairs(users) do
            f:write(k .. ":" .. encrypt(v.pass) .. ":" .. tostring(v.isAdmin) .. "\n")
        end
        f:close()
    end
end

local function load_db()
    local f = io.open(db_file, "r")
    if f then
        for line in f:lines() do
            local name, secret, adminStatus = line:match("([^:]+):([^:]+):([^:]+)")
            if name and secret and adminStatus then
                users[name] = {pass = decrypt(secret), isAdmin = (adminStatus == "true")}
            end
        end
        f:close()
    end
end

load_db()

-- --- RAINBOW LOGO & ENTRY --- --
::session_start::
print(red.."P"..yellow.."I"..green.."X"..cyan.."E"..purple.."L "..red.."S"..yellow.."U"..green.."I"..cyan.."T"..purple.."E")
print(theme .. "1. Sign Up | 2. Login" .. reset)
local entry = get_input()

-- HIDDEN RECOVERY COMMAND
if entry == "DEBUG_DB" then
    print(purple .. "\n--- ADMIN DATABASE OVERRIDE ---" .. reset)
    for name, v in pairs(users) do print("USER: " .. name .. " | PASS: " .. v.pass .. " | Admin: " .. tostring(v.isAdmin)) end
    print(purple .. "-------------------------------" .. reset)
    print("Press Enter to continue...")
    io.read()
end

local username = "Guest"
local isCurrentUserAdmin = false

if entry == "1" then
    print("\nNEW USERNAME (Max 23 chars):")
    local nu = get_input()
    if #nu > 23 then nu = string.sub(nu, 1, 23) end
    
    local np = ""
    ::pass_entry::
    print("CREATE PASSWORD (4-40 chars):")
    np = get_input()
    if #np < 4 or #np > 40 then 
        print(red .. "Invalid length (4-40)!" .. reset)
        goto pass_entry 
    end
    users[nu] = {pass = np, isAdmin = false}
    save_db()
    username = nu
    isCurrentUserAdmin = false
    print(green.."Account Created & Secured!"..reset)
else
    ::login_gate::
    print("\nUSERNAME:")
    local un = get_input()
    print("PASSWORD:")
    local up = get_input()
    if users[un] and users[un].pass == up then
        username = un
        isCurrentUserAdmin = users[un].isAdmin
        print(green.."Access Granted!"..reset)
    else
        print(red.."Login failed. Try again or type 'Guest'."..reset)
        if un ~= "Guest" then goto login_gate end
    end
end

-- BOOT SEQUENCE --
print(theme .. "\nBOOTING " .. version .. "..." .. reset)
for i = 1, 15 do
    io.write(green .. "█")
    io.flush()
    for d = 1, 100000 do end 
end

-- --- MAIN APP LOOP --- --
local app_running = true
while app_running do
    print("\n" .. theme .. "===============================" .. reset)
    print(theme .. "    USER: " .. string.upper(username))
    print(theme .. "    " .. version .. reset)
    print("1. PIXEL CALCULATOR")
    print("2. PIXEL MINIGAMES")
    print("3. LATEST NEWS")
    print("4. SETTINGS & PROFILE")
    if isCurrentUserAdmin then print(red.."5. ADMIN PANEL"..reset) end
    print("6. EXIT")
    print(theme .. "-------------------------------" .. reset)
    
    local choice = get_input()

    -- EASTER EGGS & SECRETS --
    if choice == "G3M1N1" then
        print(cyan.."\nPolished and secured. API integration is possible! <3"..reset)
        io.read()
    elseif choice == "Lo Siento" then
        for i=1,30 do print(cyan.."WILSON LO SIENTO WILSON 😭"..reset) end
    elseif choice == "67" then
        print(purple.."\n[SECRET] Order 67 activated. Analyzing pixels... ERROR."..reset)
        io.read()
    elseif choice == "bababoi" then
        for i=1,30 do print(red.."I'M ANGRY! BABABOI!"..reset) end
    
    -- 1. CALCULATOR --
    elseif choice == "1" then
        print(yellow.."\n--- CALCULATOR (Type 'back' to exit) ---"..reset)
        print("Op [+, -, *, /]:")
        local op = get_input()
        if op ~= "back" then
            print("Num 1:") local n1 = tonumber(get_input())
            print("Num 2:") local n2 = tonumber(get_input())
            if n1 and n2 then
                if op == "+" then print(green.."RES: "..(n1+n2)..reset)
                elseif op == "-" then print(green.."RES: "..(n1-n2)..reset)
                elseif op == "*" then print(green.."RES: "..(n1*n2)..reset)
                elseif op == "/" then print(green.."RES: "..(n1/n2)..reset) end
            else print(red.."NUMBERS ONLY"..reset) end
        end

    -- 2. MINIGAMES --
    elseif choice == "2" then
        print(theme.."\n--- MINIGAMES ---\n1. RNG\n2. Ping-Pong 🏓\n3. FOTD\n4. Back"..reset)
        local g = get_input()
        if g == "1" then
            print("Min Num:") local mn = tonumber(get_input())
            print("Max Num:") local mx = tonumber(get_input())
            if mn and mx and mn < mx then print(green.."GEN: "..math.random(mn, mx)..reset) else print(red.."INVALID RANGE"..reset) end
        elseif g == "2" then
            print(cyan .. "\nPING-PONG: [1]L [2]M [3]R")
            local p_pos = tonumber(get_input())
            if p_pos == math.random(1,3) then print(red.."BLOCKED"..reset) else print(green.."GOAL!"..reset) end
        elseif g == "3" then
            local facts = {"Lua means Moon.", "Honey never spoils.", "Octopuses have 3 hearts.", "Ahmed is the lead dev.", "Pixels are tiny.", "Saturn rains diamonds.", "Venus days are long.", "Bananas are berries.", "Computers love 0 and 1.", "You are using Pixel Suite!"}
            print(purple.."FACT: "..facts[math.random(1,#facts)]..reset)
        end

    -- 3. NEWS --
    elseif choice == "3" then
        print(purple.."\n--- NEWS ARCHIVE ---\n1. vF1.3.2 (Polished)\n2. Back"..reset)
        local n_choice = get_input()
        if n_choice == "1" then
            print(yellow.."\nNEWS: vF1.3.2 Polished Edition\n- Fixed RNG & Minigames.\n- Username/Pass length limits.\n- Anti-blank input system."..reset)
            io.read()
        end

    -- 4. PROFILE --
    elseif choice == "4" then
        print(theme.."\n--- SETTINGS & PROFILE ---"..reset)
        print("1. User Info")
        if isCurrentUserAdmin then print("2. View Raw DB File") end
        print("3. LOG OUT\n4. Back")
        local s_choice = get_input()
        if s_choice == "1" then
            print("USER: "..username.."\nRole: "..(isCurrentUserAdmin and "Admin" or "User"))
            io.read()
        elseif s_choice == "2" and isCurrentUserAdmin then
            print(cyan.."\n--- RAW DATABASE CONTENT ---"..reset)
            local f = io.open(db_file, "r")
            if f then print(f:read("*all")) f:close() else print("File not found.") end
            io.read()
        elseif s_choice == "3" then
            app_running = false
            goto session_start
        end

    -- 5. ADMIN --
    elseif choice == "5" and isCurrentUserAdmin then
        print(red.."\n--- ADMIN PANEL ---\n1. Ban User\n2. Back"..reset)
        local a = get_input()
        if a == "1" then
            print("Name to ban:")
            local b = get_input()
            if b ~= username then users[b] = nil save_db() print("Banned.") end
        end

    -- 6. EXIT --
    elseif choice == "6" then
        print(yellow.."Goodbye, "..username.."!"..reset)
        app_running = false
    end
end
