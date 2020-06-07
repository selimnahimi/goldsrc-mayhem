-- Serverside buymenu handling, for purchase requests and the like.

local teamCSWeapons = {
    "weapon_cs16_elite_fix",
    "weapon_cs16_p228_fix",
    "weapon_cs16_glock18_fix",
    "weapon_cs16_aug_fix",
    "weapon_cs16_famas_fix",
    "weapon_cs16_ak47_fix",
    "weapon_cs16_g3sg1_fix",
    "weapon_cs16_p90_fix",
    "weapon_cs16_fiveseven_fix",
    "weapon_cs16_flashbang_fix",
    "weapon_cs16_hegrenade_fix",
    "weapon_cs16_smokegrenade_fix",
    "weapon_cs16_galil_fix",
    "weapon_cs16_mac10_fix",
    "weapon_cs16_usp_fix",
    "weapon_cs16_mp5navy_fix",
    "weapon_cs16_ump45_fix",
    "weapon_cs16_knife_fix",
    "weapon_cs16_deagle_fix",
    "weapon_cs16_sg550_fix",
    "weapon_cs16_sg552_fix",
    "weapon_cs16_m3_fix",
    --"weapon_cs16_xm1014_fix",
    "weapon_cs16_m249_fix",
    "weapon_cs16_awp_fix",
    "weapon_cs16_m4a1_fix",
    "weapon_cs16_tmp_fix",
    "weapon_cs16_scout_fix"
}

local teamHLWeapons = {
    "weapon_hl1_glock",
    "weapon_hl1_357",
    "weapon_hl1_mp5",
    "weapon_hl1_shotgun",
    "weapon_hl1_crossbow",
    "weapon_hl1_tripmine",
    "weapon_hl1_satchel",
    "weapon_hl1_handgrenade",
}

-- {price, can buy ammo?, spawnamount}
-- spawnamount is basically how many times itll be spawned -> more ammo
local HLspecialWeapons = {
    ["weapon_hl1_gauss"] = {5, false, 1},
    ["hl1_ammo_argrenades"] = {10, false, 1},
    ["weapon_hl1_rpg"] = {10, false, 2},
    ["weapon_hlof_displacer"] = {15, false, 1},
    ["item_longjump"] = {15, false, 1},
    ["weapon_hl1_egon"] = {25, false, 1}
}

local CSspecialWeapons = {
    ["weapon_hl1_tripmine"] = {5, false, 1},
    ["weapon_hl1_satchel"] = {5, false, 1},
    ["weapon_hl1_rpg"] = {10, false, 2},
    ["weapon_hlof_displacer"] = {15, false, 1},
    ["weapon_hl1_gauss"] = {15, false, 4},
    ["item_longjump"] = {20, false, 1},
    ["weapon_hl1_egon"] = {25, false, 2},
    ["weapon_cs16_xm1014_fix"] = {5, true, 1}
}

-- Ammo given in a specified amount instead of 90
local ammoAmount = {
    ["TripMine"] = 2,
    ["Satchel"] = 2,
    ["Grenade"] = 2,
    ["XBowBolt"] = 10,
    ["CS16_BUCKSHOT"] = 20
}

-- Ammo given in a specified amount instead of 90
-- first is the amount, second is the ammo type
local HLspecialAmmo = {
    ["weapon_hl1_tripmine"] = {2, "TripMine"},
    ["weapon_hl1_satchel"] = {2, "Satchel"},
    ["weapon_hl1_handgrenade"] = {2, "Grenade"},
    ["weapon_hl1_crossbow"] = {10, "XBowBolt"}
}

local CSspecialAmmo = {
    ["weapon_cs16_xm1014_fix"] = {20, ""}
}

-- Networking
util.AddNetworkString( "buyPlayerWeapon" )
util.AddNetworkString( "successWeaponPurchase" )
util.AddNetworkString( "successSpecWeaponPurchase" )
util.AddNetworkString( "failedPurchase" )

