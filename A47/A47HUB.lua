local library = loadstring(game:HttpGet(
    ('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
    local w = library:CreateWindow("A47 HUB") -- Creates the window

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
    local player = w:CreateFolder("Toggles")
    local scriptMenu
--------------------------------------------------------------------
game:GetService("CoreGui").PurchasePrompt.Enabled = false
--------------------------------------------------------------------

getgenv().playerESP = false


scripts:Dropdown("Scripts", {"Dark Dex", "Simple Spy", "Infinite Yield", "Aim Bot"}, true,
    function(script) -- true/false, replaces the current title "Dropdown" with the option that t
       scriptMenu = script;
    end)

scripts:Button("Launch Script", function()
	if scriptMenu == "Dark Dex" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    elseif scriptMenu == "Simple Spy" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    elseif scriptMenu == "Infinite Yield" then
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'), true))()
    elseif scriptMenu == "Aim Bot" then
        aimBOT()
    end
end)

-- a:DestroyGui()
--[
player:Slider("Walk Speed", {
    min = 16,
    max = 200,
    precise = true
    }, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
--]]
player:Toggle("Player ESP", function(on)
    playerESP = on
    if on == true then
        toggleESP()
    end
end)

player:Toggle("Auto Smith", function(on)
    smith = on
    if on == true then
        autoSmith()
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

function autoSmith()
    spawn(function()
        while smith == true do
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
--------------------------------------------------------------------------
function aimBOT()
    local AimPart = "Head"
    local Sens = 0
    local Radius = 60
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
            local Screen = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", 200).Position)
            local Dist = (Vector2.new(UIS:GetMouseLocation().X,UIS:GetMouseLocation().Y) - Vector2.new(Screen.X, Screen.Y)).magnitude
            if Dist < closesDist then
            closestPlayer = v
            end
        end
        if v.Character and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and not v.Team and v.Character.Humanoid.Health > 0 and v ~= Player then
            local Screen = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", 200).Position)
            local Dist = (Vector2.new(UIS:GetMouseLocation().X,UIS:GetMouseLocation().Y) - Vector2.new(Screen.X, Screen.Y)).magnitude
            if Dist < closesDist then
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
    
game:GetService("RunService").RenderStepped:Connect(function()--AIMBOT
    if _G.aim == true and getClosest().Character then
 	TweenService:Create(Camera, TweenInfo.new(Sens, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, getClosest().Character[AimPart].Position)}):Play()
   end
end)


end
