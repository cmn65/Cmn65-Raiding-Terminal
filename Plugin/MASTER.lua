--// Source Code -- Version 0.1-1
--// Very choppy and sketchy UI. I will be adjusting the open-source modules to my needs sooner or later! :)
--// Thank you to @ROBLOX for the StudioWidget UI collection. Without them I would have to make a very crappy library of Gui objects. Link: https://github.com/Roblox/StudioWidgets

wait(0.1)
print([[
	
Cmn65's Raiding Terminal is loading...
>> Please report issues to cmn65 through PM on ROBLOX or through a tweet @roblox_cmn65 on Twitter!

>> To Use This Plugin:
1.) Right Click in studio
2.) Click on "Cmn65's Raiding Terminal Configuration" to open the configuration widget
3.) Edit the configuration fields to your needs
4.) Click the INJECT button and your terminal is good to go!

]])

local toolbar = plugin:CreateToolbar("Cmn65's Group Raid Terminal")

local modelName = "Cmn65's Raiding Terminal"

local StudioWidgets = script.StudioWidgets

local CollapsibleTitledSection = require(StudioWidgets.CollapsibleTitledSection)
local CustomTestButton = require(StudioWidgets.CustomTextButton)
local GuiUtilities = require(StudioWidgets.GuiUtilities)
local ImageButtonWithTest = require(StudioWidgets.ImageButtonWithText)
local LabeledCheckbox = require(StudioWidgets.LabeledCheckbox)
local LabeledMultiChoice = require(StudioWidgets.LabeledMultiChoice)
local LabeledRadioButton = require(StudioWidgets.LabeledRadioButton)
local LabeledSlider = require(StudioWidgets.LabeledSlider)
local LabeledTextInput = require(StudioWidgets.LabeledTextInput)
local RbxGui = require(StudioWidgets.RbxGui)
local StatefullImageButton = require(StudioWidgets.StatefulImageButton)
local VerticallyScalingListFrame = require(StudioWidgets.VerticallyScalingListFrame)

local configButton = toolbar:CreateButton(1, "Open Current Configuration", "rbxassetid://4902906761", "Open Current Configuration")

local teamColorChoices = {
	{Id = "Black", Text = "Black"},
	{Id = "Bright blue", Text = "Blue"},
	{Id = "Bright yellow", Text = "Yellow"},
	{Id = "Bright green", Text = "Green"},
	{Id = "White", Text = "White"},
}

local CONFIGURATION_SOURCE_CODE = "--// Cmn65's Raiding Terminal\n-->> Configuration File\n-->> Edit this file to your needs and then have fun raiding!!\n\n-- See Documentation/Install for more detailed information\n\n-->> This configuration file as generated by the plugin! Make sure the configuration file is correct! \n\n\n\nlocal configuration = {"
local definedConfiguration = {
	['groupId'] = 1;
	['groupTeamName'] = "Defenders";
	['groupTeamColor'] = BrickColor.Green();
	['raiderTeamColor'] = BrickColor.Red();
	['allyTeamColor'] = BrickColor.new("Bright yellow");
	['adminRank'] = 200;
	['autoTeam'] = true;
	['allowRandoms'] = true;
	['bannedPlayers'] = {"Hacker!!"};
	['totalTime'] = 1800;
	['raidingTime'] = 630;
	['raidersNeeded'] = 0;
	['groupMembersNeeded'] = 0;
	['terminalPart'] = nil;
	['printConfiguration'] = false;
	['auto_update'] = true;
	['update_to_minor_versions'] = false;
	['AutoFix'] = true;
	['config_version'] = 2;
	['developer'] = false;
}







local widgetInfo = DockWidgetPluginGuiInfo.new( Enum.InitialDockState.Left, true, true,  -- Don't override the previous enabled state
	300,    -- X Default width of the floating window
	300,    -- Y Default height of the floating window
	
	300,    -- X Minimum width of the floating window
	300     -- Y Minimum height of the floating window
)
 
-- Create new widget GUI
local testWidget = plugin:CreateDockWidgetPluginGui("Cmn65's Raiding Terminal Plugin", widgetInfo)
testWidget.Title = "Cmn65's Group Raiding Terminal Configuration"  -- Optional widget title
local basicConfig = CollapsibleTitledSection.new("suffix", "Basic Configuration", true, true, false)
local developerConfig = CollapsibleTitledSection.new("suffix", "Developer Configuration", true, false, true)

