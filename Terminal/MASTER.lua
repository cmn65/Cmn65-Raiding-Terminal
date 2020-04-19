--// Cmn65's Raiding Terminal
--// See 'DOCUMENTATION' for detailed instructions and description of this model's use!
script["Open Me!!!"]:Destroy() wait(1)








-->> WARNING: Editing anything below this line could cause the script to break or perform inefficiently. Do so at your own risk! <<--







if script:FindFirstChild("autoupdate") then print("") else print("[TerminalHandler]: Setting up preliminary services, modules and then checking for an update... (You may see this twice if the terminal updates)") end

local insertService = game:GetService("InsertService")
local config = require(script.Configuration)
local buildManifest = require(script.buildInfo)
local _VERSION = tostring(buildManifest.version) .. "-" .. tostring(buildManifest.build)
local prefix = "[TerminalHandler|".. _VERSION .."]: "

if config.auto_update == true and script:FindFirstChild("autoupdate") then
	script.autoupdate:Destroy()
	warn(prefix.."Terminal update done.\n")
elseif config.auto_update == true and script:FindFirstChild("autoupdate") == nil then
	print(prefix.."Cmn65's Raiding Terminal is checking for updates.....")
	local updatedTerminal = insertService:LoadAsset(buildManifest.terminalAID):FindFirstChild("Cmn65's Raiding Terminal")
	local newConfig_Module = updatedTerminal:WaitForChild("Configuration")
	local oldConfig_Module = script.Configuration
	local newConfig = require(newConfig_Module)
	local newBuildInfo = require(updatedTerminal:WaitForChild("buildInfo"))
	
	if newBuildInfo.version > buildManifest.version then
		print(prefix.."Checking requirements for update from version " .. buildManifest.version .. " --> " .. newBuildInfo.version)
		if config.config_version == newConfig.config_version then
			updatedTerminal.Parent = game.ServerScriptService
			newConfig_Module:Destroy()
			oldConfig_Module.Parent = updatedTerminal
			updatedTerminal.Disabled = false
			Instance.new("Accessory", updatedTerminal).Name = "autoupdate"
			script:Destroy() error(prefix.."UPDATE IN PROGRESS....... HALTING CURRENT THREAD")
		else
			print(prefix.."ERROR: Configuration version mismatch. To update you must manually re-insert the terminal. This is usually due to the configuration file being updated with new features.")
			warn(prefix.."WARNING: Auto-Update failed to a configuration version mismatch. The terminal will continue to run as noraml however consider looking into upgrading to the new terminal manually!")
			updatedTerminal:Destroy()
		end
	else
		print(prefix.."Update Failed: No new major updates found.")
	end
	
	if newBuildInfo.build > buildManifest.build and config.update_to_minor_versions == true then
		print(prefix.."Checking requirements for update from build " .. buildManifest.build .. " --> " .. newBuildInfo.build .. ". This is a minor update with minor bug fixes. To turn this off then change update_to_minor_versions to false in the configuration file. ")
		if config.config_version == newConfig.config_version then
			updatedTerminal.Parent = game.ServerScriptService
			newConfig_Module:Destroy()
			oldConfig_Module.Parent = updatedTerminal
			updatedTerminal.Disabled = false
			Instance.new("Accessory", updatedTerminal).Name = "autoupdate"
			script:Destroy() error(prefix.."UPDATE IN PROGRESS....... HALTING CURRENT THREAD")
		else
			print(prefix.."ERROR: Configuration version mismatch. To update you must manually re-insert the terminal. This is usually due to the configuration file being updated with new features.")
			warn(prefix.."WARNING: Auto-Update failed to a configuration version mismatch. The terminal will continue to run as noraml however consider looking into upgrading to the new terminal manually!")
			updatedTerminal:Destroy()
		end
	elseif newBuildInfo.build <= buildManifest.build and config.update_to_minor_versions == true then
		print(prefix.."Update Failed: No new minor updates found.")
	end
elseif config.auto_update == false then
	print(prefix.."Terminal update bypassed. To update, turn auto_update in the configuration file to true.")
end




print(prefix..'Initializing... 1/3 services, modules and terminal folders')
--// Services and Modules
local teamService = game:GetService("Teams")
local playerService = game:GetService("Players")
local groupService = game:GetService("GroupService")
local replicatedStorage = game:GetService("ReplicatedStorage")

