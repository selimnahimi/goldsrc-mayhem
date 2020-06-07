local buttonwidth = 400
local buttonheight = 35
local button_x = 75
local button_y_start = 50
local button_space = 40
local font = "CloseCaption_Normal"

local buyamount = 0

-- Currently open (or not) buymenu
BuyMenu = nil

-- Is the player on the new loadout creation page?
-- This is needed to update the price from FREE to paid, once the spawn protection ends!
BuyMenu_OnTheNewLoadoutPage = false

function CSMenuPistols( )
    local gunlist = {
        [1] = { "9x19MM SIDEARM (GLOCK)", function() BuyWeapon("weapon_cs16_glock18_fix") end, "materials/entities/weapon_cs16_glock18.png" },
        [2] = { "KM .45 TACTICAL (USP)", function() BuyWeapon("weapon_cs16_usp_fix") end, "materials/entities/weapon_cs16_usp.png" },
        [3] = { "228 COMPACT", function() BuyWeapon("weapon_cs16_p228_fix") end, "materials/entities/weapon_cs16_p228.png"},
        [4] = { "NIGHT HAWK .50C", function() BuyWeapon("weapon_cs16_deagle_fix") end, "materials/entities/weapon_cs16_deagle.png" },
        [5] = { ".40 DUAL ELITES", function() BuyWeapon("weapon_cs16_elite_fix") end, "materials/entities/weapon_cs16_elite.png" },
        [6] = { "ES FIVE-SEVEN", function() BuyWeapon("weapon_cs16_fiveseven_fix") end, "materials/entities/weapon_cs16_fiveseven.png" }
    }
    BuildBuyMenu( "SELECT SIDEARM", "", gunlist )
end

function CSMenuShotguns( )
    local gunlist = {
        [1] = { "LEONE 12 GAUGE SUPER", function() BuyWeapon("weapon_cs16_m3_fix") end, "materials/entities/weapon_cs16_m3.png" }
    }
    BuildBuyMenu( "SELECT SHOTGUN", "", gunlist )
end

function CSMenuSMGs( )
    local gunlist = {
        [1] = { "INGRAM MAC-10", function() BuyWeapon("weapon_cs16_mac10_fix") end, "materials/entities/weapon_cs16_mac10.png" },
        [2] = { "SCHMIDT MACHINE PISTOL (TMP)", function() BuyWeapon("weapon_cs16_tmp_fix") end, "materials/entities/weapon_cs16_tmp.png" },
        [3] = { "KM SUB-MACHINE GUN (MP5)", function() BuyWeapon("weapon_cs16_mp5navy_fix") end, "materials/entities/weapon_cs16_mp5navy.png" },
        [4] = { "KM UMP45", function() BuyWeapon("weapon_cs16_ump45_fix") end, "materials/entities/weapon_cs16_ump45.png" },
        [5] = { "ES C90 (P90)", function() BuyWeapon("weapon_cs16_p90_fix") end, "materials/entities/weapon_cs16_p90.png" }
    }
    BuildBuyMenu( "SELECT SMG", "", gunlist )
end

function CSMenuARs( )
    local gunlist = {
        [1] = { "IDE DEFENDER", function() BuyWeapon("weapon_cs16_galil_fix") end, "materials/entities/weapon_cs16_galil.png" },
        [2] = { "CLARION 5.56 (FAMAS)", function() BuyWeapon("weapon_cs16_famas_fix") end, "materials/entities/weapon_cs16_famas.png" },
        [3] = { "CV-47", function() BuyWeapon("weapon_cs16_ak47_fix") end, "materials/entities/weapon_cs16_ak47.png" },
        [4] = { "MAVERICK M4A1 CARBINE", function() BuyWeapon("weapon_cs16_m4a1_fix") end, "materials/entities/weapon_cs16_m4a1.png" },
        [5] = { "SCHMIDT SCOUT", function() BuyWeapon("weapon_cs16_scout_fix") end, "materials/entities/weapon_cs16_scout.png" },
        [6] = { "KRIEG 552", function() BuyWeapon("weapon_cs16_sg552_fix") end, "materials/entities/weapon_cs16_sg552.png" },
        [7] = { "BULLPUP (AUG)", function() BuyWeapon("weapon_cs16_aug_fix") end, "materials/entities/weapon_cs16_aug.png" },
        [8] = { "MAGNUM SNIPER RIFLE", function() BuyWeapon("weapon_cs16_awp_fix") end, "materials/entities/weapon_cs16_awp.png" },
        [9] = { "D3/AU-1", function() BuyWeapon("weapon_cs16_g3sg1_fix") end, "materials/entities/weapon_cs16_g3sg1.png" },
        [10] = { "KRIEG 550 COMMANDO", function() BuyWeapon("weapon_cs16_sg550_fix") end, "materials/entities/weapon_cs16_sg550.png" }
    }
    BuildBuyMenu( "SELECT RIFLE", "", gunlist )
