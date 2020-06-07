if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/m3_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_m3_fix", "cs/sprites/m3_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_m3.lua")