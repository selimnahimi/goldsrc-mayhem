include("sh_quake_announcer.lua")

local message_time = 3
local message_time_left = 0
local message_content = ""

local headshot_time = 3
local headshot_time_left = 0

net.Receive( "quakeAnnouncerMessage", function()
    local msgID = net.ReadUInt(8)
    local c_message_content = QUAKE_SOUNDS[msgID][2]
    
    if c_message_content == "HEADSHOT" then
        headshot_time_left = headshot_time
    else
        message_time_left = message_time
        message_content = c_message_content
    end
        
    
    -- Dont play the headshot sound right ontop of let's say, a double kill
    --if message_content != "HEADSHOT" or message_time_left >= message_time - 1 then
    
    -- Play sound
    surface.PlaySound(QUAKE_PATH .. QUAKE_SOUNDS[msgID][1])

    -- Timer
    timer.Create("QuakeAnnouncerMessage", 1, 0, function()
        if message_time_left > 0 then
            message_time_left = message_time_left - 1
        end

        if headshot_time_left > 0 then
            headshot_time_left = headshot_time_left - 1
        end

        if message_time_left <= 0 and headshot_time_left <= 0 then
            timer.Stop("QuakeAnnouncerMessage")
            timer.Remove("QuakeAnnouncerMessage")
        end
    end)
end)

hook.Add("HUDPaint", "HUDPaint_QuakeAnnouncer", function()
    if message_time_left > 0 then
        surface.SetDrawColor( 0, 0, 0, 128 )
		draw.DrawText(message_content, "TargetID", ScrW()/2, ScrH()/2-100, Color(255,255,255), TEXT_ALIGN_CENTER)
    end

    if headshot_time_left > 0 then
        surface.SetDrawColor( 0, 0, 0, 128 )
        draw.DrawText("HEADSHOT", "TargetID", ScrW()/2, ScrH()/2-150, Color(255,255,255), TEXT_ALIGN_CENTER)
    end
end)