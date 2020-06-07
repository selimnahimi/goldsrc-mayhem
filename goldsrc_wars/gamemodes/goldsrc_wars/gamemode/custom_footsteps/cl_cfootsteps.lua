--[[-----------------------
    Custom Footsteps
-----------------------]]--

-- On client simply disable footsteps altogether.
-- This is required, since otherwise the client keeps trying
-- to play the original sounds next to the custom ones.
function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf )
	return true -- Return true disables anything default
end