end

function CSMenuMGs( )
    local gunlist = {
        [1] = { "M249", function() BuyWeapon("weapon_cs16_m249_fix") end, "materials/entities/weapon_cs16_m249.png" }
    }
    BuildBuyMenu( "SELECT MACHINE GUN", "", gunlist )
end

function CSMenuSpecials( )
    local gunlist = {
        [1] = { "LEONE YG1265 AUTO SHOTGUN (5 tags)", function() BuyWeapon("weapon_cs16_xm1014_fix") end, "materials/entities/weapon_cs16_xm1014.png" },
        [2] = { "Tripmine (5 tags)", function() BuyWeapon("weapon_hl1_tripmine") end, "entities/weapon_hl1_tripmine.png"},
        [3] = { "Satchel Charge (5 tags)", function() BuyWeapon("weapon_hl1_satchel") end, "entities/weapon_hl1_satchel.png"},
        [4] = { "RPG (10 tags)", function() BuyWeapon("weapon_hl1_rpg") end, "entities/weapon_hl1_rpg.png" },
        [5] = { "Displacer Cannon (15 tags)", function() BuyWeapon("weapon_hlof_displacer") end, "models/hlof/w_displacer.mdl"},
        [6] = { "Tau/Gauss Cannon (15 tags)", function() BuyWeapon("weapon_hl1_gauss") end, "entities/weapon_hl1_gauss.png"},
        [7] = { "Long Jump Module (20 tags)", function() BuyWeapon("item_longjump") end, "models/w_longjump.mdl"},
        [8] = { "Gluon Gun (25 tags)", function() BuyWeapon("weapon_hl1_egon") end, "entities/weapon_hl1_egon.png"}
    }
    BuildBuyMenu( "SELECT SPECIAL WEAPON", "", gunlist )
end

function HLMenuSpecials( )
    local gunlist = {
        [1] = { "Tau/Gauss Cannon (5 tags)", function() BuyWeapon("weapon_hl1_gauss") end, "entities/weapon_hl1_gauss.png"},
        [2] = { "MP5 Grenades (10 tags)", function() BuyWeapon("hl1_ammo_argrenades") end, "entities/hl1_ammo_argrenades.png"},
        [3] = { "RPG (10 tags)", function() BuyWeapon("weapon_hl1_rpg") end, "entities/weapon_hl1_rpg.png" },
        [4] = { "Displacer Cannon (15 tags)", function() BuyWeapon("weapon_hlof_displacer") end, "models/hlof/w_displacer.mdl"},
        [5] = { "Long Jump Module (15 tags)", function() BuyWeapon("item_longjump") end, "models/w_longjump.mdl"},
        [6] = { "Gluon Gun (25 tags)", function() BuyWeapon("weapon_hl1_egon") end, "entities/weapon_hl1_egon.png"}
    }
    BuildBuyMenu( "SELECT SPECIAL WEAPON", "", gunlist )
end