util.AddNetworkString( "buyPlayerAmmo" )

util.AddNetworkString( "buyPlayerHealthArmor" )

util.AddNetworkString( "requestNewLoadout" )
util.AddNetworkString( "successNewLoadout" )

util.AddNetworkString( "requestLoadoutUpdate" )
util.AddNetworkString( "sendLoadoutUpdate" )

-- Send a failed purchase message
function FailedPurchase(ply, reason)
    local _reason = reason or "Failed to purchase."

    net.Start("failedPurchase")
    net.WriteString(_reason)
    net.Send(ply)
end

net.Receive( "requestNewLoadout", function( len, ply )
    local cost = 5
    local spawnProtected = playerSpawnProtected[ply] or 0

    if spawnProtected > 0 then cost = 0 end

    if playerLoadout[ply] == nil then return end
    if playerCredit[ply] == nil or playerCredit[ply] < cost then
        FailedPurchase(ply, "You don't have enough tags to purchase a new loadout.")
        return
    end

    ChangeCredit(ply, -cost)

    for k, v in pairs(playerLoadout[ply]) do
        --ply:StripAmmo(ply:GetWeapon(v):GetPrimaryAmmoType())
        ply:StripWeapon(v)
    end

    playerLoadout[ply] = {}

    if ply:Team() == 2 then
        ply:Give("weapon_cs16_knife_fix")
    end

    net.Start("successNewLoadout")
    net.Send(ply)
end)

-- Send back the size of the loadout (between 0 and 3)
-- This is used to make sure that the player has a full loadout.
-- If not, they still have to buy more weapons.
net.Receive( "requestLoadoutUpdate", function( len, ply )
    local loadout = playerLoadout[ply] or false
    local loadout_size = 0
    local shouldMenuBeClosed = net.ReadBool()
    local spawnProtected = playerSpawnProtected[ply] or 0

    if loadout != false then loadout_size = #loadout end

    net.Start("sendLoadoutUpdate")
    net.WriteUInt(loadout_size, 8)
    net.WriteBool(shouldMenuBeClosed)
    net.WriteBool(spawnProtected > 0)
    net.Send(ply)
end)

-- Player requests to buy a weapon
net.Receive( "buyPlayerWeapon", function( len, ply )
    local classname = net.ReadString()
    local correct = false
    local specialTable = false

    -- Check what kind of weapon we're dealing with
    if table.HasValue(teamCSWeapons, classname) and ply:Team() == TEAM_CS then correct = true
    elseif table.HasValue(teamHLWeapons, classname) and ply:Team() == TEAM_HL then correct = true
    elseif CSspecialWeapons[classname] != nil and ply:Team() == TEAM_CS then specialTable = CSspecialWeapons
    elseif HLspecialWeapons[classname] != nil and ply:Team() == TEAM_HL then specialTable = HLspecialWeapons
    else return end
    
    if correct != false then
        -- Normal weapon
        -- Make sure the player doesn't already have the weapon
        if !ply:HasWeapon(classname) then
            ply:Give(classname)
            GiveAmmo(ply, classname)

            if playerLoadout[ply] == nil then
                playerLoadout[ply] = {}
            end

            table.insert(playerLoadout[ply], classname)

            -- Let the client now that the purchase was successful
            net.Start("successWeaponPurchase")
            net.WriteString(classname)
            net.Send(ply)
        else
            FailedPurchase(ply, "You already have this weapon.")
        end
    elseif specialTable != false then
        -- Special weapon
        local credits = playerCredit[ply] or 0
        local required = specialTable[classname][1]

        -- Check if player has enough credits
        if credits >= required then
            local spawnAmount = specialTable[classname][3]
            for i=1,spawnAmount do
                -- Create weapon entity to get more ammo
                local weapon = ents.Create(classname)
                weapon:SetPos(ply:GetPos())
                weapon:Spawn()

                net.Start("successSpecWeaponPurchase")
                net.WriteString(classname)
                net.Send(ply)
            end
            ChangeCredit(ply, -required)
        else
            FailedPurchase(ply, "You don't have enough tags to purchase this Special Weapon.")
        end
    else
        print("WARNING player " .. ply:GetName() .. " tried asking for " .. classname .. " which is illegal.")
    end
end)

