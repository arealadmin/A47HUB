local library = loadstring(game:HttpGet(
    ('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
    local w = library:CreateWindow("Kaspyrr Tools") -- Creates the window

    _G.MainColor = Color3.fromRGB(18, 18, 18)
    _G.SecondaryColor = Color3.fromRGB(30, 30, 30)
    _G.TertiaryColor = Color3.fromRGB(50, 50, 50)
    _G.ButtonColor = Color3.fromRGB(60, 60, 60)
    _G.ButtonTextColor = Color3.fromRGB(176, 38, 255)
    _G.ArrowColor = Color3.fromRGB(25, 25, 112)
    _G.PointerColor = Color3.fromRGB(60, 60, 60)
    _G.SliderColor = Color3.fromRGB(246, 20, 255)
    _G.DraggerCircleColor = Color3.fromRGB(246, 20, 255)
 --   local scripts = w:CreateFolder("Script Menu")
    local player = w:CreateFolder("Main")
    local scriptMenu
--------------------------------------------------------------------
game:GetService("CoreGui").PurchasePrompt.Enabled = false
--------------------------------------------------------------------

getgenv().playerESP = false

player:Toggle("Player ESP", function(on)
    playerESP = on
    if on == true then
        toggleESP()
      --  aimBOT()
    end
end)

player:Toggle("No Clip", function(on)
    clipping = on
    if on == true then
        noClip()
    end
end)

player:Toggle("Auto Proximity", function(on)
    prox = on
    if on == true then
        autoProx()
    end
end)

player:Button("Buy Pinks",function()     
    local guns = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i,v in pairs(guns) do
        if v:FindFirstChild("MaxAmmo") then
        v.Firerate.Value = 0.01
        v.MaxAmmo.Value = 9999999
        end
    end

    for i = 1,50 do
        game:GetService("ReplicatedStorage").Events.GunShop.RequestBuy:FireServer('RareM4A1')
        task.wait(0.1)
    end
end)

player:Button("Sell Pinks",function()     
    for i = 1,50 do
    game:GetService("ReplicatedStorage").Events.Shop.RequestSellItem:FireServer(1)
    end
end)

player:Button("TP Tool",function()
    for i,v in pairs(game.Players.LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v.Name == "TP Tool" then
		v:Destroy()
	end
end
	mouse = game.Players.LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "TP Tool"
	tool.Activated:connect(function()
	local pos = mouse.Hit+Vector3.new(0,2.5,0)
	pos = CFrame.new(pos.X,pos.Y,pos.Z)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end)

player:Button("Rejoin",function()     
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

function noClip()
    spawn(function()
        if clipping == true then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        elseif clipping == false then
            v.CanCollide = true
        end
     end)
end

function autoProx()
    spawn(function()
        while prox == true do
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    if v.Parent:IsA("Part") then
                        if v.Parent.Size == Vector3.new(1,1,1) and v.Name ~= "ConscriptionProx" then
                            if (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                            fireproximityprompt(v)
                            end
                        end
                    end
                end
            end
            task.wait(0.7)
        end
    end)
end

function toggleESP()
    spawn(function()
        if playerESP == true then
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")


function playerESPP()
	local namegui = Instance.new("BillboardGui")	
		namegui.Size = UDim2.new(0,120,0,40)
		namegui.SizeOffset = Vector2.new(0,0.5)
		namegui.AlwaysOnTop = true
        namegui.ClipsDescendants = true
        namegui.LightInfluence = 1
		namegui.Name = "Name"
        namegui.StudsOffset = Vector3.new(0,0,0)
        namegui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local text = Instance.new("TextLabel", namegui)
		text.Text = "Player"
		--text.TextColor3 = Color3.fromRGB(255, 0, 0)
        text.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        text.TextStrokeTransparency = 0.5
		text.TextTransparency = 0.25
		text.BackgroundTransparency = 1
		text.TextScaled = false
		text.Size = UDim2.new(1,0,1,0)
        text.TextSize = 16
		text.Font = Enum.Font.GothamSemibold
		text.Name = "Text"
	local Highlight = Instance.new("Highlight")
        Highlight.Name = "Highlight"
        Highlight.FillTransparency = 0.6
        Highlight.OutlineTransparency = 0
	
    for i,v in pairs(Players:GetChildren()) do
      repeat wait() until v.Character --Waits till a character is present
      v.Character:WaitForChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None --hides original nametags so you dont get dupe names
        if v.Team and v.Team ~= game.Players.LocalPlayer.Team then
        local Color = v.Team.TeamColor.Color
        local R,G,B
        R = Color.R * 255
        G = Color.G * 255
        B = Color.B * 255
        text.TextColor3 = Color3.fromRGB(R,G,B)
        Highlight.FillColor = Color3.fromRGB(R,G,B)
        Highlight.OutlineColor = Color3.fromRGB(R,G,B)
        else
        text.TextColor3 = Color3.fromRGB(255,255,255) --shadow players are not on a team
        Highlight.OutlineColor = Color3.fromRGB(0,0,0)
        Highlight.FillColor = Color3.fromRGB(0, 0, 0)
        Highlight.FillTransparency = 0.2 
    end
    
    --------------------------------------name
        if v.Character and v.Character:FindFirstChild("Head") then
            if not v.Character.Head:FindFirstChild("playerName") and v ~= game.Players.LocalPlayer then
                local esp = namegui:Clone()
                esp.Name = "playerName"
                esp:FindFirstChild("Text").Text = v.DisplayName
                esp.Parent = v.Character:FindFirstChild("Head")
            end
   --------------------------------------highlight
            if not v.Character.HumanoidRootPart:FindFirstChild("Highlight") and v.Character.Head:FindFirstChild("playerName") then
                local HighlightClone = Highlight:Clone()
                HighlightClone.Adornee = v.Character
                HighlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                HighlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                HighlightClone.Name = "Highlight"
            end
        end
    end
end


RunService.Heartbeat:Connect(function()
	playerESPP()
end)


Players.PlayerAdded:Connect(function()
for i,v in pairs(Players:GetChildren()) do
    playerESPP()
   end
end)

Players.PlayerRemoving:Connect(function()
	for i,v in pairs(Players:GetChildren()) do
	if v.Character and v.Character.HumanoidRootPart and v.Character.HumanoidRootPart:FindFirstChild("HighlightClone") then
	HighlightClone:Destroy()
	warn("ESP DESTROYED")
	end
	end
end)
          
        end
    end)
end
