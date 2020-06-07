include("sh_quake_announcer.lua")

util.AddNetworkString("quakeAnnouncerMessage")

-- Kills in one life
playerKillStreak = {

}

-- Double kill, triple kill, etc
playerMultiKill = {

}

hook.Add("PlayerDeath", "Quake_PlayerDeath", function(victim, weapon, killer)
    if victim == killer then return end

    if victim:LastHitGroup() == HITGROUP_HEAD then
        Quake_AnnounceToClient(killer, QUAKE_HEADSHOT)
    end

    playerKillStreak[victim] = 0
    playerMultiKill[victim] = 0

    local timerID = "ply_" .. killer:UserID()
    local timerID2 = timerID .. "_2"

    if playerMultiKill[killer] == nil then
        -- Set up multikill counter
        playerMultiKill[killer] = 0
    end

    if playerKillStreak[killer] == nil then
        playerKillStreak[killer] = 0
    end

    playerMultiKill[killer] = playerMultiKill[killer] + 1
    playerKillStreak[killer] = playerKillStreak[killer] + 1

    local msgID = nil
    local kStreak = playerKillStreak[killer]

    -- We check this here, because there are times when a killstreak happens,
    -- but gets missed if it's inside the timer (let's say the player does 6 kills at once)
    -- This way it keeps track in case a killstreak happened during a kill, and announce it later
    -- at the timer.
    if kStreak == 5 then
        msgID = QUAKE_KILLINGSPREE
        Quake_KillStreakBroadcast(killer, msgID)
    elseif kStreak == 10 then
        msgID = QUAKE_RAMPAGE
        Quake_KillStreakBroadcast(killer, msgID)
    elseif kStreak == 15 then
        msgID = QUAKE_DOMINATING
        Quake_KillStreakBroadcast(killer, msgID)
    elseif kStreak == 20 then
        msgID = QUAKE_UNSTOPPABLE
        Quake_KillStreakBroadcast(killer, msgID)
    elseif kStreak == 25 then
        msgID = QUAKE_GODLIKE
        Quake_KillStreakBroadcast(killer, msgID)
    end

    killer:PrintMessage(HUD_PRINTTALK, kStreak)

    -- Delay a little, because it could be multiple
    -- players at once, like an explosion
    timer.Create(timerID2, 0.1, 1, function()
        local broadcast = false

        -- We do multikill second so it overrides killstreaks.
        local multiKill = playerMultiKill[killer] or 1

        if multiKill == 2 then
            msgID = QUAKE_DOUBLEKILL
        elseif multiKill == 3 then
            msgID = QUAKE_TRIPLEKILL
        elseif multiKill == 4 then
            msgID = QUAKE_MULTIKILL
        elseif multiKill == 5 then
            msgID = QUAKE_MEGAKILL
        elseif multiKill == 6 then
            msgID = QUAKE_ULTRAKILL
        elseif multiKill == 7 then
            msgID = QUAKE_MONSTERKILL
        elseif multiKill == 8 then
            msgID = QUAKE_LUDICROUSKILL
        elseif multiKill > 8 then
            msgID = QUAKE_HOLYSHIT
        end

        if msgID != nil then 
            if broadcast then
                Quake_Broadcast(msgID)
            else
                Quake_AnnounceToClient(killer, msgID)
            end
        end
    end)
    
    timer.Create(timerID, 3, 1, function()
        playerMultiKill[killer] = 0
    end)
end)

function Quake_KillStreakBroadcast(ply, msgID)
    PrintMessage(HUD_PRINTTALK, ply:GetName() .. " is " .. QUAKE_SOUNDS[msgID][2] .. "!")
end

function Quake_Broadcast(soundIndex)
    net.Start("quakeAnnouncerMessage")
    net.WriteUInt(soundIndex, 8)
    net.Broadcast()
end

function Quake_AnnounceToClient(ply, soundIndex)
    net.Start("quakeAnnouncerMessage")
    net.WriteUInt(soundIndex, 8)
    net.Send(ply)
end