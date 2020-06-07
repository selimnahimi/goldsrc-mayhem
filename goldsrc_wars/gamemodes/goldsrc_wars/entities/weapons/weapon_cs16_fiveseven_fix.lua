if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/fiveseven_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_fiveseven_fix", "cs/sprites/fiveseven_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_fiveseven.lua")