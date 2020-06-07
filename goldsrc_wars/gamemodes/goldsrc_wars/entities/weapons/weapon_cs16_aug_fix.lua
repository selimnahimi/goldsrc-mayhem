if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/aug_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_aug_fix", "cs/sprites/aug_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_aug.lua")