local basicsettingsFrame = VerticallyScalingListFrame.new("suffix")

local WidgetObjects = {
	setting_groupID = LabeledTextInput.new("suffix", "Your Group's ID", "1");
	setting_groupName = LabeledTextInput.new("suffix", "Group Team Name", "Defenders");
	setting_groupTeamColor = LabeledMultiChoice.new("suffix", "Your Group's Team Color", teamColorChoices, 1);
	setting_adminRank = LabeledTextInput.new("suffix", "Admin Rank", "1 - 255");
	setting_autoTeam = LabeledCheckbox.new("suffix", "Auto-Team Players", true, false);
	setting_allowRandoms = LabeledCheckbox.new("suffix", "Allow Random Players", true, false);
	setting_totalTime = LabeledTextInput.new("suffix", "Total Raid Time", "time, in seconds");
	setting_raidTime = LabeledTextInput.new("suffix", "Raiding Time", "time to capture in seconds");
	setting_raidersNeeded = LabeledTextInput.new("suffix", "Min. Raiders", "3");
	setting_defendersNeeded = LabeledTextInput.new("suffix", "Min. Defenders", "5");
	setting_terminalPart = LabeledTextInput.new("suffix", "Terminal Object", "game.Workspace.TERMINAL");
	setting_auto_update = LabeledCheckbox.new("suffix", "Auto-Update", true, false);
	setting_AutoFix = LabeledCheckbox.new("suffix", "Auto-Fix Script", true, false);
	InjectTerminalButton = CustomTestButton.new("generateTerminal", "Click to INJECT Terminal");
	RemoveTerminalButton = CustomTestButton.new("removeTerminal", "Click to REMOVE Terminal");
	UpdateTerminalButton = CustomTestButton.new("updateTerminal", "Click to UPDATE Terminal");
}


WidgetObjects.InjectTerminalButton:GetButton().Size = UDim2.new(0,250,0,25)
WidgetObjects.RemoveTerminalButton:GetButton().Size = UDim2.new(0,250,0,25)
WidgetObjects.UpdateTerminalButton:GetButton().Size = UDim2.new(0,250,0,25)
WidgetObjects.setting_groupID:SetMaxGraphemes(10)
WidgetObjects.setting_groupName:SetMaxGraphemes(30)
WidgetObjects.setting_adminRank:SetMaxGraphemes(3)
WidgetObjects.setting_totalTime:SetMaxGraphemes(5)
WidgetObjects.setting_raidTime:SetMaxGraphemes(5)
WidgetObjects.setting_raidersNeeded:SetMaxGraphemes(2)
WidgetObjects.setting_defendersNeeded:SetMaxGraphemes(2)
WidgetObjects.setting_terminalPart:SetMaxGraphemes(1000000)




basicsettingsFrame:AddChild(WidgetObjects.setting_groupID:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_groupName:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_groupTeamColor:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_adminRank:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_autoTeam:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_allowRandoms:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_totalTime:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_raidTime:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_raidersNeeded:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_defendersNeeded:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_terminalPart:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_auto_update:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.setting_AutoFix:GetFrame())
basicsettingsFrame:AddChild(WidgetObjects.InjectTerminalButton:GetButton())
basicsettingsFrame:AddChild(WidgetObjects.RemoveTerminalButton:GetButton())
basicsettingsFrame:AddChild(WidgetObjects.UpdateTerminalButton:GetButton())


basicsettingsFrame:AddBottomPadding()
basicsettingsFrame:GetFrame().Parent = testWidget



