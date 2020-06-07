if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/mp5navy_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_mp5navy_fix", "cs/sprites/mp5navy_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_mp5navy.lua")