if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/glock_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_glock18_fix", "cs/sprites/glock_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_glock18.lua")