-- Miscallenous commands

function GiveTags(ply)
    net.Start("requestGiveTags")
    net.SendToServer()
end
concommand.Add("gsrcwars_admin_give_tags", GiveTags)
