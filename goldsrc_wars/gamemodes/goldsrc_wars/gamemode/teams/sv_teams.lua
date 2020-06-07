AddCSLuaFile( "sh_teams.lua" )
AddCSLuaFile( "cl_teams.lua" )

include("sh_teams.lua")

function SetPlayerSpeed(ply, runspeed, walkspeed, slowwalkspeed)
    ply:SetRunSpeed(runspeed)
    ply:SetWalkSpeed(walkspeed)
    ply:SetSlowWalkSpeed(slowwalkspeed)
end

function GM:Move(ply, mv)
    ply:SetRunSpeed(100)
    ply:SetSlowWalkSpeed(100)
end

function TEAM_Spectator( ply )
    --ply:Kill()
    ply:SetTeam(TEAM_SPECTATOR)
    GAMEMODE:PlayerSpawnAsSpectator( ply )
    ply:SetMoveType(MOVETYPE_NOCLIP)
end
concommand.Add("TEAM_Spectator", TEAM_Spectator)

-- You can make a simple function using arguements to make this less messier but this would be the simplest way to explain what it does.	
function Team_1( ply ) -- Creating the function.
    ply:Kill()
    ply:UnSpectate() -- As soon as the person joins the team, he get's Un-spectated
    ply:SetTeam( TEAM_HL ) -- We'll set him to team 1

    ply:ConCommand("hl1_cl_rollangle 0")

    playerLoadout[ply] = {}

    ply:StripWeapons()
    ply:StripAmmo()

    ply:Spawn()

    ply:SetWalkSpeed(250)

    local hl1models = {
        "models/player/hl1/barney.mdl",
        "models/player/hl1/gman.mdl",
        "models/player/hl1/hassassin.mdl",
        "models/player/hl1/hassault.mdl",
        "models/player/hl1/helmet.mdl",
        "models/player/hl1/hgrunt.mdl",
        "models/player/hl1/hgrunt_black.mdl",
        "models/player/hl1/hgrunt_cigar.mdl",
        "models/player/hl1/hgrunt_commander.mdl",
        "models/player/hl1/hgrunt_shotgun.mdl",
        "models/player/hl1/hgrunt_shotgun_black.mdl",
        "models/player/hl1/holo.mdl",
        "models/player/hl1/player.mdl",
        "models/player/hl1/rgrunt.mdl",
        "models/player/hl1/scientist_einstien.mdl",
        "models/player/hl1/scientist_luther.mdl",
        "models/player/hl1/scientist_slick.mdl",
        "models/player/hl1/scientist_walter.mdl",
        "models/player/hl1/skeleton.mdl",
        "models/player/hl1/zombie.mdl"
    }

    ply:SetModel(table.Random(hl1models))
    
    --timer.Create("setspeed", 0.5, 1, function() SetPlayerSpeed(ply, 100, 250, 100) end)

    RunConsoleCommand ("gsrchud_theme", "Half-Life")
end -- End the function
concommand.Add("TEAM_1", Team_1) -- Adding a concommand (Console Command) for the team.
    
    
function Team_2( ply )
    ply:Kill()
    ply:UnSpectate()
    ply:SetTeam( TEAM_CS )

    playerLoadout[ply] = {}

    ply:StripWeapons()
    ply:StripAmmo()

    ply:Spawn()

    playerLoadout[ply] = {}

    local csmodels = { 
        "models/cs/playermodels/arctic.mdl", 
        "models/cs/playermodels/gign.mdl", 
        "models/cs/playermodels/gsg9.mdl", 
        "models/cs/playermodels/guerilla.mdl", 
        "models/cs/playermodels/leet.mdl", 
        "models/cs/playermodels/sas.mdl", 
        "models/cs/playermodels/terror.mdl", 
        "models/cs/playermodels/urban.mdl"}

    ply:SetModel(table.Random(csmodels))

    ply:SetArmor( 100 )
    
    --timer.Create("setspeed", 0.5, 1, function() SetPlayerSpeed(ply, 100, 250, 100) end)

    RunConsoleCommand ("gsrchud_theme", "Counter-Strike")
end
concommand.Add("TEAM_2", Team_2)
    
function Team_3( ply )
    ply:UnSpectate()
    ply:SetTeam( 3 )
    ply:Spawn()
end
concommand.Add("TEAM_3", Team_3)
    
function Team_4( ply )
    ply:UnSpectate()
    ply:SetTeam( 4 )
    ply:Spawn()
end
concommand.Add("TEAM_4", Team_4)