function BUILD_SOURCE_CODE()
	print(">>[SOURCE_CODE]: Building...")
	local bannedPlayersStr = "bannedPlayers = {"
	for key, value in pairs(definedConfiguration) do -- Format values for numbers and bools (easy)
		if string.find(key, "TeamColor") == nil and key ~= "bannedPlayers" then
			if string.find(key, "TeamName") ~= nil then CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	" .. key .. " = " .. "'".. tostring(value) .. "';" else -- Handle the string value
				CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	" .. key .. " = " .. tostring(value) .. ";"
			end
		end
	end
	for i = 1, #definedConfiguration.bannedPlayers do -- Handle the table value (banned players)
		if i == 1 then bannedPlayersStr = bannedPlayersStr .. "'" .. definedConfiguration.bannedPlayers[i] .. "'" else bannedPlayersStr = bannedPlayersStr .. ", '" .. definedConfiguration.bannedPlayers[i] .. "'" end
	end
	CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	--// Team Colors (By BrickColor)"
	for key, value in pairs(definedConfiguration) do -- Handle brick colors 
		if string.find(key, "TeamColor") and key ~= "groupTeamColor" then
			CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	" .. key .. " = " .. "BrickColor.new('" .. tostring(value) .. "');"
		elseif key == "groupTeamColor" then CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	" .. key .. " = " .. value .. ";"
		end
	end
	bannedPlayersStr = bannedPlayersStr .. "}"
	CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	--// Banned Players (By NAME or PLAYER ID)"
	CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n	" .. bannedPlayersStr .. ";"
	CONFIGURATION_SOURCE_CODE = CONFIGURATION_SOURCE_CODE .. "\n}\nreturn configuration"
	print(">>[SOURCE_CODE]: Done!")
end

function SET_VARS()
	definedConfiguration.groupId = WidgetObjects.setting_groupID:GetValue()
	definedConfiguration.groupTeamName = WidgetObjects.setting_groupName:GetValue()
	if WidgetObjects.setting_groupTeamColor:GetSelectedIndex() == 1 then
		definedConfiguration.groupTeamColor = "BrickColor.new('Black')"
	elseif WidgetObjects.setting_groupTeamColor:GetSelectedIndex() == 2 then
		definedConfiguration.groupTeamColor = "BrickColor.new('Blue')"
	elseif WidgetObjects.setting_groupTeamColor:GetSelectedIndex() == 3 then
		definedConfiguration.groupTeamColor = "BrickColor.new('Bright yellow')"
	elseif WidgetObjects.setting_groupTeamColor:GetSelectedIndex() == 4 then
		definedConfiguration.groupTeamColor = "BrickColor.new('Bright green')"
	elseif WidgetObjects.setting_groupTeamColor:GetSelectedIndex() == 5 then
		definedConfiguration.groupTeamColor = "BrickColor.new('White')"				
	end
	definedConfiguration.adminRank = WidgetObjects.setting_adminRank:GetValue()
	definedConfiguration.autoTeam = WidgetObjects.setting_autoTeam:GetValue()
	definedConfiguration.allowRandoms = WidgetObjects.setting_allowRandoms:GetValue()
	definedConfiguration.totalTime = tonumber(WidgetObjects.setting_totalTime:GetValue())
	definedConfiguration.raidingTime = tonumber(WidgetObjects.setting_raidTime:GetValue())
	definedConfiguration.raidersNeeded = tonumber(WidgetObjects.setting_raidersNeeded:GetValue())
	definedConfiguration.groupMembersNeeded = tonumber(WidgetObjects.setting_defendersNeeded:GetValue())
	definedConfiguration.terminalPart = WidgetObjects.setting_terminalPart:GetValue()
	definedConfiguration.auto_update = WidgetObjects.setting_auto_update:GetValue()
	definedConfiguration.autoTeam = WidgetObjects.setting_autoTeam:GetValue()
end

