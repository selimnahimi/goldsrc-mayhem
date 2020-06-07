if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/awp_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_awp_fix", "cs/sprites/awp_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_awp.lua")