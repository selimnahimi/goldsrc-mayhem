if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/scout_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_scout_fix", "cs/sprites/scout_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_scout.lua")