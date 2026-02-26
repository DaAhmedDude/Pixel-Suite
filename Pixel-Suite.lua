local red = "\27[31m"
local reset = "\27[0m"
local theme = "\27[36m"
local green = "\27[32m"
local yellow = "\27[33m"
local purple = "\27[35m"
local cyan = "\27[36m"

local version = "v1.2 (User Profile)"
math.randomseed(os.time())

-- LOGIN SYSTEM --
print(cyan .. "SYSTEM IDENTITY CHECK" .. reset)
print("Please enter your name:")
local username = io.read()
if username == "" or username == nil then username = "Guest" end

-- BOOT SEQUENCE --
print(theme .. "\nINITIALIZING FOR " .. string.upper(username) .. "..." .. reset)
for i = 1, 20 do
    io.write(green .. "█")
    io.flush()
    for delay = 1, 300000 do end 
end
print(green .. " 100%" .. reset)

::main_menu::
print("\n" .. theme .. "===============================" .. reset)
print(theme .. "    WELCOME, " .. string.upper(username) .. reset)
print(theme .. "    PIXEL SUITE " .. version .. reset)
print(theme .. "===============================" .. reset)
print("1. PIXEL CALCULATOR")
print("2. MINIGAMES")
print("3. SETTINGS & PROFILE")
print("4. CREDITS")
print("5. EXIT")
print(theme .. "-------------------------------" .. reset)
local choice = io.read()

if choice == "bababoi" then
  for i = 1, 30 do print(red .. "I'M ANGRY! BABABOI!" .. reset) end
  goto main_menu
elseif choice == "67" then
  print(purple .. "  __    ______  " .. reset)
  print(purple .. " / /   |___  /  " .. reset)
  print(purple .. "/ _ \\     / /   " .. reset)
  print(purple .. "|(_) |   / /    " .. reset)
  print(purple .. " \\__/   /_/     " .. reset)
  print(yellow .. "THE MAGIC NUMBER!!" .. reset)
  local colors = {red, yellow, green, cyan, purple}
  for i = 1, 100 do
    local c = colors[math.random(1, #colors)]
    print(c .. "67 67 67 67 67 67 67 67 67 67")
  end
  io.read()
  goto main_menu
elseif choice == "1" then
  ::calc_start::
  print(yellow .. "\n--- PIXEL CALCULATOR ---" .. reset)
  print("Op [+, -, *, /] or 'back':")
  local op = io.read()
  if op == "back" then goto main_menu end
  print("Num 1:")
  local n1 = tonumber(io.read())
  print("Num 2:")
  local n2 = tonumber(io.read())
  if n1 == nil or n2 == nil then 
    print(red.."NUMBERS ONLY"..reset) 
    goto calc_start 
  end
  local res = 0
  if op == "+" then res = n1 + n2
  elseif op == "-" then res = n1 - n2
  elseif op == "*" or op == "x" then res = n1 * n2
  elseif op == "/" then 
    if n2 == 0 then print(red.."DIV 0 ERROR"..reset) goto calc_start end
    res = n1 / n2
  end
  print(green .. "RESULT: " .. res .. reset)
  goto calc_start
elseif choice == "2" then
  ::game_menu::
  print(theme .. "\n--- MINIGAMES ---" .. reset)
  print("1. RNG")
  print("2. Shi-Fu-Mi!")
  print("3. Back")
  local g_choice = io.read()
  if g_choice == "1" then
    print("Min:")
    local min = tonumber(io.read())
    print("Max:")
    local max = tonumber(io.read())
    if min and max then print(green .. "GEN: " .. math.random(min, max) .. reset)
    else print(red .. "INVALID" .. reset) end
    goto game_menu
  elseif g_choice == "2" then
    print(yellow .. "1:Rock, 2:Paper, 3:Scissors" .. reset)
    local p = tonumber(io.read())
    local c = math.random(1, 3)
    local n = {"Rock", "Paper", "Scissors"}
    if p and p >= 1 and p <= 3 then
      print(username .. ": "..n[p].." | Phone: "..n[c])
      if p == c then print(yellow.."DRAW"..reset)
      elseif (p==1 and c==3) or (p==2 and c==1) or (p==3 and c==2) then print(green.."WIN"..reset)
      else print(red.."LOSE"..reset) end
    end
    goto game_menu
  elseif g_choice == "3" then 
    goto main_menu 
  end
elseif choice == "3" then
  ::settings::
  print(theme .. "\n--- SETTINGS & PROFILE ---" .. reset)
  print("1. Change Theme Color")
  print("2. User Info")
  print("3. Back")
  local s_choice = io.read()
  if s_choice == "1" then
    print("Pick: [1] Cyan, [2] Green, [3] Purple, [4] Yellow")
    local t_choice = io.read()
    if t_choice == "1" then theme = "\27[36m"
    elseif t_choice == "2" then theme = "\27[32m"
    elseif t_choice == "3" then theme = "\27[35m"
    elseif t_choice == "4" then theme = "\27[33m" end
    goto settings
  elseif s_choice == "2" then
    print(theme .. "CURRENT USER: " .. username .. reset)
    print("RANK: Pixel Suite Developer")
    print("BUILD: " .. version)
    print("Press Enter...")
    io.read()
    goto settings
  elseif s_choice == "3" then 
    goto main_menu 
  end
elseif choice == "4" then
  print(yellow .. "Made by: Ahmed\nSpecial User: " .. username .. reset)
  io.read()
  goto main_menu
elseif choice == "5" then
  print(yellow .. "Goodbye, " .. username .. "!" .. reset)
  return
else
  print(red .. "Invalid choice!" .. reset)
  goto main_menu
end
