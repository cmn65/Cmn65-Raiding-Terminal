--// Cmn65's Raiding Terminal Gui
--// Client Version: 1.0-2
--// This module handlesincoming traffic from the server. Designed to work with filtering enabled games so any change here on the client will not replicate to the server -- eliminating 99% of hacks!

local DTM = game.ReplicatedStorage:WaitForChild("Data Transfer Modules")
local endgameDataTransferModule = DTM['endgame-DataTransferModule']
local playerstatsDataTransferModule = DTM['playerstats-DataTransferModule']
local serverstatsDataTransferModule = DTM['serverstats-DataTransferModule']
local progressDataTransferModule = DTM['progress-DataTransferModule']

local RaidFrame = script.Parent.RaidInfoFrame
local InfoFrame = script.Parent.RaidInfoFrame.InformationFrame
local serverstatsframe = InfoFrame.ServerStatsFrame
local teamstatsframe = InfoFrame.TeamStatsFrame
local playerstatsframe = InfoFrame.PlayerStatsFrame

local raidOver = false

script.Parent.FirstFrame.Visible = false
script.Parent.SecondFrame.Visible = false
script.Parent.BackFrame.Visible = false

local captureTime = 0


function endgameGui(homePlayerDictionary, raiderPlayerDictionary, allyPlayerDictionary, homeScore, raiderScore, allyScore, winner)	
	
	local home_uiGridLayout = script.Parent.SecondFrame.HomeTeamFrame.ScrollingFrame.UIListLayout
	local raider_uiGridLayout = script.Parent.SecondFrame.RaiderTeamFrame.ScrollingFrame.UIListLayout
	local ally_uiGridLayout = script.Parent.SecondFrame.AllyTeamFrame.ScrollingFrame.UIListLayout
	 
	local homeTeamScores = homePlayerDictionary
	local raiderTeamScores = raiderPlayerDictionary
	local allyTeamScores = allyPlayerDictionary
	
	local firstFrame = script.Parent.FirstFrame
	local secondFrame = script.Parent.SecondFrame
	
	print("WINNER: " .. winner)
	
	if winner == "Raiders" then
		firstFrame.Info.Text = "The raiders were able to push back and take control of the defending team's terminal!"
		firstFrame.WInner.Text = "Winner: Raiders"
	elseif winner == "Defenders" then
		firstFrame.Info.Text = "The defenders were able to maintain control of the terminal and push back the raiding army!"
		firstFrame.WInner.Text = "Winner: Defenders"
	end
	
	for name, score in pairs(homeTeamScores) do
		local tl = Instance.new("TextLabel")
		tl.Text = "Name: " .. name .. " Score: " .. score
		tl.Parent = script.Parent
		--tl.TextXAlignment = Enum.TextXAlignment.Left
		tl.LayoutOrder = -score
		tl.Name = name
		tl.Font = Enum.Font.Arial
		tl.TextSize = 20
		tl.BackgroundTransparency = 1
		tl.Size = UDim2.new(0, 337, 0, 30)
		tl.Parent = home_uiGridLayout.Parent
		if game.Players.LocalPlayer.Name == name then
			tl.TextColor3 = Color3.fromRGB(200, 0, 0)
		end
	end
	home_uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	home_uiGridLayout:ApplyLayout()
	
	for name, score in pairs(raiderTeamScores) do
		local tl = Instance.new("TextLabel")
		tl.Text = "Name: " .. name .. " Score: " .. score
		tl.Font = Enum.Font.Arial
		--tl.TextXAlignment = Enum.TextXAlignment.Left
		tl.TextSize = 20
		tl.Parent = script.Parent
		tl.LayoutOrder = -score
		tl.Name = name
		tl.BackgroundTransparency = 1
		tl.Size = UDim2.new(0, 337, 0, 30)
		tl.Parent = raider_uiGridLayout.Parent
		if game.Players.LocalPlayer.Name == name then
			tl.TextColor3 = Color3.fromRGB(200, 0, 0)
		end
	end
	raider_uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	raider_uiGridLayout:ApplyLayout()
	
	for name, score in pairs(allyTeamScores) do
		local tl = Instance.new("TextLabel")
		tl.Text = "Name: " .. name .. " Score: " .. score
		tl.Font = Enum.Font.Arial
		--tl.TextXAlignment = Enum.TextXAlignment.Left
		tl.TextSize = 20
		tl.Parent = script.Parent
		tl.LayoutOrder = -score
		tl.Name = name
		tl.BackgroundTransparency = 1
		tl.Size = UDim2.new(0, 337, 0, 30)
		tl.Parent = ally_uiGridLayout.Parent
		if game.Players.LocalPlayer.Name == name then
			tl.TextColor3 = Color3.fromRGB(200, 0, 0)
		end
	end
	ally_uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ally_uiGridLayout:ApplyLayout()
	
	
	script.Parent.FirstFrame.Visible = true
	script.Parent.BackFrame.Visible = true
	
	local function openSecondFrame()
		firstFrame.Visible = false
		secondFrame.Visible = true
	end
	firstFrame.continue.MouseButton1Click:Connect(openSecondFrame)
