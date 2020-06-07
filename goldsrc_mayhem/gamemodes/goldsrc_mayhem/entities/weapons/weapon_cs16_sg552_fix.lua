if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/sg552_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_sg552_fix", "cs/sprites/sg552_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_sg552.lua")