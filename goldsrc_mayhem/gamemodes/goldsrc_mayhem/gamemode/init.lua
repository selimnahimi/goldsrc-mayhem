AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include("shared.lua")

-- Networking
util.AddNetworkString("creditChanged")
util.AddNetworkString("bountyChanged")
util.AddNetworkString("playSoundOnClient")

gameevent.Listen( "player_connect" )

RunConsoleCommand("dsp_off","1")


-- This doesnt seem to work.
--[[
hook.Add( "Initialize", "InitializeSpawnpoints", function()
    
    for k, v in pairs( ents.FindByClass( "info_*") ) do
        print( v:GetClass() )
    end

    -- Spawnpoints???
    team.SetSpawnPoint(TEAM_HL, {"info_player_terrorist"})
    team.SetSpawnPoint(TEAM_CS, {"info_player_counterterrorist"})
    
    print(#team.GetSpawnPoints(TEAM_CS))
end)
]]--

function GM:PlayerSelectSpawn( ply )
    local classname

    if ply:Team() == TEAM_CS then classname = "info_player_terrorist"
    elseif ply:Team() == TEAM_HL then classname = "info_player_counterterrorist" end

    local spawns = ents.FindByClass( classname )
    if #spawns == 0 then
        spawns = ents.FindByClass( "info_player_start" )
    end

    local spawnPoint = nil
    local random_entry = 0
    local new_spawns = table.Copy(spawns)

    -- Make sure player can spawn without getting stuck
    repeat
        random_entry = math.random( #new_spawns )
        local pos = new_spawns[random_entry]:GetPos() -- Choose your position.

        local tr = {
            start = pos,
            endpos = pos,
            mins = Vector( -16, -16, 0 ),
            maxs = Vector( 16, 16, 71 ),
            filter = function(ent)
                if ent:IsPlayer() then
                    if ent:Team() == ply:Team() then return false end -- ignore same team
                end
                return true
            end
        }

        local hullTrace = util.TraceHull( tr )
        if ( !hullTrace.Hit ) then
            spawnPoint = new_spawns[random_entry]
            break
        end

        -- Remove from list so we don't make an infinite loop...
        table.remove(new_spawns,random_entry)

        if #new_spawns == 0 then
            break
        end

    until spawnPoint != nil

    if spawnPoint == nil then
        spawnPoint = spawns[math.random(#spawns)]
    end
        
    return spawnPoint
	
end

--[[hook.Add("player_connect", "AssignTeam", function(data)
    local ply = Entity(data.index)
    --ply:ConCommand("TEAM_1")
    Team_1(ply)
end)]]--

function GM:PlayerInitialSpawn( ply )
    --ply:ConCommand("TEAM_SPECTATOR")
    --ply:ConCommand("TeamMenu")
    ply:ConCommand("gsrchud_scale 2")
    Team_1(ply)

    playerBounty[ply] = 0
    playerCredit[ply] = 0
    playerLoadout[ply] = {}
    playerFirstSpawning[ply] = true
    playerKillStreak[ply] = 0
    playerMultiKill[ply] = 0
end

function GM:PlayerLoadout(ply)
    ply:SetArmor(100)
    if ply:Team() == TEAM_HL then
        ply:Give("weapon_hl1_crowbar")
    elseif ply:Team() == TEAM_CS then
        ply:Give("weapon_cs16_knife_fix")
        ply:Give("weapon_cs16_hegrenade_fix")
    end

    if playerLoadout[ply] != nil then
        for k, v in pairs(playerLoadout[ply]) do
            ply:Give(v)
        end
    end

    GiveAmmo(ply)
    SpawnProtection(ply)

    if playerFirstSpawning[ply] == nil then
        playerFirstSpawning[ply] = true
    end

    if playerFirstSpawning[ply] then
        net.Start("playSoundOnClient")
        net.WriteString("quake/standard/prepare.mp3")
        net.Send(ply)

        playerFirstSpawning[ply] = false
    end

    ply:EmitSound("items/gunpickup2.wav")

    ply:SetNoCollideWithTeammates(true)
end

-- Used to store a player's credits
playerCredit = {

}

-- Used to store a player's bounty
playerBounty = {

}

-- Used to store if the player is spawning for the first time or not
playerFirstSpawning = {

}

-- Player's loadout
playerLoadout = {

}

-- Sounds played on headshot
local headshotSounds = {
    "player/headshot1.wav",
    "player/headshot2.wav",
    "player/headshot3.wav"
}

-- Add/Remove credit to/from the player's balance
function ChangeCredit(ply, amount)
    if playerCredit[ply] == nil then
        playerCredit[ply] = 0
    end

    playerCredit[ply] = playerCredit[ply] + amount

    net.Start("creditChanged")
    net.WriteInt(playerCredit[ply], 16)
    net.WriteInt(amount, 6)
    net.Send(ply)
end

function ChangeBounty(ply, amount)
    if playerBounty[ply] == nil then
        playerBounty[ply] = 0
    end

    playerBounty[ply] = playerBounty[ply] + amount

    net.Start("bountyChanged")
    net.WriteInt(playerBounty[ply], 16)
    net.WriteInt(amount, 6)
    net.Send(ply)
end

-- Give players credit on kills
hook.Add("PlayerDeath", "Playerdeath", function(victim, weapon, killer)
    if victim == killer then return end

    local victimBounty = playerBounty[victim] or 0
    local credit = 1 + victimBounty

    killer:PrintMessage(HUD_PRINTTALK, "You got " .. credit .. " tag(s) for killing " .. victim:Name())

    ChangeCredit(killer, credit)
    ChangeBounty(killer, 1)

    playerBounty[victim] = 0
    ChangeBounty(victim, 0)

    
end)

-- Scale damage
function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
    dmginfo:ScaleDamage(2)

    if hitgroup == HITGROUP_HEAD then
        ply:EmitSound(headshotSounds[math.random(#headshotSounds)])
        dmginfo:ScaleDamage(3)
    end
end

-- Spawn protection and team damage
function GM:PlayerShouldTakeDamage(victim, inflictor)
    local spawnProtected = playerSpawnProtected[victim] or 0
    if spawnProtected > 0 then
        return false
    end

    if victim:Team() == inflictor:Team() and victim != inflictor then
        if GetConVarNumber( "mp_friendlyfire" ) == 0 then
            return false
        end
    end

    return true
end

function ReplaceEntities()
    print("Replacing hl2 entities...")

    for k, v in pairs( ents.GetAll() ) do
        local class = v:GetClass()
        local replace = class

        if (class == "item_healthkit") then
            replace = "hl1_item_healthkit"
        end
        
        
        --[[else if (class == "ammo_argrenades") then
            replace = "hl1_ammo_argrenades"
        else if (class == "ammo_9mmar") then
            replace = "hl1_ammo_9mmar"
        else if (class == "ammo_gaussclip") then
            replace = "hl1_ammo_gaussclip"
        else if (class == "ammo_rpgclip") then
            replace = "hl1_ammo_rpgclip"
        else if (class == "ammo_buckshot") then
            replace = "hl1_ammo_buckshot"
        else if (class == "weapon_shotgun") then
            replace = "weapon_hl1_shotgun"
        end --]]

        if (class != replace) then
            local new_ent = ents.Create(replace)
            new_ent:SetPos(v:GetPos())
            new_ent:Spawn()

            v:Remove()

        elseif string.StartWith(class, "weapon_") or string.StartWith(class, "ammo_") then
            v:Remove()
        end
    end
end

hook.Add( "InitPostEntity", "MapStartTrigger", ReplaceEntities )