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
    local a = w:CreateFolder("Script Menu")
    local b = w:CreateFolder("Player")
    local scriptMenu
--------------------------------------------------------------------
game:GetService("CoreGui").PurchasePrompt.Enabled = false -- AMAZING
--------------------------------------------------------------------
a:Dropdown("Scripts", {"Simple Spy", "Infinite Yield", "V.G Hub"}, true,
    function(script) -- true/false, replaces the current title "Dropdown" with the option that t
        scriptMenu = script;
    end)

a:Button("Launch Script", function()
    if scriptMenu == "Simple Spy" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    elseif scriptMenu == "Infinite Yield" then
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'), true))()
    elseif scriptMenu == "V.G Hub" then
        loadstring(game:HttpGet('https://raw.githubusercontent.com/1201for/V.G-Hub/main/V.Ghub'))()
    end
end)

-- a:DestroyGui()
b:Slider("Walk Speed", {
    min = 16,
    max = 200,
    precise = true
    }, function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
--------------------------------------------------------------------------
if game.PlaceId == 4704006941 then

    local library = loadstring(game:HttpGet(
        ('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
    local w = library:CreateWindow("Blade Simulator")
    local a = w:CreateFolder("Blade Simulator")
    local b = w:CreateFolder("Scripts")
    local path = game:GetService("ReplicatedStorage").RF
    local playerHead = game.Players.LocalPlayer.Character.Head

    getgenv().autoThrow = false
    getgenv().autoSell = false
    getgenv().autoUpgrades = false
    getgenv().autoRank = false
    getgenv().autoEgg = false
    getgenv().autoEvolve = false
    getgenv().autoGems = false

    a:Toggle("Auto Throw", function(bool)
        autoThrow = bool
        if bool == true then
            toggleThrow()
        end
    end)

    a:Toggle("Auto Sell", function(bool)
        autoSell = bool
        if bool == true then
            toggleSell()
        end
    end)

    a:Toggle("Auto Upgrades", function(bool)
        autoUpgrades = bool
        if bool == true then
            toggleBlade()
            toggleEnergy()
        end
    end)

    a:Toggle("Auto Buy Rank", function(bool)
        autoRank = bool
        if bool == true then
            toggleRank()
        end
    end)

    a:Toggle("Auto Buy Pets", function(bool)
        autoEgg = bool
        if bool == true then
            toggleEgg()
        end
    end)

    a:Toggle("Auto Evolve", function(bool)
        autoEvolve = bool
        if bool == true then
            toggleEvolve()
        end
    end)

    a:Toggle("Auto Gems", function(bool)
        autoGems = bool
        if bool == true then
            toggleAutoGems()
        end
    end)

    b:Button("Simple Spy", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
    end)
    --------------------------------------------------------------------
    function toggleThrow()
        spawn(function()
            while autoThrow == true do
                local args = {
                    [1] = "Throw",
                    [2] = Vector3.new(),
                    [3] = false
                }
                game:GetService("ReplicatedStorage").RE:FireServer(unpack(args))
                wait(0.4)
            end
        end)
    end

    function toggleSell()
        spawn(function()
            while autoSell == true do
                local args = {
                    [1] = "SellPower",
                    [2] = workspace.Ignore.Rings:FindFirstChild("27Sell").Collider
                }
                path:InvokeServer(unpack(args))
                wait(0.5)
            end
        end)
    end

    function toggleBlade()
        spawn(function()
            while autoUpgrades == true do
                local args = {
                    [1] = "BuyBlade",
                    [2] = true
                }
                path:InvokeServer(unpack(args))
                wait(2)
            end
        end)
    end

    function toggleEnergy()
        spawn(function()
            while autoUpgrades == true do
                local args = {
                    [1] = "BuyEnergy",
                    [2] = true
                }
                path:InvokeServer(unpack(args))
                wait(4)
            end
        end)
    end

    function toggleRank()
        spawn(function()
            while autoRank == true do
                path:InvokeServer('BuyRank')
                wait(60)
            end
        end)
    end

    function toggleEgg()
        spawn(function()
            while autoEgg == true do
                local args = {
                    [1] = "BuyEgg",
                    [2] = "ElectricEgg"
                } -- Best Egg is Ice
                path:InvokeServer(unpack(args))
                wait()
            end
        end)
    end

    function toggleEvolve()
        spawn(function()
            while autoEvolve == true do
                path:InvokeServer("EvolveAll")
                wait()
            end
        end)
    end

    function toggleAutoGems()
        spawn(function()
            while autoGems == true do
                for i, v in pairs(game:GetService("Workspace").Collect.Gem:GetDescendants()) do
                    if v.Name == 'TouchInterest' and v.Parent then
                        firetouchinterest(playerHead, v.Parent, 0)
                        wait(0.5)
                        firetouchinterest(playerHead, v.Parent, 1)
                    end
                end
            end
        end)
    end

end