function INJECT_TERMINAL()
	print("Cmn65's Raiding Terminal is being injected into the game... Two steps (BUILD/INJECT) will occur. BUILD will check your configuration, INJECT will download and place the terminal and then write the configuration file. I will let you know when we are done! ")
	print(">> [BUILD]: Checking to make sure configuration values are of correct type...")
	--// Run through config and check for errors
	local prebuild = true
	local check1 = {WidgetObjects.setting_groupID, WidgetObjects.setting_adminRank, WidgetObjects.setting_totalTime, WidgetObjects.setting_raidTime, WidgetObjects.setting_raidersNeeded, WidgetObjects.setting_defendersNeeded} --#
	
	for i = 1, #check1 do
		if tonumber(check1[i]:GetValue()) == nil then
			check1[i]:SetValue("ERROR: Must be a NUMBER")
			prebuild = false
		else
			if tonumber(check1[i]:GetValue()) <= 0 then
				check1[i]:SetValue("ERROR: Must be greater than 0")
				prebuild = false
			end
		end
	end
	
	if prebuild == false then error("[BUILD]: Failed") else
		--// Backup old terminal (if there is one...)
		print(">>[BUILD]: Success... moving to injection (this is the real bug step)")
		print(">>[INJECT]: Checking for previously configured terminals...")
		if game.ServerScriptService:FindFirstChild(modelName) then
			print(">>[INJECT]: There is already an instance of Cmn65's Raiding Terminal! Disabling and moving into storage in game.ServerStorage.TerminalBackups.")
			if game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui") then game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui").Parent = game.ServerScriptService:FindFirstChild(modelName) end
			if game.ServerStorage:FindFirstChild("TerminalBackups") then
				game.ServerScriptService:FindFirstChild(modelName).Disabled = true
				game.ServerScriptService:FindFirstChild(modelName).Parent = game.ServerStorage.TerminalBackups
			else
				Instance.new("Folder", game.ServerStorage).Name = "TerminalBackups"
				game.ServerScriptService:FindFirstChild(modelName).Disabled = true
				game.ServerScriptService:FindFirstChild(modelName).Parent = game.ServerStorage.TerminalBackups
			end
		end
		
		--// Insert new updated Terminal
		print(">>[INJECT]: Downloading latest version of the terminal...")
		local newModel = game:GetService("InsertService"):LoadAsset(4879413218)
		print(">>[INJECT]: Checking for correct contents...")
		if newModel:FindFirstChild(modelName) == nil or newModel:FindFirstChild("Cmn65's Raiding Terminal Gui") == nil then error("[INJECT]: Failed - Could not find expected contents. This is usually due to a mis-match in naming. PM Cmn65 to get this resolved!") end
		local terminal = newModel:FindFirstChild(modelName)
		local gui = newModel:FindFirstChild("Cmn65's Raiding Terminal Gui")
		print(">>[INJECT]: Moving things into position!")
		gui.Parent = game.StarterGui
		terminal.Parent = game.ServerScriptService
		print(">>[INJECT]: Attempting to write to contents of terminal.Configuration. This is where the fun begins...")
		terminal.Configuration:Destroy()
		local configModule = Instance.new("ModuleScript", terminal)
		configModule.Name = "Configuration"
		SET_VARS()
		BUILD_SOURCE_CODE()
		configModule.Source = CONFIGURATION_SOURCE_CODE
		CONFIGURATION_SOURCE_CODE = "--// Cmn65's Raiding Terminal\n-->> Configuration File\n-->> Edit this file to your needs and then have fun raiding!!\n\n-- See Documentation/Install for more detailed information\n\n-->> This configuration file as generated by the plugin! Make sure the configuration file is correct! \n\n\n\nlocal configuration = {"
		print(">>[INJECT]: Configuration module generated and placed into the terminal script.")
		print(">>[INJECT]: You are READY! Please make sure you proof read your configuration script to make sure it is correct! Press the Open Configuration button in the plugins menu to see your current configuration!")
		print(">>Cleaning up...")
		newModel:Destroy()
		warn("Cmn65's Raiding Terminal is ready for use! Thank you very much for using, and please PM me with any bugs concerning this plugin or the model itself! Or tweet @roblox_cmn65!")
	end
end
WidgetObjects.InjectTerminalButton:GetButton().MouseButton1Click:connect(INJECT_TERMINAL)

function removeTerminal()
	print("[REMOVE]: Removing terminal...")
	if game.ServerScriptService:FindFirstChild(modelName) then
		game.ServerScriptService:FindFirstChild(modelName):Destroy()
	end
	if game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui") then
		game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui"):Destroy()
	end
	print("[REMOVE]: Terminal removed.")
end
WidgetObjects.RemoveTerminalButton:GetButton().MouseButton1Click:connect(removeTerminal)