Instance.new("Folder", script).Name = "TerminalInfo"
local terminalfolder = script.TerminalInfo
Instance.new("NumberValue", terminalfolder).Name = "capturePoints"

print(prefix..'Initializing... 2/3 configuration & remote events')
--// Configuration
groupId = config.groupId
groupTeamName = config.groupTeamName
adminRank = config.adminRank
totalTime = config.totalTime
raidingTime = config.raidingTime
terminalPart = config.terminalPart
playersNeeded = config.playersNeeded
groupMembersNeeded = config.groupMembersNeeded
groupTeamColor = config.groupTeamColor
raiderTeamColor = config.raiderTeamColor
allyTeamColor = config.allyTeamColor
autoTeam = config.autoTeam
allowRandoms = config.allowRandoms
bannedPlayers = config.bannedPlayers
raidersNeeded = config.raidersNeeded
--// Terminal Configuration (Seriously, don't edit these. Your terminal will be very messed up!)
multiplier = 0.5 -- How many seconds it takes for the script to check the terminal. Keep this between 0.3 and 1. 
points = 0 -- 			   0
timer = 0 -- 			   0
homeScore = 0 --     	   0
allyScore = 0 -- 		   0
raiderScore = 0 -- 		   0
defendersInZone = 0 --     0
raidersInZone = 0 -- 	   0
errorCorrection = false -- false
kickNewPlayers = false --  false

--// Remote Events
Instance.new("Folder", replicatedStorage).Name = "Data Transfer Modules" 
local DTM = replicatedStorage:FindFirstChild("Data Transfer Modules")
Instance.new("RemoteEvent", DTM).Name = "endgame-DataTransferModule"
local endgameDataTransferModule = DTM['endgame-DataTransferModule']
Instance.new("RemoteEvent", DTM).Name = "progress-DataTransferModule"
local progressDataTransferModule = DTM['progress-DataTransferModule']
Instance.new("RemoteEvent", DTM).Name = "serverstats-DataTransferModule"
local serverstatsDataTransferModule = DTM['serverstats-DataTransferModule']
Instance.new("RemoteEvent", DTM).Name = "playerstats-DataTransferModule"
local playerstatsDataTransferModule = DTM['playerstats-DataTransferModule']


print(prefix..'Initializing..... 3/3 dictionaries & tables')
--// Dictionaries and Tables
Admins = {}
groupsAllies = {}
groupsEnemies = {}
playersOnTerminal = {}

Instance.new("Folder", script).Name = "Player Folders"
local playerFolders = script:FindFirstChild("Player Folders")


--// Teams
print(prefix..'Creating Teams...')
local homeTeam = Instance.new("Team", teamService)
homeTeam.Name = groupTeamName
homeTeam.TeamColor = groupTeamColor
homeTeam.AutoAssignable = false
local raiderTeam = Instance.new("Team", teamService)
raiderTeam.Name = "Raiders"
raiderTeam.TeamColor = raiderTeamColor
raiderTeam.AutoAssignable = false
local allyTeam = Instance.new("Team", teamService)
allyTeam.TeamColor = allyTeamColor
allyTeam.Name = "Allies"
allyTeam.AutoAssignable = false


print(prefix..'Setting up functions and getting group info...')
--// Pre-Check 
if groupId <=0 then
	warn(prefix.."The groupId in the configuration file is set to a number less than or equal to zero. Please change groupId in the configuration to your group's ID number.\nThe number can be found in the URL of your group's main page.")
end
--// Functions
function superImportantFunctionThatBreaksTheScriptIfItIsRemoved() end terminalPart.Touched:connect(superImportantFunctionThatBreaksTheScriptIfItIsRemoved)

function checkIfPlayerIsOnTerminal(playerObject)
	local touching = terminalPart:GetTouchingParts()
	for i=1,#touching do
		if touching[i] == playerObject.Character.HumanoidRootPart then
			return true
		end
	end
	return false
end

function tableHasValue (Table, Value)
    for index, value in ipairs(Table) do
        if value == Value then
            return true
        end
    end
    return false
end

function removeKeyFromTable(Table, Key)
	for i = 1, #Table do
		if Table[i] == Key then
			table.remove(Table, i)
			return true
		else
			return false
		end
	end
end

