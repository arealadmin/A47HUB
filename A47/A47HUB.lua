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
local MainColor = Color3.fromRGB(18, 18, 18)
local SecondaryColor = Color3.fromRGB(30, 30, 30)
local TertiaryColor = Color3.fromRGB(50, 50, 50)
local ButtonColor = Color3.fromRGB(60, 60, 60)
local ButtonTextColor = Color3.fromRGB(176, 38, 255)
local ArrowColor = Color3.fromRGB(25, 25, 112)
local PointerColor = Color3.fromRGB(60, 60, 60)
local SliderColor = Color3.fromRGB(246, 20, 255)
local DraggerCircleColor = Color3.fromRGB(246, 20, 255)

----------------------------------------------------------------------
-- Service and Variable Declarations
----------------------------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService") -- Added for Rejoin
local GroupService = game:GetService("GroupService") -- Added for GetPasses
local LocalPlayer = Players.LocalPlayer
local PID = LocalPlayer.UserId
local scriptMenu
local espConnections = {} -- Store connections for later cleanup
local scripts = w:CreateFolder("Script Menu")
local player = w:CreateFolder("Main")
local playerESP = false -- Moved global variable here for consistency
local clipping = false
local camera = workspace.CurrentCamera

----------------------------------------------------------------------
-- Script Menu Dropdown
----------------------------------------------------------------------
local scriptUrls = {
    ["Dex"] = "https://rawscripts.net/raw/Universal-Script-Keyless-mobile-dex-17888",
    ["Simple Spy"] = "https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua",
    ["Void Hub"] = 'https://rawscripts.net/raw/BlockSpin-Void-Hub-Combat-Script-V2-37572',
    ["Aim Bot"] = "https://raw.githubusercontent.com/Exunys/AirHub-V2/main/src/Main.lua" -- Corrected key name
}

local scriptKeys = {
    ["Void Hub"] = "AMDGLEID"
}

scripts:Dropdown("Scripts", {"Dex", "Simple Spy", "Void Hub", "Aim Bot"}, true, function(selectedScript)
    scriptMenu = selectedScript;
end)

----------------------------------------------------------------------
-- Launch Script Button
----------------------------------------------------------------------
scripts:Button("Launch Script", function()
    if scriptMenu and scriptUrls[scriptMenu] then
        loadstring(game:HttpGet(scriptUrls[scriptMenu]))()
        if scriptKeys[scriptMenu] then
            print(scriptKeys[scriptMenu])
        end
    end
end)

----------------------------------------------------------------------
-- Player Functions
----------------------------------------------------------------------

