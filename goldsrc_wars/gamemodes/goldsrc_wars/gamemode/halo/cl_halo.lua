-- Draw halo around players with high bounties


hook.Add( "PreDrawHalos", "AddPropHalos", function()
	--halo.Add( ents.FindByClass( "player" ), Color( 255, 0, 0 ), 5, 5, 2 )
	
	if LocalPlayer():Team() == TEAM_SPECTATOR then
		local team_1 = {}
		local team_2 = {}

		for _, ply in ipairs( player.GetAll() ) do
			if ply != nil and ply:Team() != TEAM_SPECTATOR then
				if ply:Team() == 1 then
					table.insert(team_1, ply)
				elseif ply:Team() == 2 then
					table.insert(team_2, ply)
				end
			end
		end

		for _, ply in pairs(team_1) do
			halo.Add( team_1, team.GetColor(1), 2, 2, 1, true, true)
		end

		for _, ply in pairs(team_2) do
			halo.Add( team_2, team.GetColor(2), 2, 2, 1, true, true)
		end
	end
end )
