AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Longjump module"
ENT.Author = "Govorunb"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Editable = false
ENT.Category = "Fun + Games"
ENT.Instruction = "Crouch and quickly jump to perform a longjump! I shouldn't be telling you this if you own HL1."
ENT.Contact = "Steam"

local PickupSound 	 	= Sound( "hl1/fvox/bell.wav" )
local HEVPickupSound 	= Sound( "item_longjump/powermove_on.wav" )
local LongJumpDenySound = Sound( "player/suit_denydevice.wav")
local LongJumpSounds = {"pow_big_jump.wav"}
if SERVER then
util.AddNetworkString("LongJump")
util.AddNetworkString("LJPickup")
resource.AddFile("sound/item_longjump/jumpmod_boost1.wav")
resource.AddFile("sound/item_longjump/jumpmod_boost2.wav")
resource.AddFile("sound/item_longjump/jumpmod_long1.wav")
resource.AddFile("sound/item_longjump/powermove_on.wav")

net.Receive("LongJump", function( len, ply ) 
	if ply:GetNWBool("LongJump") then 
		local Aim = ply:GetAimVector()
		local i = math.random(1,3)
			timer.Simple(0.05, function() 
			ply:EmitSound(LongJumpSounds[i])
			ply:SetVelocity(Vector(Aim.x*500,Aim.y*500, 150))
		end)
	end
end )
function ENT:Use( ent, caller )
		if ent:IsPlayer() then 
			if ent:GetNWBool("LongJump") == nil then ent:SetNWBool("LongJump", false) end
			self:EmitSound(PickupSound)
			self:Remove()
			if !ent:GetNWBool("LongJump") then
				timer.Simple(0.1, function() net.Start("LJPickup") net.Send(ent, "LJPickup") end)
			ent:SetNWBool( "LongJump", true)
			end
		end
	end
hook.Add("PlayerSpawn", "RemoveLongJump", function( ply ) 
	
		ply:SetNWBool( "LongJump", false )

	end )
	function ENT:Initialize()
		
		self:SetUseType(SIMPLE_USE)
		self:SetModel( "models/w_longjump.mdl" )
		self:PhysicsInit( SOLID_BBOX )
		self:SetMoveType( MOVETYPE_FLYGRAVITY )
		self:SetSolid( SOLID_BBOX )
		self:SetCollisionGroup(COLLISION_GROUP_PUSHAWAY)

		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
		self:Activate()

	end
	function ENT:PhysicsCollide( data, phys )
		ent = data.HitEntity
		if ent:IsPlayer() then 
			if ent:GetNWBool("LongJump") == nil then ent:SetNWBool("LongJump", false) end
			self:EmitSound(PickupSound)
			self:Remove()
			if !ent:GetNWBool("LongJump") then
				timer.Simple(0.1, function() net.Start("LJPickup") net.Send(ent, "LJPickup") end)
			ent:SetNWBool( "LongJump", true)
			end
		end
	end 

	function ENT:Touch( ent )
		if ent:IsPlayer() then 
			if ent:GetNWBool("LongJump") == nil then ent:SetNWBool("LongJump", false) end
			self:EmitSound(PickupSound)
			self:Remove()
			if !ent:GetNWBool("LongJump") then
				timer.Simple(0.1, function() net.Start("LJPickup") net.Send(ent, "LJPickup") end)
			ent:SetNWBool( "LongJump", true)
			end
		end
		
	end

end

if CLIENT then

net.Receive("LJPickup", function(len, ply)
	surface.PlaySound(HEVPickupSound)
end )
hook.Add("PlayerBindPress", "LongJump", function( ply, bind ) 
 		if string.find( bind, "+duck" ) then 
 			LongJumpReady = true
 			timer.Simple(0.6, function() LongJumpReady = false end )
 		elseif string.find( bind, "+jump" ) then
 			if LongJumpReady and ply:OnGround() and ply:GetNWBool("LongJump") then 
 				--NextLongJumpTime = NextLongJumpTime or 0
 					--if NextLongJumpTime < CurTime() then
 						net.Start("LongJump")
 						net.SendToServer() 
 						--NextLongJumpTime = CurTime() + 1.25
 					--else 
 					--	surface.PlaySound(LongJumpDenySound)
 					--end
 			end
 		end
	end)
	
	function ENT:Think()
	end
	function ENT:Draw()
		self:DrawModel("models/w_longjump.mdl")
	end

end

