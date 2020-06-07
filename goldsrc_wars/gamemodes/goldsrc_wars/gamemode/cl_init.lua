include("shared.lua")

localPlayerCredits = 0
localPlayerBounty = 0

local drawCreditColor = Color(255,255,255,255)
local drawBountyColor = Color(255,255,255,255)

-- Display player's credits
hook.Add("HUDPaint", "HUDPaint_DrawABox", function()
	surface.SetDrawColor( 0, 0, 0, 128 )
    --surface.DrawRect( 50, ScrH() - 200, 200, 50 )
    draw.DrawText("Tags: " .. localPlayerCredits, "CloseCaption_Bold", 25, ScrH() - 150, drawCreditColor, TEXT_ALIGN_LEFT)
    draw.DrawText("Bounty: " .. localPlayerBounty, "CloseCaption_Bold", 25, ScrH() - 110, drawBountyColor, TEXT_ALIGN_LEFT)
end )

-- Play a sound on the client
net.Receive( "playSoundOnClient", function()
    local soundFile = net.ReadString()

    surface.PlaySound(soundFile)
    print("playing " .. soundFile)
end)

-- Player spent credit, update HUD accordingly.
net.Receive( "creditChanged", function()
    local total = net.ReadInt(16)
    local change = net.ReadInt(6)

    localPlayerCredits = total

    if change < 0 then
        drawCreditColor = Color(255,0,0,255)
    elseif change > 0 then
        drawCreditColor = Color(0,255,0,255)
    end

    timer.Create("updateCreditColor", 1, 1, function()
        drawCreditColor = Color(255,255,255,255)
    end)
end )

-- Player spent credit, update HUD accordingly.
net.Receive( "bountyChanged", function()
    local total = net.ReadInt(16)
    local change = net.ReadInt(6)

    localPlayerBounty = total

    if change < 0 then
        drawBountyColor = Color(0,255,0,255)
    elseif change > 0 then
        drawBountyColor = Color(255,0,0,255)
    end

    timer.Create("updateBountyColor", 1, 1, function()
        drawBountyColor = Color(255,255,255,255)
    end)
end )