-- Cmn65's Raiding Terminal

-->> Configuration File
-->> Edit this file to your needs and then have fun raiding!! 

-- See Documentation/Install for more detailed information



local configuration = {
	
	--[[ GENERAL CONFIGURATION ]]--	
	groupId = 1; -- Your Group's ID. Obtained from the URL when on your group's page. 
	groupTeamName = "Group"; -- Your Group's Team Name for in-game. This is shown in the team Gui.
	groupTeamColor = BrickColor.Green(); -- Team Color for Your Group's Team
	raiderTeamColor = BrickColor.Red(); -- Team Color for Raiders
	allyTeamColor = BrickColor.new("Bright yellow"); -- Team Color for Allies
	
	adminRank = 200; -- # rank obtained from Group Admin page on roblox. This is their role number. Who ever has this has admin commands.
	
	autoTeam = true; -- Place players on team based on their groups
	allowRandoms = true; -- Allow random players (Neither enemies/allies/defenders)
	bannedPlayers = {"Capitalization matters", 100}; -- Player Names or Player IDs 

	totalTime = 5; -- Total raid time. (Your group must defend the terminal for this long to keep the raiders from winning)
	raidingTime = 10; -- Time it takes to capture the terminals for the raiders to win. 
	--// NOTICE: totalTime default is 1800 (30 minutes)
	--//		 raidingTime default is 630 (10.5 minutes)
	--//	>> Make sure the value is in SECONDS <<
	
	raidersNeeded = 0;
	groupMembersNeeded = 0;
	
	terminalPart = game.Workspace.TERMINAL; -- Name the Union Operation in the Worksapce as TERMINAL_PART or direct the script to the part yourself.

	printConfiguration = false; -- Print the configuration file along with allies/enemies in the output. Good for debugging or catching mis-configuration. 
	
	--[[ TERMINAL MAINTENANCE ]]--
	auto_update = true; -- Auto update terminals. (Will auto update when a semi-major update is released)
	update_to_minor_versions = false; -- Include minor versions. (These are usually very minor tweaks to the script)
	AutoFix = true; -- Allows script to fix itself instead of shutting down the raid when an error occurs.
	-->> NOTICE: Auto updates only happen as long as the configuration file is the same version! If a configuration file has been updated then the terminal will let you know in the output!
	
	
	
	
	--[[ DEVELOPER CONFIGURATION ]]--
	--[[ DO NOT EDIT ANYTHING!!! ]]--
	config_version = 2;
	developer = false;
}
return configuration
