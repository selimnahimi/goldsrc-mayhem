if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/m249_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_m249_fix", "cs/sprites/m249_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_m249.lua")