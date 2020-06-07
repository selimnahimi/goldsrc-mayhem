if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/p228_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_p228_fix", "cs/sprites/p228_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_p228.lua")