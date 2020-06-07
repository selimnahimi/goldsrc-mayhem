if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/galil_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_galil_fix", "cs/sprites/galil_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_galil.lua")