if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/m4a1_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_m4a1_fix", "cs/sprites/m4a1_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_m4a1.lua")