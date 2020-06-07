if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/flashbang_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
end

include("weapon_cs16_flashbang.lua")