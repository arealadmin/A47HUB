----------------------------------------------------------------------
-- Infinite Yield Loader
----------------------------------------------------------------------
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'), true))()

----------------------------------------------------------------------
-- Library and Window Setup
----------------------------------------------------------------------
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow("Kaspyrr Tools")

----------------------------------------------------------------------
-- Global Color Definitions
----------------------------------------------------------------------
_G.MainColor = Color3.fromRGB(18, 18, 18)
_G.SecondaryColor = Color3.fromRGB(30, 30, 30)
_G.TertiaryColor = Color3.fromRGB(50, 50, 50)
_G.ButtonColor = Color3.fromRGB(60, 60, 60)
_G.ButtonTextColor = Color3.fromRGB(176, 38, 255)
_G.ArrowColor = Color3.fromRGB(25, 25, 112)
_G.PointerColor = Color3.fromRGB(60, 60, 60)
_G.SliderColor = Color3.fromRGB(246, 20, 255)
_G.DraggerCircleColor = Color3.fromRGB(246, 20, 255)

----------------------------------------------------------------------
-- Service and Variable Declarations
----------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PID = game.Players.LocalPlayer.UserId
local scriptMenu
local espConnections = {} -- Store connections for later cleanup

----------------------------------------------------------------------
-- Folder Creation
----------------------------------------------------------------------
local scripts = w:CreateFolder("Script Menu")
local player = w:CreateFolder("Main")

----------------------------------------------------------------------
-- Global Variable
----------------------------------------------------------------------
getgenv().playerESP = false

----------------------------------------------------------------------
-- Script Menu Dropdown
----------------------------------------------------------------------
scripts:Dropdown("Scripts", {"Dex", "Simple Spy", "Void Hub", "Aim Bot"}, true, function(selectedScript)
    scriptMenu = selectedScript;
end)

----------------------------------------------------------------------
-- Launch Script Button
----------------------------------------------------------------------
scripts:Button("Launch Script", function()
    if scriptMenu == "Dex" then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888"))()
    elseif scriptMenu == "Simple Spy" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    elseif scriptMenu == "Void Hub" then
        loadstring(game:HttpGet('https://rawscripts.net/raw/BlockSpin-Void-Hub-Combat-Script-V2-37572'))()
        print("Void Hub Key: AMDGLEID")
    elseif scriptMenu == "Aim Bot" then
        -- aimBOT() --removed for error
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub-V2/main/src/Main.lua"))()
    end
end)

----------------------------------------------------------------------
-- Player Functions
----------------------------------------------------------------------

player:Toggle("Player ESP", function(on)
    playerESP = on
    if on then
        toggleESP(true) -- Pass true to indicate ESP should be turned ON
    else
        toggleESP(false) -- Pass false to indicate ESP should be turned OFF
    end
end)

player:Toggle("No Clip", function(on)
    clipping = on
    if on then
        noClip()
    end
end)