function packageEndgameData(winningTeam)
	local playerFolders = playerFolders:GetChildren()
	
	local allyPlayerDictionary = {}
	local raiderPlayerDictionary = {}
	local homePlayerDictionary = {}
	
	local homeScore = 1
	local allyScore = 2
	local raiderScore = 3

	for i = 1, #playerFolders do
		if game.Players:FindFirstChild(playerFolders[i].Name) then
			if playerFolders[i].Team.Value == 1 then -- 1, 2, 3 | defenders, allies, raiders
				homeScore = homeScore + playerFolders[i].Score.Value
				homePlayerDictionary[playerFolders[i].Name] = playerFolders[i].Score.Value
			elseif playerFolders[i].Team.Value == 2 then
				allyScore = allyScore + playerFolders[i].Score.Value
				allyPlayerDictionary[playerFolders[i].Name] = playerFolders[i].Score.Value
			elseif playerFolders[i].Team.Value == 3 then
				raiderScore = raiderScore + playerFolders[i].Score.Value
				raiderPlayerDictionary[playerFolders[i].Name] = playerFolders[i].Score.Value
			end
		end
	end
	endgameDataTransferModule:FireAllClients(homePlayerDictionary, raiderPlayerDictionary, allyPlayerDictionary, homeScore, raiderScore, allyScore, winningTeam)
end

function isEnemy(playerObject)
	for i = 1, #groupsEnemies do
		if playerObject:IsInGroup(groupsEnemies[i]) then
			return true
		end
	end
end

local Apages = groupService:GetAlliesAsync(groupId)
while true do
	for _,group in pairs(Apages:GetCurrentPage()) do
		table.insert(groupsAllies, group.Id)
	end
	if Apages.IsFinished then
		break
	end
	Apages:AdvanceToNextPageAsync()
end
local Epages = groupService:GetEnemiesAsync(groupId)
while true do
	for _,group in pairs(Epages:GetCurrentPage()) do
		table.insert(groupsEnemies, group.Id)
	end
	if Epages.IsFinished then
		break
	end
	Epages:AdvanceToNextPageAsync()
end


if config.printConfiguration == true then
	warn(string.rep('=', 50) .. "[ C O N F I G U R A T I O N ]" .. string.rep('=', 50)) warn(prefix.."Printing configuration...") for key, value in pairs(config) do warn('  >>>	Variable: ' .. key .. ' is set to ' .. tostring(value)) wait() end warn('Allies: ' .. tostring(table.concat(groupsAllies, ", ")) .. "\nEnemies: " .. tostring(table.concat(groupsEnemies, ", "))) warn(string.rep('=', 50) .. "[ C O N F I G U R A T I O N ]" .. string.rep('=', 50)) -- prints the config file all fancy to the output for easy mis-configuration error spotting.
	print() print(prefix.."The raiding terminal is set up. The above values have been used for configuring this terminal. If a value is wrong go into Roblox Studio and edit the configuration module. Please report any bugs to cmn65 on ROBLOX or on twitter @roblox_cmn65!")
end


