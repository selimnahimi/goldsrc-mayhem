if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/knife_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_knife_fix", "cs/sprites/knife_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_knife.lua")