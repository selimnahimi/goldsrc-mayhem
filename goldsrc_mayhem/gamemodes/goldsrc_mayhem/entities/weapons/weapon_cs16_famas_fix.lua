if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/famas_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_famas_fix", "cs/sprites/famas_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_famas.lua")