print(prefix..'Setting up a function for new players and end-game ... almost done...')
--// New Player
function newPlayer(player)
	if kickNewPlayers == true then
		player:Kick("The raid has ended. The server is shutting down and all players have been disconnected.")
	end
	if tableHasValue(bannedPlayers, player.userId) or tableHasValue(bannedPlayers, player.Name) then
		player:Kick("You have been banned. If you think this is a problem then please contact the place owner to appeal the ban with your playerId and player username in a PM.\nDo not give out your password!")
	end
	
	local playerFile = Instance.new("Folder", script['Player Folders'])
	playerFile.Name = player.Name
	Instance.new("NumberValue", playerFile).Name = "Team" -- 1, 2, 3 | defenders, allies, raiders
	Instance.new("NumberValue", playerFile).Name = "Score" -- Seconds spent in the zone as detected by the script
	Instance.new("NumberValue", playerFile).Name = "Deaths"
	Instance.new("NumberValue", playerFile).Name = "Kills"
	
	if player:IsInGroup(groupId) then
		player.Team = homeTeam
		playerFile.Team.Value = 1
		if player:GetRankInGroup(groupId) >= adminRank then
			table.insert(Admins, player.UserId)
		end
	end
	for i = 1, #groupsAllies do
		if player:IsInGroup(groupsAllies[i]) then
			player.Team = allyTeam
			playerFile.Team.Value = 2
			break
		end
	end
	if isEnemy(player) or allowRandoms == true then
		player.Team = raiderTeam
		playerFile.Team.Value = 3
	end
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Died:Connect(function()
				playerFile.Deaths.Value = playerFile.Deaths.Value + 1
				if humanoid:FindFirstChild("creator") ~= nil then
					local killer = humanoid.creator.Value
					playerFolders:FindFirstChild(killer.Name).Kills.Value = playerFolders:FindFirstChild(killer.Name).Kills.Value + 1
					playerFolders:FindFirstChild(killer.Name).Score.Value = playerFolders:FindFirstChild(killer.Name).Score.Value + 5
				end
				if kickNewPlayers == true then
					player:Kick("The raid is over. Thank you for participating!")
				end
				player:LoadCharacter()
			end)
		end
	end)
	player.Changed:Connect(function(value)
		if player.Team == homeTeam then
			playerFile.Team.Value = 1
		elseif player.Team == allyTeam then
			playerFile.Team.Value = 2
		elseif player.Team == raiderTeam then
			playerFile.Team.Value = 3
		else
			print(prefix..player.Name.." has changed to an unregistered team. They will NOT be counted in the raid!")
			playerFile.Team.Value = 4
		end
	end)
	
end
game.Players.PlayerAdded:Connect(newPlayer)


function endGame()
	--[[
	Freeze players
	God players
	Display Gui showing who won
	wait 10 minutes then kick everyone to shutdown the server	
	--]]
	local players = game.Players:GetPlayers()
	for i = 1, #players do
		players[i].Character.HumanoidRootPart.Anchored = true
		players[i].Character.Humanoid.MaxHealth = math.huge
		players[i].Character.Humanoid.Health = math.huge
		Instance.new("ForceField", players[i].Character)
	end
	
end





print(prefix.."Terminal is ready to go! An official raid will start soon after the appropriate amount of players have joined for the respective teams.")
c1 = false
c2 = false
while c1 == false and c2 == false do
	if #raiderTeam:GetPlayers() >= raidersNeeded then
		c1 = true
	end
	if #homeTeam:GetPlayers() >= groupMembersNeeded then
		c2 = true
	end
	wait(1)
end
warn(prefix..'RAID IS GOING TO START IN 5 SECONDS!')
wait(5)
for i = 1, #playerService:GetPlayers() do
	playerService:GetPlayers()[i]:LoadCharacter()
	wait()
end






