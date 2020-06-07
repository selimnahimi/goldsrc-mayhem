if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/usp_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_usp_fix", "cs/sprites/usp_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_usp.lua")