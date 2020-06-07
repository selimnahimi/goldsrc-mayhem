if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/elite_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_elite_fix", "cs/sprites/elite_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_elite.lua")