print(prefix..'Raid has started!')
while wait(multiplier) do 
	-- Script Auto-Fix
	if defendersInZone < 0 or raidersInZone < 0 or #playersOnTerminal ~= defendersInZone + raidersInZone then -- If impossible values for variables occur, then attempt to fix the problem. 
		if config.AutoFix == true then
			print(prefix.."An error has occured. Attempting to fix....")
			local origpos = terminalPart.Position
			terminalPart.Position = Vector3.new(10000,10000,10000)
			defendersInZone = 0
			raidersInZone = 0
			wait()
			terminalPart.Position = origpos
			local function touchReset() end terminalPart.Touched:Connect(touchReset)
			wait()
			errorCorrection = true
		else
			Instance.new("Message", game.Workspace).Text = "THERE HAS BEEN AN ERROR IN THE TERMINAL SCRIPT. THE SERVER CANNOT CONTINUE TO RUN AND MUST BE RESET!\nTo prevent this in the future consider turning on AutoFix in the configuration file to attempt to fix the script. "
		end
	end
	
	-- Check players team and assign them to defenders or attackers. 
	local players = game.Players:GetPlayers()
	for i = 1, #players do
		if playerFolders:FindFirstChild(players[i].Name) then
			local pFolder = playerFolders:FindFirstChild(players[i].Name)
			if checkIfPlayerIsOnTerminal(players[i]) == true and tableHasValue(playersOnTerminal, players[i]) == false and errorCorrection == false then
				if pFolder.Team.Value == 1 or pFolder.Team.Value == 2 then
					defendersInZone = defendersInZone + 1
				elseif pFolder.Team.Value == 3 then
					raidersInZone = raidersInZone + 1
				end
				table.insert(playersOnTerminal, players[i])
			elseif checkIfPlayerIsOnTerminal(players[i]) == false and tableHasValue(playersOnTerminal, players[i]) == true and errorCorrection == false then
				if pFolder.Team.Value == 1 or pFolder.Team.Value == 2 then
					defendersInZone = defendersInZone - 1
				elseif pFolder.Team.Value == 3 then
					raidersInZone = raidersInZone - 1
				end
				removeKeyFromTable(playersOnTerminal, players[i])
			elseif errorCorrection == true then
				errorCorrection = false
				for i = 1, #playersOnTerminal do table.remove(playersOnTerminal, i) end 
				print(prefix.."Correcting error on players...")
				local players = game.Players:GetPlayers()
				for i = 1, #players do
					if checkIfPlayerIsOnTerminal(players[i]) == true and tableHasValue(playersOnTerminal, players[i]) == false then
						table.insert(playersOnTerminal, players[i])
					end
				end
				for i = 1, #playersOnTerminal do
					if playerFolders:FindFirstChild(playersOnTerminal[i].Name) then
						local pFolder = playerFolders:FindFirstChild(playersOnTerminal[i].Name)
						if pFolder.Team.Value == 1 or pFolder.Team.Value == 2 then
							defendersInZone = defendersInZone + 1
						elseif pFolder.Team.Value == 3 then
							raidersInZone = raidersInZone + 1
						end
					end
				end
				print(prefix.."Terminal should be fixed!")
			end
		end
	end
	
	-- Handle Scores for players and Teams
	for i = 1, #playersOnTerminal do
		playerFolders:FindFirstChild(playersOnTerminal[i].Name).Score.Value = playerFolders:FindFirstChild(playersOnTerminal[i].Name).Score.Value + 10*multiplier
	end
	
	if defendersInZone > raidersInZone then
		if config.developer == true then print("DEFENDERS") end
		if points > 0 then
			points = points - multiplier
		end
		timer = timer + multiplier
	elseif raidersInZone > defendersInZone then
		points = points + multiplier
		if config.developer == true then print("RAIDERS") end
	elseif raidersInZone == defendersInZone then
		if config.developer == true then print("TIE") end
		timer = timer + multiplier
	end
	
	-- Data Transfer to Client
	for i = 1, #players do
		if playerFolders:FindFirstChild(players[i].Name) then
			local pFolder = playerFolders:FindFirstChild(players[i].Name)
			playerstatsDataTransferModule:FireClient(players[i], pFolder.Score.Value, pFolder.Kills.Value, pFolder.Deaths.Value) -- Score, Kills, Deaths
			if pFolder.Team.Value == 1 then
				homeScore = homeScore + pFolder.Score.Value
			elseif pFolder.Team.Value == 2 then
				allyScore = allyScore + pFolder.Score.Value
			elseif pFolder.Team.Value == 3 then
				raiderScore = raiderScore + pFolder.Score.Value
			end
		end
	end
	
	progressDataTransferModule:FireAllClients(points/raidingTime, raidingTime)
	serverstatsDataTransferModule:FireAllClients(totalTime - timer, #raiderTeam:GetPlayers(), #allyTeam:GetPlayers() + #homeTeam:GetPlayers(), points, homeScore, allyScore, raiderScore) -- time left, raiders numbers, defenders numbers, capture points
	
	-- Reset reported scores and check for a win
	homeScore = 0
	allyScore = 0
	raiderScore = 0
	
	if config.developer == true then
		print('number r in zone: ' .. raidersInZone)
		print('number d in zone: ' .. defendersInZone)
		for i = 1, #playersOnTerminal do print(playersOnTerminal[i].Name) end
		print('points ' .. points)
		print('timer ' .. timer)
	end
	
	if points >= raidingTime then
		print("Raiders win")
		endGame()
		packageEndgameData("Raiders") -- Package endgame data and send it out.
		break
	elseif timer == totalTime then
		print("Defenders win")
		endGame()
		packageEndgameData("Defenders") -- Package endgame data and send it out.
		break
	end

end

print(prefix.."The raid has ended. All players will be kicked in 10 minutes. All new players will be kicked automatically. Respawning will kick players as well.")
kickNewPlayers = true
wait(600)
for i = 1, playerService:GetPlayers() do
	playerService:GetPlayers()[i]:Kick("The raid has ended. The server is shutting down and all players have been disconnected.")
end