function HLMenuAll( )
    local gunlist = {
        [1] = { "9mm Pistol", function() BuyWeapon("weapon_hl1_glock") end, "entities/weapon_hl1_glock.png"},
        [2] = { ".357 Magnum", function() BuyWeapon("weapon_hl1_357") end, "entities/weapon_hl1_357.png"},
        [3] = { "MP5", function() BuyWeapon("weapon_hl1_mp5") end, "entities/weapon_hl1_mp5.png"},
        [4] = { "Shotgun", function() BuyWeapon("weapon_hl1_shotgun") end, "entities/weapon_hl1_shotgun.png"},
        [5] = { "Crossbow", function() BuyWeapon("weapon_hl1_crossbow") end, "entities/weapon_hl1_crossbow.png"},
        [6] = { "Tripmine (x2)", function() BuyWeapon("weapon_hl1_tripmine") end, "entities/weapon_hl1_tripmine.png"},
        [7] = { "Handgrenade (x2)", function() BuyWeapon("weapon_hl1_handgrenade") end, "entities/weapon_hl1_crossbow.png"}
    }
    BuildBuyMenu( "SELECT WEAPON", "Please select " .. (3 - buyamount) .. " more weapons.", gunlist )
end

function BuyAmmo()
    net.Start( "buyPlayerAmmo" )
    net.SendToServer()
end

function BuyHealth()
    net.Start( "buyPlayerHealthArmor" )
    net.WriteBool(true)
    net.SendToServer()
end

function BuyArmor()
    net.Start( "buyPlayerHealthArmor" )
    net.WriteBool(false)
    net.SendToServer()
end

local CScategories = {
    [1] = { "Pistols", CSMenuPistols },
    [2] = { "Shotguns", CSMenuShotguns},
    [3] = { "Sub-Machine Guns", CSMenuSMGs},
    [4] = { "Rifles", CSMenuARs},
    [5] = { "Machine Guns", CSMenuMGs}
}

local HLcategories = {
    [1] = { "Guns", HLMenuGuns },
    [2] = { "Utility", HLMenuUtility}
}

-- Request a weapon purchase from the server
function BuyWeapon(classname)
    net.Start( "buyPlayerWeapon" )
    net.WriteString(classname)
    net.SendToServer()
end

-- Switch to a specific weapon
function SwitchWeapon(classname)
    local wep = LocalPlayer():GetWeapon(classname)
    
    if wep:IsValid() then input.SelectWeapon( wep ) end
end

net.Receive( "successWeaponPurchase", function(len, ply)
    buyamount = buyamount + 1

    local classname = net.ReadString()

    -- Switch to the weapon
    timer.Simple(.05, function()
        SwitchWeapon(classname)
    end)

    BuyMenu_OpenAppropriate(true)
end)

net.Receive( "successSpecWeaponPurchase", function(len, ply)
    local classname = net.ReadString()

    -- Switch to the weapon
    timer.Simple(.05, function()
        SwitchWeapon(classname)
    end)
end)

net.Receive( "failedPurchase", function(len, ply)
    local reason = net.ReadString()
    LocalPlayer():PrintMessage(HUD_PRINTTALK, reason)

    surface.PlaySound("events/enemy_died.wav")

    BuyMenu_OpenAppropriate(true)
end)

net.Receive( "sendLoadoutUpdate", function( len, ply )
    local loadout_size = net.ReadUInt(8)
    local shouldMenuBeClosed = net.ReadBool()
    local isSpawnProtected = net.ReadBool()
    local team = LocalPlayer():Team()
    buyamount = loadout_size

    if BuyMenu != nil then
        BuyMenu:Close()
        BuyMenu = nil
    end

    if buyamount < 3 then
        if team == TEAM_CS then
            CSBuyMenu( )
        elseif team == TEAM_HL then
            HLBuyMenu( )
        end
    elseif !shouldMenuBeClosed then
        if team == TEAM_CS then
            CSBuyMenuAlreadyLoadout( isSpawnProtected )
        elseif team == TEAM_HL then
            HLBuyMenuAlreadyLoadout( isSpawnProtected )
        end
    end
end)

-- Open appropriate menu - depending if the player has a complete loadout or not
-- set to true if you want the menu to be closed in case the player has a loadout.
function BuyMenu_OpenAppropriate( shouldMenuBeClosed )
    net.Start( "requestLoadoutUpdate" )
    net.WriteBool(shouldMenuBeClosed)
    net.SendToServer()
end