end




function tweenInfoFrame_Open()
	if raidOver == false then
		RaidFrame:TweenSize(UDim2.new(0, 1250, 0, 525), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5, true, nil)
	end
end
function tweenInfoFrame_Close()
	if raidOver == false then
		RaidFrame:TweenSize(UDim2.new(0, 1250, 0, 50), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5, true, nil)
	end
end

function tweenprogressbar(pdone, raidTime)
	RaidFrame.percent.Text = "Raid Progress: " .. tostring(math.ceil(pdone*100)) .. "%"
	RaidFrame.progressbar:TweenSize(UDim2.new(pdone,0,0,50), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.5, true, nil)
	if math.ceil(pdone) == 1 then
		raidOver = true
	end
	captureTime = raidTime
end



function updateStats(timeLeft, NumberOfRaiders, NumberOfDefenders, CapturePoints, homeScore, allyScore, raiderScore)
	InfoFrame.ServerStatsFrame.TimeLeft.Text = "Time Left: " .. tostring(math.ceil(timeLeft)) .. " seconds."
	InfoFrame.ServerStatsFrame.RaiderNumber.Text = "Raiding Players: " .. tostring(NumberOfRaiders)
	InfoFrame.ServerStatsFrame.DefenderNumber.Text = "Defending Players: " .. tostring(NumberOfDefenders)
	InfoFrame.ServerStatsFrame.CaptureTime.Text = "Capture Points: " .. tostring(math.ceil(CapturePoints)) .. "/" .. tostring(captureTime) .. " seconds"
	
	InfoFrame.TeamStatsFrame.DefendersScore.Text = "Defender's Points: " .. tostring(math.ceil(homeScore))
	InfoFrame.TeamStatsFrame["Allies Score"].Text = "Ally's Points: " .. tostring(math.ceil(allyScore))
	InfoFrame.TeamStatsFrame.RaidersScore.Text = "Raider's Points: " .. tostring(math.ceil(raiderScore))
end

function updatePlayerStats(score, kills, deaths)
	InfoFrame.PlayerStatsFrame.Score.Text = "Points: " .. tostring(math.ceil(score))
	InfoFrame.PlayerStatsFrame.Kills.Text = "Kills: " .. tostring(kills)
	InfoFrame.PlayerStatsFrame.Deaths.Text = "Deaths: " .. tostring(deaths)
	if deaths == 0 then
		InfoFrame.PlayerStatsFrame.KDRatio.Text = "K/D Ratio: --"
	else
		InfoFrame.PlayerStatsFrame.KDRatio.Text = "K/D Ratio: " .. tostring(kills/deaths):sub(1, 5)
	end
end

RaidFrame.MouseEnter:Connect(tweenInfoFrame_Open)
RaidFrame.MouseLeave:Connect(tweenInfoFrame_Close)
progressDataTransferModule.OnClientEvent:connect(tweenprogressbar)
playerstatsDataTransferModule.OnClientEvent:Connect(updatePlayerStats)
serverstatsDataTransferModule.OnClientEvent:Connect(updateStats)
endgameDataTransferModule.OnClientEvent:connect(endgameGui)
