if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/g3sg1_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_g3sg1_fix", "cs/sprites/g3sg1_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_g3sg1.lua")