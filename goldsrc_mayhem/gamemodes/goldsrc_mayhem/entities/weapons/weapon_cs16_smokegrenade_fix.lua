if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/smokegrenade_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
end

include("weapon_cs16_smokegrenade.lua")