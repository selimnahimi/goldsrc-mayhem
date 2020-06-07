--[[-----------------------
    Custom Footsteps
-----------------------]]--

-- Set up footsteps for each material type
local matFootstepSounds = {
	[MAT_CONCRETE] = {
		"player/gsrc/footsteps/concrete1.wav",
		"player/gsrc/footsteps/concrete2.wav",
		"player/gsrc/footsteps/concrete3.wav",
		"player/gsrc/footsteps/concrete4.wav"},
	[MAT_SNOW] = {
		"player/gsrc/footsteps/pl_snow1.wav",
		"player/gsrc/footsteps/pl_snow2.wav",
		"player/gsrc/footsteps/pl_snow3.wav",
		"player/gsrc/footsteps/pl_snow4.wav",
		"player/gsrc/footsteps/pl_snow5.wav",
		"player/gsrc/footsteps/pl_snow6.wav",
	},
	[MAT_DIRT] = {
		"player/gsrc/footsteps/dirt1.wav",
		"player/gsrc/footsteps/dirt2.wav",
		"player/gsrc/footsteps/dirt3.wav",
		"player/gsrc/footsteps/dirt4.wav",
    },
    [MAT_METAL] = {
        "player/gsrc/footsteps/metal1.wav",
        "player/gsrc/footsteps/metal2.wav",
        "player/gsrc/footsteps/metal3.wav",
        "player/gsrc/footsteps/metal4.wav",
    },
    [MAT_GRATE] = {
        "player/gsrc/footsteps/metalgrate1.wav",
        "player/gsrc/footsteps/metalgrate2.wav",
        "player/gsrc/footsteps/metalgrate3.wav",
        "player/gsrc/footsteps/metalgrate4.wav",
    },
    ["ladder"] = {
        "player/gsrc/footsteps/ladder1.wav",
        "player/gsrc/footsteps/ladder2.wav",
        "player/gsrc/footsteps/ladder3.wav",
        "player/gsrc/footsteps/ladder4.wav",
    }
}

-- Certain textures have concrete properties BUT WE DONT WANT THAT >:(
-- Seriously having concrete footsteps on the SNOW on CS_OFFICE???
local texFootstepType = {
	["CS_OFFICE/SPHINX_SNOW_1"] = MAT_SNOW
}

-- Play a random footstep sound at a player
local function PlayRandomFootstep(ply, list, volume, foot)
    local random = list[ math.random( #list ) ]
	ply:EmitSound( random, 75, 100, volume ) -- Play the footstep
end

-- Hook the gamemode's footstep function
function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf )
    -- Player is on a ladder, skip the tracing stuff
    if ply:GetMoveType() == MOVETYPE_LADDER then
        local list = matFootstepSounds["ladder"]
        PlayRandomFootstep(ply, list, volume)

        return true
    end

    -- Make a trace hull to check for the surface below the player
    local traceData = { 
        start = pos, 
        endpos = Vector(pos.x, pos.y, pos.z-500),
		mins = Vector(-16, -16, 0),
		maxs = Vector( 16, 16, 71),
		filter = function(ent)
			if ent == ply then return false end -- ignore self
			return true
		end
	}

	local tRes = util.TraceHull(traceData)
	local texture = tRes.HitTexture -- Hit texture
	local matType = tRes.MatType -- Hit material type

	-- Check if there's a sound assigned to a specific texture
	-- otherwise ignore
	matType = texFootstepType[texture] or matType

    -- Get the list of sounds and choose a random one out of it.
    -- If there's no list with the given mat type, return the list for MAT_CONCRETE
	local list = matFootstepSounds[matType] or matFootstepSounds[MAT_CONCRETE]
    PlayRandomFootstep(ply, list, volume, foot)

	return true -- Don't allow default footsteps, or other addon footsteps
end