-- Ammo purchase
net.Receive( "buyPlayerAmmo", function( len, ply )
    local credits = playerCredit[ply] or 0
    local required = 2

    if credits >= required then
        GiveAmmo(ply)
        ChangeCredit(ply, -required)
    else
        FailedPurchase(ply, "You don't have enough tags to purchase ammunition.")
    end
end)

-- buy either health or armor. If net bool is true, it's health, if false it's armor
net.Receive( "buyPlayerHealthArmor", function( len, ply )
    local credits = playerCredit[ply] or 0
    local required = 2

    local buyHealth = net.ReadBool()

    if credits >= required then
        if buyHealth then
            -- Health purchase
            local currentHealth = ply:Health()
            local increment = 50

            ply:SetHealth(currentHealth + increment)
            ply:EmitSound("items/smallmedkit1.wav")
        else
            -- Armor purchase
            local currentArmor = ply:Armor()
            local increment = 50

            ply:SetArmor(currentArmor + increment)

            if ply:Team() == TEAM_CS then 
                ply:EmitSound("items/ammopickup2.wav")
            elseif ply:Team() == TEAM_HL then
                ply:EmitSound("items/gunpickup2.wav")
            end
        end
    else
        FailedPurchase(ply, "You don't have enough tags to purchase health/armor.")
    end
        
end)

function GiveAmmo(ply, classname, count)
    local team = ply:Team()
    local specialTable = {}
    local gaveAlready = {}

    -- We dont want to give ammo to special weapons!
    if team == TEAM_CS then specialTable = CSspecialWeapons
    elseif team == TEAM_HL then specialTable = HLspecialWeapons end

    local giveAmmoFor = {}
    if classname != nil then
        -- We have a given classname, only give ammo for that specific weapon.
        giveAmmoFor = {classname}
    else
        -- Otherwise give ammo for every weapon in loadout
        local loadout = playerLoadout[ply] or {}
        giveAmmoFor = table.Copy(loadout)

        -- Add special weapons which allow ammo purchase
        for specWepClass, _ in pairs(specialTable) do
            if ply:GetWeapon(specWepClass):IsValid() and specialTable[specWepClass][2] then
                table.insert(giveAmmoFor, specWepClass)
            end
        end
    end

    -- cycle through loadout
    for _, wepClass in pairs(giveAmmoFor) do
        --print(wepClass)
        local wep = ply:GetWeapon(wepClass)
        if wep == nil then continue end
        
        local ammoType = wep.Primary.Ammo -- GetPrimaryAmmoType() returns an int for some reason????

        -- Skip if we already gave ammo for this ammo type
        if gaveAlready[ammoType] then continue end

        -- Needless to say
        if ammoType == "NONE" then continue end

        print("Buying for: " .. wepClass)
        print("Ammotype: " .. ammoType)

        if ammoAmount[ammoType] != nil then
            -- There is a specified amount that this ammo can get
            ply:GiveAmmo(ammoAmount[ammoType], ammoType, true)
        else
            ply:GiveAmmo(90, ammoType, true)
        end

        gaveAlready[ammoType] = true
    end

    ply:EmitSound("items/9mmclip1.wav")
end

-- Find a weapon with the given classname in the player's inv
--[[
function FindPlayerWep(ply, classname)
    if !ply:IsValid() then return false end

    for _, wep in pairs(ply:GetWeapons()) do
        if wep:GetClass() == classname then return wep end
    end

    return false
end
]]--