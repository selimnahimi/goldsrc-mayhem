local cvar_enable = CreateClientConVar("cl_gsrcbob_enable", 1, true, false)

local cvar_bob = CreateClientConVar("cl_gsrcbob_bob", 0.01, true, false)
local cvar_bobcycle = CreateClientConVar("cl_gsrcbob_bobcycle", 0.8, true, false)
local cvar_bobup = CreateClientConVar("cl_gsrcbob_bobup", 0.5, true, false)

local cvar_weaponbob = CreateClientConVar("cl_gsrcbob_weaponbob", 1, true, false)

local cvar_weaponoffset = CreateClientConVar("cl_gsrcbob_weaponoffset", 2, true, false)

local function CalcBob()
	local cl_bob = cvar_bob:GetFloat()
	local cl_bobcycle = cvar_bobcycle:GetFloat()
	local cl_bobup = cvar_bobup:GetFloat()
	
	if LocalPlayer():ShouldDrawLocalPlayer() then return 0 end

	local cltime = CurTime()
	local cycle = cltime - math.floor(cltime/cl_bobcycle)*cl_bobcycle
	cycle = cycle / cl_bobcycle
	if (cycle < cl_bobup) then
		cycle = math.pi * cycle / cl_bobup
	else
		cycle = math.pi + math.pi*(cycle-cl_bobup)/(1.0 - cl_bobup)
	end

	local velocity = LocalPlayer():GetVelocity()

	local bob = math.sqrt(velocity[1]*velocity[1] + velocity[2]*velocity[2]) * cl_bob
	bob = bob*0.3 + bob*0.7*math.sin(cycle)
	if (bob > 4) then
		bob = 4
	elseif (bob < -7) then
		bob = -7
	end
	
	return bob
end

function QuakeGunBobbing(wep, vm, oldPos, oldAng, pos, ang)
	if !string.StartWith(wep:GetClass(), "weapon_hl1") and !string.StartWith(wep:GetClass(), "weapon_cs16") then
		if !cvar_enable:GetBool() then
			return
		end
		
		local bob = CalcBob()

		local offset = cvar_weaponoffset:GetFloat()
		oldPos = oldPos + oldAng:Forward() * bob * .4 - offset * oldAng:Up() + Vector(0, 0, offset)

		return oldPos, oldAng
	end
end

hook.Add("CalcViewModelView", "QuakeGunBobbing", QuakeGunBobbing)