-- Open the buy menu
function CSBuyMenu(  )
    BuildBuyMenu( "SELECT BY CATEGORY", "Please select " .. (3 - buyamount) .. " more weapons.", CScategories )
end

function HLBuyMenu(  )
    --BuildBuyMenu( "SELECT BY CATEGORY", "Please select " .. (3 - buyamount) .. " more weapons.", HLcategories )
    HLMenuAll( )
end

-- Get a new loadout
function NewLoadout( )
    net.Start("requestNewLoadout")
    net.SendToServer()
end

-- Server accepted the new loadout request
net.Receive( "successNewLoadout", function( len, ply )
    buyamount = 0
    BuyMenu_OpenAppropriate( false )
end)

-- The player already has a loadout.
function CSBuyMenuAlreadyLoadout( isSpawnProtected )
    BuyMenu_OnTheNewLoadoutPage = true
    local options = {
        [1] = {"NEW LOADOUT (5 tags)", NewLoadout },
        [2] = {""},
        [3] = {"Ammunition (2 tags)", BuyAmmo, "entities/hl1_ammo_9mmbox.png" },
        [4] = {"+50 Health (2 tags)", BuyHealth, "entities/hl1_item_healthkit.png"},
        [5] = {"+50 Armor (2 tags)", BuyArmor, "entities/hl1_item_battery.png"},
        [6] = {""},
        [7] = {"Tag Shop", CSMenuSpecials }
    }
    if isSpawnProtected then
        options[1] = {"NEW LOADOUT (FREE)", NewLoadout }
    end
    BuildBuyMenu( "", "You already have a loadout.", options )
end

function HLBuyMenuAlreadyLoadout( isSpawnProtected )
    BuyMenu_OnTheNewLoadoutPage = true
    local options = {
        [1] = {"NEW LOADOUT (5 tags)", NewLoadout },
        [2] = {""},
        [3] = {"Ammunition (2 tags)", BuyAmmo, "entities/hl1_ammo_9mmbox.png" },
        [4] = {"+50 Health (2 tags)", BuyHealth, "entities/hl1_item_healthkit.png"},
        [5] = {"+50 Armor (2 tags)", BuyArmor, "entities/hl1_item_battery.png"},
        [6] = {""},
        [7] = {"Tag Shop", HLMenuSpecials }
    }
    if isSpawnProtected then
        options[1] = {"NEW LOADOUT (FREE)", NewLoadout }
    end
    BuildBuyMenu( "", "You already have a loadout.", options )
end

-- BuyMenu command
function OpenBuyMenu()
    BuyMenu_OpenAppropriate(false)
end

concommand.Add("BuyMenu", OpenBuyMenu)