player:Toggle("Player ESP", function(on)
    playerESP = on
    toggleESP(on)
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
    LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

player:Button("TP Tool", function()
    giveTPtool()
end)

player:Button("Get Passes", function()
    GetPasses()
end)

player:Button("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

----------------------------------------------------------------------
-- ESP Function
----------------------------------------------------------------------
local function updateHealthBar(character, combinedGUI, showHighlights) -- Added showHighlights
    if combinedGUI then
        local healthTextLabel = combinedGUI:FindFirstChild("HealthText")
        if healthTextLabel then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                local playerName = character.Name
                healthTextLabel.Text = playerName .. " " .. math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
                local healthPercentage = humanoid.Health / humanoid.MaxHealth

                -- Gradual color change for health bar
                local startColor = Color3.fromRGB(0, 255, 0)
                local endColor = Color3.fromRGB(255, 0, 0)
                local healthColor = startColor:Lerp(endColor, 1 - healthPercentage)
                healthTextLabel.BackgroundColor3 = healthColor

                healthTextLabel.Size = UDim2.new(healthPercentage, 0, 0.5, 1)

                if showHighlights and character ~= LocalPlayer.Character then -- Only apply to other players and if showHighlights is true
                    local highlight = character.HumanoidRootPart:FindFirstChild("Highlight")
                    if highlight then
                        highlight.FillColor = healthColor
                    end
                end
            end
        end
    end
end

function toggleESP(enable)
    if enable then
        local showHighlights = #Players:GetPlayers() <= 32
        if espConnections.espLoop then
            return
        end

        local Highlight = Instance.new("Highlight")
        Highlight.Name = "Highlight"
        Highlight.FillColor = Color3.fromRGB(255, 255, 255)
        Highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
        Highlight.FillTransparency = 0.6
        Highlight.OutlineTransparency = 0.5

        local combinedGUI = Instance.new("BillboardGui")
        combinedGUI.Size = UDim2.new(0, 180, 0, 60)
        combinedGUI.AlwaysOnTop = true
        combinedGUI.ClipsDescendants = true
        combinedGUI.LightInfluence = 1
        combinedGUI.Name = "Combined"
        combinedGUI.StudsOffset = Vector3.new(0, 0.5, 0)
        combinedGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        combinedGUI.Active = true

        local healthtext = Instance.new("TextLabel", combinedGUI)
        healthtext.Text = "Player 100/100"
        healthtext.TextColor3 = Color3.fromRGB(0, 0, 0)
        healthtext.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        healthtext.TextTransparency = 0
        healthtext.BackgroundTransparency = 0.5
        healthtext.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        healthtext.TextScaled = true
        healthtext.Size = UDim2.new(1, 0, 0.5, 1)
        healthtext.TextSize = 12
        healthtext.Font = Enum.Font.Gotham
        healthtext.Name = "HealthText"
        healthtext.AnchorPoint = Vector2.new(0.5, 0.5)
        healthtext.Position = UDim2.new(0.5, 0, 0.5, 0)
        healthtext.TextXAlignment = Enum.TextXAlignment.Center
        healthtext.TextYAlignment = Enum.TextYAlignment.Center

        local function playerESPP()
            for i, v in pairs(Players:GetChildren()) do
                if v ~= LocalPlayer then
                    if v.Team then
                        local Color = v.Team.TeamColor.Color
                        local R, G, B = Color.R * 255, Color.G * 255, Color.B * 255
                    end

                    if v.Character and v.Character:FindFirstChild("Head") then
                        local head = v.Character.Head
                        local combined = head:FindFirstChild("Combined")
                        local highlight = v.Character.HumanoidRootPart:FindFirstChild("Highlight")

                        if not combined then
                            local combinedGUIClone = combinedGUI:Clone()
                            combinedGUIClone.Name = "Combined"
                            combinedGUIClone.Parent = head
                        end

                        if not highlight and showHighlights then -- Apply highlight only when showHighlights is true
                            local HighlightClone = Highlight:Clone()
                            HighlightClone.Adornee = v.Character
                            HighlightClone.Parent = v.Character.HumanoidRootPart
                            HighlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            HighlightClone.Name = "Highlight"
                            highlight = HighlightClone
                        end

                        local humanoid = v.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            updateHealthBar(v.Character, combined, showHighlights) -- Pass showHighlights
                            -- Calculate distance and adjust GUI size
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.Head.Position).Magnitude
                            local scale = 40 / (distance + 40)
                            if combined then
                                combined.Size = UDim2.new(0, 180 * scale, 0, 60 * scale)
                                combined.SizeOffset = Vector2.new(0, 0)
                            end

                            if not espConnections[v.Name] then
                                espConnections[v.Name] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                                    updateHealthBar(v.Character, combined, showHighlights) -- Pass showHighlights
                                end)
                            end
                        end
                    end
                end
            end
        end

        espConnections.playerAddedConnection = Players.PlayerAdded:Connect(function(player)
            espConnections.characterAddedConnection = player.CharacterAdded:Connect(function(character)
                local head = character:WaitForChild("Head")
                local humanoid = character:FindFirstChild("Humanoid")
                local combined = head:FindFirstChild("Combined")
                local highlight = character.HumanoidRootPart:FindFirstChild("Highlight")

                 if not combined then
                    local combinedGUIClone = combinedGUI:Clone()
                    combinedGUIClone.Name = "Combined"
                    combinedGUIClone.Parent = head
                end

                if not highlight and showHighlights and character ~= LocalPlayer.Character then -- Apply only when showHighlights is true
                    local HighlightClone = Highlight:Clone()
                    HighlightClone.Adornee = character
                    HighlightClone.Parent = character.HumanoidRootPart
                    HighlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    HighlightClone.Name = "Highlight"
                    highlight = HighlightClone
                end

                if humanoid then
                    updateHealthBar(character, combined, showHighlights) -- Pass showHighlights
                    if not espConnections[player.Name] then
                        espConnections[player.Name] = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                            updateHealthBar(character, combined, showHighlights) -- Pass showHighlights
                        end)
                    end
                end
            end)
        end)

        espConnections.espLoop = RunService.RenderStepped:Connect(playerESPP)
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

        for _, player in pairs(Players:GetChildren()) do
            if player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local combined = head:FindFirstChild("Combined")
                    if combined then
                        combined:Destroy()
                    end
                end
            end
        end
    end
