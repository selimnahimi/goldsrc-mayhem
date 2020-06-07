if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/ump45_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_ump45_fix", "cs/sprites/ump45_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_ump45.lua")