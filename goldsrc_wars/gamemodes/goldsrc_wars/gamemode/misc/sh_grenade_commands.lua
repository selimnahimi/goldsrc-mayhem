if SERVER then

    local grenades = {
        "ent_cs16_hegrenade",
        "ent_cs16_flashbang",
        "ent_cs16_smokegrenade"
    }

    util.AddNetworkString("grenadeThrown")

    hook.Add( "OnEntityCreated", "GrenadeThrowCheck", function( ent )
        timer.Simple(.0, function()
            if ent:IsValid() and table.HasValue(grenades, ent:GetClass()) then
                local ply = ent:GetOwner()

                net.Start("grenadeThrown")
                net.Send(ply)
            end
        end)
    end )

    
elseif CLIENT then

    net.Receive( "grenadeThrown", function ()
        surface.PlaySound("radio/fireinhole.wav")
    end)

end