-- Miscallenous commands

util.AddNetworkString("requestGiveTags")

net.Receive( "requestGiveTags", function( len, ply )
    ChangeCredit(ply, 100)
end)