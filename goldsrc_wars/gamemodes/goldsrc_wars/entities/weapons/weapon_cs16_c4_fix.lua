if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/c4_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_c4_fix", "cs/sprites/c4_killicon", Color( 255, 255, 255, 255 ) )
killicon.Add( "ent_cs16_planted_c4", "cs/sprites/c4_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_c4.lua")