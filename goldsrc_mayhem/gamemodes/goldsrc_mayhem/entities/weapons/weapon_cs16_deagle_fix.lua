if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/deagle_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_deagle_fix", "cs/sprites/deagle_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_deagle.lua")