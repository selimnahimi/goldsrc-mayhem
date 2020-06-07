if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/p90_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_p90_fix", "cs/sprites/p90_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_p90.lua")