end

----------------------------------------------------------------------
-- Game-Specific Functions
----------------------------------------------------------------------

if game.PlaceId == 104715542330896 then
    local blockSpin = w:CreateFolder("BlockSpin")
     blockSpin:Button("Proximity Extender", function()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and
                    v.Parent:IsA("Part") and
                    v.Name == "ProximityPrompt" then -- and
                    --(v.Parent.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                    -- fireproximityprompt(v)
                    v.RequiresLineOfSight = false
                    v.Enabled = true
                    v.MaxActivationDistance = 23
                end
            end
    end)
    
    blockSpin:Button("Fast Melees", function()
        local weapons = game:GetService("Players").LocalPlayer.Backpack:GetChildren()
        for _, v in pairs(weapons) do
            local hasSpeed = v:GetAttribute("Speed")
            if hasSpeed then
                v:SetAttribute("Speed", 2)
                v:SetAttribute("ConeAngle", 360)
                    print("Changed the speed of " ..  v.Name)
                else
                    print("You do not have any weapons!")
            end
        end
    end)

end

if game.PlaceId == 2693739238 then
    player:Button("Buy Pinks", function()
        local guns = game:GetService("ReplicatedStorage").Weapons:GetChildren()
        for _, v in pairs(guns) do
            if v:FindFirstChild("MaxAmmo") then
                v.Firerate.Value = 0.01
                v.MaxAmmo.Value = 9999999
            end
        end
        for i = 1, 50 do
            game:GetService("ReplicatedStorage").Events.GunShop.RequestBuy:FireServer('RareM4A1')
            task.wait(0.1)
        end
    end)

    player:Button("Sell Pinks", function()
        for i = 1, 50 do
            game:GetService("ReplicatedStorage").Events.Shop.RequestSellItem:FireServer(1)
        end
    end)
end

----------------------------------------------------------------------
-- No Clip Function
----------------------------------------------------------------------
function noClip()
    spawn(function()
        while clipping do
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
            task.wait(0.5)
        end
    end)
end

----------------------------------------------------------------------
-- TP Tool Function
----------------------------------------------------------------------
function giveTPtool()
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")

    for _, v in pairs(backpack:GetChildren()) do
        if v.Name == "TP Tool" then
            v:Destroy()
            break
        end
    end

    local mouse = LocalPlayer:GetMouse()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "TP Tool"

    tool.Activated:Connect(function()
        local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
    end)

    tool.Parent = backpack
end

----------------------------------------------------------------------
-- Get Passes Function
----------------------------------------------------------------------
function GetPasses()
    local creatorType = game.CreatorType

    if creatorType == Enum.CreatorType.User then
        LocalPlayer.UserId = game.CreatorId
    elseif creatorType == Enum.CreatorType.Group then
        local groupInfo = GroupService:GetGroupInfoAsync(game.CreatorId)
        LocalPlayer.UserId = groupInfo.Owner.Id
    end
end

