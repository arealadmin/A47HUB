--game:GetService("CoreGui").PurchasePrompt.Enabled = false
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
    local player = w:CreateFolder("Main")
    local PID = game.Players.LocalPlayer.UserId
-------------------------------------------------------------------- 
--------------------------------------------------------------------
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
                            if (v.Parent.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 30 then
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

