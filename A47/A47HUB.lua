--[[ local Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
Aimbot.Load()

ExunysDeveloperAimbot.Settings.TriggerKey = Enum.UserInputType.MouseButton2
ExunysDeveloperAimbot.FOVSettings.Radius = 60
ExunysDeveloperAimbot.Settings.WallCheck = true
--]]

loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'), true))()
--------------------------------------------------------------------
--------------------------------------------------------------------
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
    local scripts = w:CreateFolder("Script Menu")
    local player = w:CreateFolder("Main")
    local PID = game.Players.LocalPlayer.UserId
    local scriptMenu
-------------------------------------------------------------------- 
--------------------------------------------------------------------

 getgenv().playerESP = false

scripts:Dropdown("Scripts", {"Remote Explorer", "Simple Spy", "Void Hub", "Aim Bot"}, true,
    function(script) -- true/false, replaces the current title "Dropdown" with the option that t
       scriptMenu = script;
    end)

scripts:Button("Launch Script", function()
	if scriptMenu == "Remote Explorer" then
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Remote-Explorer-38352"))()
    elseif scriptMenu == "Simple Spy" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    elseif scriptMenu == "Void Hub" then
        loadstring(game:HttpGet('https://rawscripts.net/raw/BlockSpin-Void-Hub-Combat-Script-V2-37572'))()
	print("Void Hub Key: AMDGLEID")
    elseif scriptMenu == "Aim Bot" then
       -- aimBOT()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub-V2/main/src/Main.lua"))()
    end
end)

-- a:DestroyGui()     -- loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Remote-Explorer-38352"))()

player:Toggle("Player ESP", function(on)
    playerESP = on
    if on == true then
        toggleESP()
    end
end)

player:Toggle("No Clip", function(on)
    clipping = on
    if on == true then
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

function toggleESP()
    spawn(function()
        if playerESP == true then
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")


function playerESPP()

    local Highlight = Instance.new("Highlight")
        Highlight.Name = "Highlight"
        Highlight.FillColor = Color3.fromRGB(255, 255, 255)
        --Highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        Highlight.FillTransparency = 0.8
        Highlight.OutlineTransparency = 0
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
    for i,v in pairs(Players:GetChildren()) do
  --  repeat wait() until v.Character
        if v.Team then
        local Color = v.Team.TeamColor.Color
        local R,G,B
        R = Color.R * 255
        G = Color.G * 255
        B = Color.B * 255
        text.TextColor3 = Color3.fromRGB(R,G,B)
        Highlight.OutlineColor = Color3.fromRGB(R,G,B)
        else
        text.TextColor3 = Color3.fromRGB(0,255,0) --white/green players are not on a team
        Highlight.OutlineColor = Color3.fromRGB(255,255,255)
    end
        if v.Character and v.Character:FindFirstChild("Head") then
            if not v.Character.Head:FindFirstChild("playerName") and v ~= game.Players.LocalPlayer then
                local esp = namegui:Clone()
                esp.Name = "playerName"
                esp:FindFirstChild("Text").Text = v.Name
                esp.Parent = v.Character:FindFirstChild("Head")
            end
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") and v.Character.Head:FindFirstChild("playerName") then
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
          
        end
    end)
end
--------------------------------------------------------------------------
function aimBOT()
    local AimPart = "Head"
    local Sens = 0
    local Radius = 70
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Camera = game.Workspace.CurrentCamera
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer    
    
    
function getClosest()
    local closestPlayer = nil
    local closesDist = Radius
    for i,v in pairs(Players:GetChildren()) do
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v.Team and v.Character.Humanoid.Health > 0 and v.Team ~= Player.Team then
            local Screen = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
            local Dist = (Vector2.new(UIS:GetMouseLocation().X,UIS:GetMouseLocation().Y) - Vector2.new(Screen.X, Screen.Y)).magnitude
            if Dist < closesDist then
        --    closesDist = Dist
            closestPlayer = v
            end
        end
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and not v.Team and v.Character.Humanoid.Health > 0 and v ~= Player then
            local Screen = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
            local Dist = (Vector2.new(UIS:GetMouseLocation().X,UIS:GetMouseLocation().Y) - Vector2.new(Screen.X, Screen.Y)).magnitude
            if Dist < closesDist then
      --      closesDist = Dist
            closestPlayer = v
            end
        end
    end
   return closestPlayer
end
    
    
UIS.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then        
        _G.aim = true
        if _G.aim == false then
            return
        end
    end
end)
    
UIS.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2 then
        _G.aim = false
    end
end)
    
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.aim == true and getClosest().Character:FindFirstChild(AimPart) then
    TweenService:Create(Camera, TweenInfo.new(Sens, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, getClosest().Character[AimPart].Position)}):Play()
    end
end)


end







---------------------------------------------------------------------
if game.PlaceId == 9588998913 then
	player:Toggle("Auto Proximity", function(on)
    	prox = on
    if on == true then
        autoProx()
   		 end
	end)
end

if game.PlaceId == 2693739238 then
    player:Button("Buy Pinks",function()     
        BuyPinks()
    end)

    player:Button("Sell Pinks",function()     
        SellPinks()
    end)
end

player:Button("TP Tool",function()
    giveTPtool()
end)

if PID == 9382448 or 3663326476 then
    player:Button("Get Passes",function()     
     GetPasses()
    end)
end
player:Button("Rejoin",function()     
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

function noClip()
    spawn(function()
        while clipping == true do
            for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
            task.wait(0.5)
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
            task.wait(0.8)
        end
    end)
end

function giveTPtool()
    for i,v in pairs(game.Players.LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
		if v.Name == "TP Tool" then
		v:Destroy()
        end
	end
	local mouse = game.Players.LocalPlayer:GetMouse()
	tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool.Name = "TP Tool"
	tool.Activated:connect(function()
	local pos = mouse.Hit+Vector3.new(0,2.5,0)
	pos = CFrame.new(pos.X,pos.Y,pos.Z)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
	end)
	tool.Parent = game.Players.LocalPlayer.Backpack
end

function BuyPinks()
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
end

function SellPinks()
    for i = 1,50 do
        game:GetService("ReplicatedStorage").Events.Shop.RequestSellItem:FireServer(1)
    end
end

function GetPasses()
    if game.CreatorType == Enum.CreatorType.User then
        game.Players.LocalPlayer.UserId = game.CreatorId
    end
    if game.CreatorType == Enum.CreatorType.Group then
        game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
    end
end

