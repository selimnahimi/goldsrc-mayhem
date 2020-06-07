local protection_time_left = 0

net.Receive( "sendSpawnProtection", function(len, ply)
	protection_time_left = net.ReadUInt(8)

	timer.Create("SpawnProtection", 1, 0, function()
		protection_time_left = protection_time_left - 1

		if protection_time_left <= 0 then
			timer.Stop("SpawnProtection")
			timer.Remove("SpawnProtection")

			-- Reopen buymenu if still open ON THE NEW LOADOUT PAGE to update the temporarily free loadout change
			if BuyMenu != nil and BuyMenu_OnTheNewLoadoutPage then
				BuyMenu_OpenAppropriate( )
			end
		end
	end)
end)

hook.Add("HUDPaint", "HUDPaint_SpawnProtection", function()
	if protection_time_left > 0 then
		surface.SetDrawColor( 0, 0, 0, 128 )
		draw.DrawText("Spawn protection left: " .. protection_time_left, "CloseCaption_Bold", ScrW()/2, ScrH()/2-50, Color(255,255,255), TEXT_ALIGN_CENTER)
		draw.DrawText("Free loadout change available during Spawn Protection.", "TargetID", ScrW()/2, ScrH()/2, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
end )