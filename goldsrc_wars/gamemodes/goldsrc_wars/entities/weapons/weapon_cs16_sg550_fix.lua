if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/sg550_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_sg550_fix", "cs/sprites/sg550_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_sg550.lua")