function updateTerminal()
	print("[UPDATE]: Updating raid terminal...")
	local newModel = game:GetService("InsertService"):LoadAsset(4879413218)
	local oldModel = game.ServerScriptService:FindFirstChild(modelName)
	if oldModel ~= nil then
		if oldModel:FindFirstChild("Configuration") ~= nil then
			--// Get model version information
			local newBuildInfo, newConfigurationModule = require(newModel[modelName].buildInfo), require(newModel[modelName].Configuration)
			local oldBuildInfo, oldConfigurationModule = require(oldModel.buildInfo), require(oldModel.Configuration)
			local newTerminal = newModel[modelName]
			local newGui = newModel["Cmn65's Raiding Terminal Gui"]
			local oldConfig = oldModel.Configuration:clone()
			local newVersionAvailable = false
						
			print("[UPDATE]: Checking version information...")
			if newBuildInfo.version > oldBuildInfo.version then newVersionAvailable = true print(">>	Updating from MAJOR version " .. oldBuildInfo.version .. "-" .. oldBuildInfo.build .. " --> " .. newBuildInfo.version .. "-" .. newBuildInfo.build) end -- new major
			if newBuildInfo.version == oldBuildInfo.version and newBuildInfo.build > oldBuildInfo.build then newVersionAvailable = true print(">>	Updating from MINOR version " .. oldBuildInfo.version .. "-" .. oldBuildInfo.build .. " --> " .. newBuildInfo.version .. "-" .. newBuildInfo.build) end -- new minor
			
			if newVersionAvailable == true then
				if newConfigurationModule.config_version ~= oldConfigurationModule.config_version then
					print("[UPDATE]: Configuration version mismatch. Terminal update will continue but please edit the new configuration file when you are done, new features have been added!")
					wait(1.3)
					oldConfig.Name = "Configuration.version".. tostring(oldConfigurationModule.config_version) ..".old"
					oldConfig.Parent = newTerminal
				else
					print("[UPDATE]: Copying old configuration file to new terminal...")
					newTerminal['Configuration']:Destroy()
					oldConfig.Parent = newTerminal
				end
				wait(0.02)
				print("[UPDATE]: Backing up old terminal...")
				if game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui") then game.StarterGui:FindFirstChild("Cmn65's Raiding Terminal Gui").Parent = game.ServerScriptService:FindFirstChild(modelName) end
				
				if game.ServerStorage:FindFirstChild("TerminalBackups") then
					oldModel.Disabled = true
					oldModel.Parent = game.ServerStorage.TerminalBackups
				else
					Instance.new("Folder", game.ServerStorage).Name = "TerminalBackups"
					oldModel.Disabled = true
					oldModel.Parent = game.ServerStorage.TerminalBackups
				end
				wait(0.1)
				print("[UPDATE]: Moving new terminal into place...")
				newTerminal.Parent = game.ServerScriptService
				newGui.Parent = game.StarterGui
				wait()
				print("[UPDATE]: Validating update...")
				local errors = ""
				if oldModel.Parent ~= game.ServerStorage.TerminalBackups then errors = errors .. "\nBackup failed. Old terminal is missing from the TerminalBackups folder." end
				if newTerminal.Parent ~= game.ServerScriptService then errors = errors .. "\nThe new terminal wasn't in the correct service." end
				if newGui.Parent ~= game.StarterGui then errors = errors .. "\nThe new Gui wasn't in the correct service." end
				if errors ~= "" then print("[UPDATE]: The following problems have occured during the update. The script has attempted to fix them however they may not be fixed. Please double check!" .. errors) end
				wait(0.05)
				print("[UPDATE]: Cleaning up...")
				newModel:Destroy()
				if errors == "" then warn("[UPDATE]: Complete with no errors") else warn("[UPDATE]: Complete with some errors. Please verify update/installation!") end
				errors = ""
			else
				newModel:Destroy()
				warn("[UPDATE]: Error: No available updates.")
			end
		end
	else
		if oldModel == nil then
			warn("[UPDATE]: ERROR: You do not havea terminal to update. Please inject a new terminal.")	
		elseif oldModel:FindFirstChild("Configuration") == nil then
			warn("[UPDATE]: ERROR: No configuration file found. Please inject a new terminal.")
		else
			warn("[UPDATE]: ERROR: An unknown error occured. Please try this again, if the problem persists please follow this link and file a bug report: https://www.roblox.com/messages/compose?recipientId=16568982")
		end
	end
	
end
WidgetObjects.UpdateTerminalButton:GetButton().MouseButton1Click:connect(updateTerminal)
