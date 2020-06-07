if CLIENT then
SWEP.WepSelectIcon = surface.GetTextureID( "cs/sprites/hegrenade_selecticon" )
SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false
killicon.Add( "weapon_cs16_hegrenade_fix", "cs/sprites/hegrenade_killicon", Color( 255, 255, 255, 255 ) )
killicon.Add( "ent_cs16_hegrenade", "cs/sprites/hegrenade_killicon", Color( 255, 255, 255, 255 ) )
end

include("weapon_cs16_hegrenade.lua")