player:Slider("Walk Speed", {
    min = 16,
    max = 32,
    precise = true
}, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

player:Button("TP Tool", function()
    giveTPtool()
end)

player:Button("Get Passes", function()
    GetPasses()
end)

player:Button("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

----------------------------------------------------------------------
-- ESP Function
----------------------------------------------------------------------
function toggleESP(enable) -- Added enable parameter
    if enable then
        if espConnections.espLoop then return end
        local function playerESPP()
            local Players = game:GetService("Players")

            local Highlight = Instance.new("Highlight")
            Highlight.Name = "Highlight"
         -  Highlight.FillColor = Color3.fromRGB(255, 255, 255)
            Highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            Highlight.FillTransparency = 0.6
            Highlight.OutlineTransparency = 0.5

            local namegui = Instance.new("BillboardGui")
            namegui.Size = UDim2.new(0, 120, 0, 40)
            namegui.SizeOffset = Vector2.new(0, 0.5)
            namegui.AlwaysOnTop = true
            namegui.ClipsDescendants = true
            namegui.LightInfluence = 1
            namegui.Name = "Name"
            namegui.StudsOffset = Vector3.new(0, 0, 0)
            namegui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local healthgui = Instance.new("BillboardGui")
            healthgui.Size = UDim2.new(0, 120, 0, 20)
            healthgui.SizeOffset = Vector2.new(0, -2.5)
            healthgui.AlwaysOnTop = true
            healthgui.ClipsDescendants = true
            healthgui.LightInfluence = 0
            healthgui.Name = "HealthBar"
            healthgui.StudsOffset = Vector3.new(0, -2, 0)
            healthgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            local nametext = Instance.new("TextLabel", namegui)
            nametext.Text = "Player"
            nametext.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            nametext.TextStrokeTransparency = 0.5
            nametext.TextTransparency = 0.25
            nametext.BackgroundTransparency = 1
            nametext.TextScaled = false
            nametext.Size = UDim2.new(1, 0, 1, 0)
            nametext.TextSize = 16
            nametext.Font = Enum.Font.GothamSemibold
            nametext.Name = "Text"

            local healthtext = Instance.new("TextLabel", healthgui)
            healthtext.Text = "100/100"
            healthtext.TextColor3 = Color3.fromRGB(255, 255, 255)
            healthtext.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            healthtext.TextStrokeTransparency = 0.5
            healthtext.TextTransparency = 0
            healthtext.BackgroundTransparency = 0.5
            healthtext.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            healthtext.TextScaled = false
            healthtext.Size = UDim2.new(1, 0, 1, 0)
            healthtext.TextSize = 12
            healthtext.Font = Enum.Font.Gotham
            healthtext.Name = "HealthText"
            healthtext.AnchorPoint = Vector2.new(0.5, 0.5)
            healthtext.Position = UDim2.new(0.5, 0, 0.5, 0)
            healthtext.TextXAlignment = Enum.TextXAlignment.Center
            healthtext.TextYAlignment = Enum.TextYAlignment.Center

            for i, v in pairs(Players:GetChildren()) do
                if v.Team then
                    local Color = v.Team.TeamColor.Color
                    local R, G, B = Color.R * 255, Color.G * 255, Color.B * 255
                    nametext.TextColor3 = Color3.fromRGB(R, G, B)
                   -- Highlight.OutlineColor = Color3.fromRGB(R, G, B)
                else
                    nametext.TextColor3 = Color3.fromRGB(0, 255, 0)
                   -- Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end

                if v.Character and v.Character:FindFirstChild("Head") then
                    local head = v.Character.Head
                    local humanoid = v.Character:FindFirstChild("Humanoid")

                    if not head:FindFirstChild("playerName") and v ~= game.Players.LocalPlayer then
                        local esp = namegui:Clone()
                        local healthbar = healthgui:Clone()
                        esp.Name = "playerName"
                        healthbar.Name = "playerHealthBar"
                        esp:FindFirstChild("Text").Text = v.Name
                        healthbar:FindFirstChild("HealthText").Text = humanoid.Health
                        healthbar.Parent = head
                        esp.Parent = head
                         -- Store a reference to the healthbar for updating later
                        v.Character.healthBar = healthbar
                    end
                    if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and head:FindFirstChild("playerName") then
                        local HighlightClone = Highlight:Clone()
                        HighlightClone.Adornee = v.Character
                        HighlightClone.Parent = v.Character.HumanoidRootPart
                        HighlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        HighlightClone.Name = "Highlight"
                    end
                    if humanoid then
                         local function updateHealthBar(character)
                            local characterHealthBar = character:FindFirstChild("Head"):FindFirstChild("playerHealthBar")
                            if characterHealthBar then
                                local healthTextLabel = characterHealthBar:FindFirstChild("HealthText")
                                if healthTextLabel then
                                    local humanoid = character:FindFirstChild("Humanoid")
                                    if humanoid then
                                        healthTextLabel.Text = math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
                                         local healthPercentage = humanoid.Health / humanoid.MaxHealth
                                        healthTextLabel.Size = UDim2.new(healthPercentage, 0, 1, 0)
                                        if healthPercentage > 0.5 then
                                            healthTextLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                            Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                        elseif healthPercentage > 0.25 then
                                            healthTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                            Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                                        else
                                            healthTextLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                            Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        end
                                    end
                                end
                            end
                        end
                        if not espConnections[v.Name] then
                           espConnections[v.Name] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                                updateHealthBar(v.Character)
                           end)
                        end
                        updateHealthBar(v.Character)
                    end
                end
            end
        end

        espConnections.playerAddedConnection = game.Players.PlayerAdded:Connect(function(player)
            espConnections.characterAddedConnection = player.CharacterAdded:Connect(function(character)
                local head = character:WaitForChild("Head")
                local humanoid = character:FindFirstChild("Humanoid")
                if not head:FindFirstChild("playerName") then
                    local esp = namegui:Clone()
                    esp.Name = "playerName"
                    esp:FindFirstChild("Text").Text = player.Name
                    esp.Parent = head
                end
                if not head:FindFirstChild("playerHealthBar") then
                    local healthbar = healthgui:Clone()
                    healthbar.Name = "playerHealthBar"
                    healthbar:FindFirstChild("HealthText").Text = humanoid.Health
                    healthbar.Parent = head
                    character.healthBar = healthbar
                end

                if not character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                    local HighlightClone = Highlight:Clone()
                    HighlightClone.Adornee = character
                    HighlightClone.Parent = character.HumanoidRootPart
                    HighlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    HighlightClone.Name = "Highlight"
                end
                if humanoid then
                    local function updateHealthBar(character)
                        local characterHealthBar = character:FindFirstChild("Head"):FindFirstChild("playerHealthBar")
                        if characterHealthBar then
                            local healthTextLabel = characterHealthBar:FindFirstChild("HealthText")
                            if healthTextLabel then
                                local humanoid = character:FindFirstChild("Humanoid")
                                if humanoid then
                                     healthTextLabel.Text = math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
                                     local healthPercentage = humanoid.Health / humanoid.MaxHealth
                                    healthTextLabel.Size = UDim2.new(healthPercentage, 0, 1, 0)
                                    if healthPercentage > 0.5 then
                                        healthTextLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        Highlight.FillColor = Color3.fromRGB(0, 255, 0)
                                    elseif healthPercentage > 0.2 then
                                        healthTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
                                        Highlight.FillColor = Color3.fromRGB(255, 255, 0)
                                    else
                                        healthTextLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                                        Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                    end
                                end
                            end
                        end
                    end

                   if not espConnections[player.Name] then
                        espConnections[player.Name] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                            updateHealthBar(character)
                        end)
                   end
                    updateHealthBar(character)
                end
            end)
        end)

        espConnections.espLoop = RunService.RenderStepped:Connect(function()
            playerESPP()
        end)
    else
        -- Disconnect all connections and destroy instances
        if espConnections.espLoop then
            espConnections.espLoop:Disconnect()
            espConnections.espLoop = nil
        end
        if espConnections.playerAddedConnection then
            espConnections.playerAddedConnection:Disconnect()
            espConnections.playerAddedConnection = nil
        end
        if espConnections.characterAddedConnection then
            espConnections.characterAddedConnection:Disconnect()
            espConnections.characterAddedConnection = nil
        end
        if espConnections then
            for playerName, connection in pairs(espConnections) do
                if type(connection) == "RBXScriptSignal" then
                    connection:Disconnect()
                end
                espConnections[playerName] = nil
            end
        end

        for _, player in pairs(game.Players:GetChildren()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local nameLabel = head:FindFirstChild("playerName")
                    local healthBar = head:FindFirstChild("playerHealthBar")
                    if nameLabel then
                        nameLabel:Destroy()
                    end
                    if healthBar then
                        healthBar:Destroy()
                    end
                end
                local highlight = player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

----------------------------------------------------------------------
-- Game-Specific Functions
----------------------------------------------------------------------

if game.PlaceId == 9588998913 then
    player:Toggle("Auto Proximity", function(on)
        prox = on
        if on then
            autoProx()
        end
    end)
end

if game.PlaceId == 2693739238 then
    player:Button("Buy Pinks", function()
        BuyPinks()
    end)

    player:Button("Sell Pinks", function()
        SellPinks()
    end)
end

----------------------------------------------------------------------
-- No Clip Function
----------------------------------------------------------------------
function noClip()
    spawn(function()
        while clipping do
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
            task.wait(0.5)
        end
    end)
end

----------------------------------------------------------------------
-- Auto Proximity Function
----------------------------------------------------------------------
function autoProx()
    spawn(function()
        while prox do
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    if v.Parent:IsA("Part") then
                        if v.Parent.Size == Vector3.new(1, 1, 1) and v.Name ~= "ConscriptionProx" then
                            if (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                                fireproximityprompt(v)
                            end
                        end
                    end
                end
            end
            task.wait(0.8)
        end
    end)
end

----------------------------------------------------------------------
-- TP Tool Function
----------------------------------------------------------------------
function giveTPtool()
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChildOfClass("Backpack")

    for _, v in pairs(backpack:GetChildren()) do
        if v.Name == "TP Tool" then
            v:Destroy()
        end
    end

    local mouse = player:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "TP Tool"

    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        pos = CFrame.new(pos.X, pos.Y, pos.Z)
        player.Character.HumanoidRootPart.CFrame = pos
    end)

    tool.Parent = backpack
end

----------------------------------------------------------------------
-- Buy Pinks Function
----------------------------------------------------------------------
function BuyPinks()
    local guns = game:GetService("ReplicatedStorage").Weapons:GetChildren()
    for i, v in pairs(guns) do
        if v:FindFirstChild("MaxAmmo") then
            v.Firerate.Value = 0.01
            v.MaxAmmo.Value = 9999999
        end
    end
    for i = 1, 50 do
        game:GetService("ReplicatedStorage").Events.GunShop.RequestBuy:FireServer('RareM4A1')
        task.wait(0.1)
    end
end

----------------------------------------------------------------------
-- Sell Pinks Function
----------------------------------------------------------------------
function SellPinks()
    for i = 1, 50 do
        game:GetService("ReplicatedStorage").Events.Shop.RequestSellItem:FireServer(1)
    end
end

----------------------------------------------------------------------
-- Get Passes Function
----------------------------------------------------------------------
function GetPasses()
    local creatorType = game.CreatorType
    local player = game.Players.LocalPlayer

    if creatorType == Enum.CreatorType.User then
        player.UserId = game.CreatorId
    elseif creatorType == Enum.CreatorType.Group then
        local groupService = game:GetService("GroupService")
        local groupInfo = groupService:GetGroupInfoAsync(game.CreatorId)
        player.UserId = groupInfo.Owner.Id
    end
end