-- This function builds a build menu with a given button list.
function BuildBuyMenu( label, description, button_list )
    if BuyMenu != nil then
        BuyMenu:Close()
        BuyMenu = nil
    end

    local current_spacing = 0

    BuyMenu = vgui.Create( "DFrame" )
    BuyMenu:SetPos( 200, 200 )
    BuyMenu:SetSize( ScrW() - 400, ScrH() - 400 )
    BuyMenu:SetTitle( "Gun Menu" )
    BuyMenu:ShowCloseButton( false )
    BuyMenu:SetVisible( true )
    BuyMenu:SetDraggable( false )
    BuyMenu:MakePopup( )
    function BuyMenu:Paint()
        draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Color( 0,0,0,200 ) )
    end
    function BuyMenu:OnKeyCodePressed(keycode)
        if keycode == KEY_B or keycode == KEY_ESCAPE then
            BuyMenu:Close()
            BuyMenu = nil
        end
    end

    local label_category = vgui.Create( "DLabel", BuyMenu )    
    label_category:SetPos(button_x, button_y_start + current_spacing )
    label_category:SetSize( buttonwidth*2, buttonheight )
    label_category:SetText( label )
    label_category:SetTextColor( Color(255, 204, 51 ))
    label_category:SetContentAlignment( 4 )
    label_category:SetTextInset(40,0)
    label_category:SetFont(font)

    current_spacing = current_spacing + button_space

    local label_description = vgui.Create( "DLabel", BuyMenu )    
    label_description:SetPos(button_x, button_y_start + current_spacing )
    label_description:SetSize( buttonwidth*2, buttonheight )
    label_description:SetText( description )
    label_description:SetTextColor( Color(255, 204, 51 ))
    label_description:SetContentAlignment( 4 )
    label_description:SetTextInset(0,0)
    label_description:SetFont(font)

    current_spacing = current_spacing + button_space

    -- Set up the buttons
    for k, v in ipairs(button_list) do
        -- If empty, just leave a space
        if v[1] != "" then
            local button = vgui.Create( "DButton", BuyMenu )
            button:SetPos( button_x, button_y_start + current_spacing )
            button:SetSize( buttonwidth, buttonheight )
            button:SetText( v[1] )
            button:SetTextColor( Color( 255, 204, 51 ))
            button:SetContentAlignment( 4 )
            button:SetTextInset( 30, 0 )
            button:SetFont(font)

            -- Spawnicon / Image
            local model_image = v[3] or false
            local model = false
            local component = "DImage"

            if model_image != false then
                -- If it's a model, make a spawnicon instead
                if string.EndsWith(model_image, ".mdl") then
                    model = true
                    component = "SpawnIcon"
                end

                local SpawnI = vgui.Create( component , BuyMenu ) -- SpawnIcon or DImage
                SpawnI:SetSize( 300, 300 )
                SpawnI:SetPos( button:GetWide() + button_x + 100, 100 )
                SpawnI:SetMouseInputEnabled(false)
                SpawnI:SetVisible(false)
                
                if model then
                    SpawnI:SetModel( model_image ) -- Image we want for the spawn icon
                else
                    SpawnI:SetImage( model_image ) -- Model we want for the image
                end

                button.OnCursorEntered = function() SpawnI:SetVisible(true) end
                button.OnCursorExited = function() SpawnI:SetVisible(false) end
            end

            --[[ Current item's description under the image
            local item_description = v[4] or false

            if item_description != false then
                local label_description = vgui.Create( "DLabel", BuyMenu )    
                label_description:SetPos(button_x, button_y_start + current_spacing )
                label_description:SetSize( buttonwidth*2, buttonheight )
                label_description:SetText( description )
                label_description:SetTextColor( Color(255, 204, 51 ))
                label_description:SetContentAlignment( 4 )
                label_description:SetTextInset(0,0)
                label_description:SetFont(font)
            end
            ]]--

            button.Paint = function()
                if button:IsHovered() then
                    surface.SetDrawColor( 205, 154, 1, 150 )
                else
                    surface.SetDrawColor( 0, 0, 0, 150 ) 
                end
                surface.DrawRect( 0, 0, button:GetWide(), button:GetTall() )
                surface.SetDrawColor( 255, 204, 51, 25 )
                surface.DrawOutlinedRect(0, 0, button:GetWide(), button:GetTall())
            end

            button.DoClick = function()
                BuyMenu_OnTheNewLoadoutPage = false
                --BuyMenu:Close()
                --BuyMenu = nil
                v[2]()
            end
        end

        current_spacing = current_spacing + button_space
    end
    
    local close_button = vgui.Create( "DButton", BuyMenu )
    close_button:SetPos( button_x, BuyMenu:GetTall()-100 )
    close_button:SetSize( buttonwidth, buttonheight )
    close_button:SetText( "Cancel" )
    close_button:SetTextColor( Color(255, 204, 51 ))
    close_button:SetContentAlignment( 4 )
    close_button:SetTextInset(30,0)
    close_button:SetFont(font)
        
    close_button.Paint = function()
        if close_button:IsHovered() then
            surface.SetDrawColor( 205, 154, 1, 150 )
        else
            surface.SetDrawColor( 0, 0, 0, 150 ) 
        end

        surface.DrawRect( 0, 0, close_button:GetWide(), close_button:GetTall() )
        surface.SetDrawColor( 255, 204, 51, 25 )
        surface.DrawOutlinedRect(0, 0, close_button:GetWide(), close_button:GetTall())
    end
        
    close_button.DoClick = function()
        BuyMenu:Close()
        BuyMenu = nil
    end
end