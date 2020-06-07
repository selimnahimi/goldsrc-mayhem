if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/mac10_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_mac10_fix", "cs/sprites/mac10_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_mac10.lua")