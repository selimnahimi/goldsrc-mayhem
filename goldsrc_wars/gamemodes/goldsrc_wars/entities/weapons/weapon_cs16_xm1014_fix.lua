if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/xm1014_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_xm1014_fix", "cs/sprites/xm1014_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_xm1014.lua")