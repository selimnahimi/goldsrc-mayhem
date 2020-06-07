AddCSLuaFile()

----------Colors---------
local clrTable = {} //Color table
clrTable["Green"] = Color(20, 150, 20, 255)
clrTable["Blue"] = Color(25, 25, 170, 255)
clrTable["Gray"] = Color(100, 100, 100, 255)
-------------------------
 
TEAM_HL = 1
TEAM_CS = 2
TEAM_SPECTATOR = 10
 
team.SetUp( TEAM_HL, "Team HL", clrTable["Green"] ) 
team.SetUp( TEAM_CS, "Team CS", clrTable["Blue"] )
team.SetUp( TEAM_SPECTATOR, "Spectator", clrTable["Gray"] )
