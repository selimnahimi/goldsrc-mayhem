util.AddNetworkString( "sendSpawnProtection" )

local protection_time = 5
local protection_distance = 50

local playerInitialPos = {}
playerSpawnProtected = {}

function SpawnProtection(ply)
    playerSpawnProtected[ply] = protection_time

    playerInitialPos[ply] = ply:GetPos()
    playerInitialPos[ply].z = 0

    --ply:SetMaterial( "models/debug/debugwhite" )
    ply:SetColor( team.GetColor(ply:Team()) )

    net.Start("sendSpawnProtection")
    net.WriteUInt(protection_time, 8)
    net.Send(ply)
end

-- Check if all players are still at their spawn, or if they moved
timer.Create("SvSpawnProtection", 1, 0, function()
    for _, ply in pairs(player.GetAll()) do
        local spawnprotected = playerSpawnProtected[ply] or 0
        
        if spawnprotected > 0 then
            local initialPos = playerInitialPos[ply] or ply:GetPos()
            local currentPos = ply:GetPos()
            initialPos.z = 0
            currentPos.z = 0

            if !PlayerWithinBounds(initialPos, currentPos, protection_distance) then
                net.Start("sendSpawnProtection")
                net.WriteUInt(0, 8)
                net.Send(ply)

                playerSpawnProtected[ply] = 0

                ply:SetColor( Color(255,255,255) )
            end

            playerSpawnProtected[ply] = playerSpawnProtected[ply] - 1

            if playerSpawnProtected[ply] <= 0 then
                playerSpawnProtected[ply] = 0

                ply:SetColor( Color(255,255,255) )
            end
        end
    end
end)

function PlayerWithinBounds(pos1,pos2, dist)
	return pos1:DistToSqr(pos2) < (dist*dist)
end