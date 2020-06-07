if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/tmp_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_tmp_fix", "cs/sprites/tmp_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_tmp.lua")