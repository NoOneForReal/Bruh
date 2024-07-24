loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua"))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/liam0999/Drawing2/main/Drawing2.lua'))()

for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
    if v["Disable"] then
        v["Disable"](v)
    elseif v["Disconnect"] then
        v["Disconnect"](v)
    end
end

local OldMetaMethod;OldMetaMethod = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    if getnamecallmethod() == "FireServer" then
        if self.Parent.Name == "aa" then
            return nil
        end
    end
    return OldMetaMethod(self,...)
end))

local old; old = hookfunction(Drawing.new, function(class, properties)
    local drawing = old(class)
    for i,v in next, properties or {} do
        drawing[i] = v
    end
    return drawing
end)

local Lighting = game:GetService('Lighting')
local runservice = game:GetService('RunService')
local inputservice = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')
local camera = workspace.CurrentCamera

local uis, players, localplayer, camera, wtsp, wtvp, getplayers, findfirstchild, findfirstchildofclass, mouse, getchildren, getdescendants, isa, getpartsobscuringtarget, isfriendswith = game.UserInputService, game.Players, game.Players.LocalPlayer, workspace.CurrentCamera, workspace.CurrentCamera.WorldToScreenPoint, workspace.CurrentCamera.WorldToViewportPoint, game.Players.GetPlayers, workspace.FindFirstChild, workspace.FindFirstChildOfClass, game.Players.LocalPlayer:GetMouse(), workspace.GetChildren, workspace.GetDescendants, workspace.IsA, workspace.CurrentCamera.GetPartsObscuringTarget, game.Players.LocalPlayer.IsFriendsWith
local LocalPlayer = game.Players.LocalPlayer

loadstring(game:HttpGet("https://raw.githubusercontent.com/razorwarecc/bronx.fun/main/hitsounds"))() -- hitsounds
local utility = {}
function utility:draw(name, properties)
    local drawing = Drawing.new(name)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end
function utility:instance(name, properties)
    local instance = Instance.new(name)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end
function utility:beam(props)
    local timed = props.Timed or props.timed or false
    local duration = props.Duration or props.duration or 3
    local origin = props.origin or props.Origin or props.from or props.From or props.pos1 or props.pos1 or props.Pos1
    local to = props.to or props.To or props.pos2 or props.pos2 or props.Pos2
    local widthx = props.widthx or props.Widthx or props.x or props.X or props.width1 or props.Width1 or 0.5
    local widthy = props.widthy or props.Widthy or props.y or props.Y or props.width2 or props.Width2 or 0.5
    local texture = props.Texture or props.texture or ""
    local color = props.Color or props.color or ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255))
    local part1, part2 = Instance.new("Part", workspace), Instance.new("Part", workspace)
    part1.Anchored = true; part2.Anchored = true
    part1.Transparency = 1; part2.Transparency = 1
    part1.Size = Vector3.new(0, 0, 0); part2.Size = Vector3.new(0, 0, 0)
    part1.CanCollide = false; part2.CanCollide = false
    part1.Position = origin; part2.Position = to
    local attachment1, attachment2 = Instance.new("Attachment", part1), Instance.new("Attachment", part2)
    -----
    local beam = Instance.new("Beam", workspace)
    beam.TextureMode = "Static"
    beam.Texture = texture
    beam.Color = color
    beam.Width0 = widthx
    beam.Width1 = widthy
    beam.Attachment0 = attachment1
    beam.Attachment1 = attachment2
    beam.FaceCamera = true
    beam.TextureSpeed = 2
    task.spawn(function()
        if timed then
            delay(duration, function()
                part1:Destroy()
                part2:Destroy()
                beam:Remove()
            end)
        end
    end)
    return beam
end
local checkVisibility   
do
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local agent = nil
    local root = nil

    local characters = {}

    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    local function updateFilter()
        local filter = {}
        for character in characters do
            table.insert(filter, character)
        end
        rayParams.FilterDescendantsInstances = filter
    end

    local function addCharacter(character)
        characters[character] = true
        updateFilter()
    end

    local function removeCharacter(character)
        characters[character] = nil
        updateFilter()
    end

    local function setAgent(character)
        agent = character
        root = character:WaitForChild("Head")
        addCharacter(character)
    end

    local function removeAgent(character)
        agent = nil
        root = nil
        removeCharacter(character)
    end

    local function onPlayer(player)
        player.CharacterAdded:Connect(addCharacter)
        player.CharacterRemoving:Connect(removeCharacter)
        local char = player.Character
        if char then addCharacter(char) end
    end

    for i,v in Players:GetPlayers() do
        if v ~= LocalPlayer then
            onPlayer(v)
        end
    end
    Players.PlayerAdded:Connect(onPlayer)

    LocalPlayer.CharacterAdded:Connect(setAgent)
    LocalPlayer.CharacterRemoving:Connect(removeAgent)
    local char = LocalPlayer.Character
    if char then setAgent(char) end

    checkVisibility = function(position)
        local origin = root.Position
        local displacement = position - origin
        local result = Workspace:Raycast(origin, displacement, rayParams)
        return result == nil
    end
end


function utility:wallcheck(playerCharacter)
    return checkVisibility(playerCharacter.Head.Position)
end


local octoware = {
    ["aiming"] = {
        ["aimbot"] = {
            ["enabled"] = false,
            ["keybind"] = nil,
            ["targetpart"] = "Head",

            ["friendcheck"] = false,
            ["visiblecheck"] = false,
            ["alivecheck"] = false,

            ["showfov"] = false,
            ["fovcolor"] = Color3.fromRGB(255, 255, 255),
            ["fovradius"] = 90,
            ["fovsides"] = 90,

            ["snapline"] = false,
            ["snaplinecolor"] = Color3.fromRGB(255, 255, 255),

            ["smoothing"] = 0,
            ["smoothingstyle"] = Enum.EasingStyle.Linear,
            ["easingdirection"] = Enum.EasingDirection.InOut

        },
        ["silent"] = {
            ["enabled"] = false,
            ["keybind"] = nil,

            ["targetpart"] = "Head",
            ["targetmode"] = "Auto",

            ["friendcheck"] = false,
            ["visiblecheck"] = false,
            ["alivecheck"] = false,

            ['hitchance'] = 100,

            ["showfov"] = false,
            ["fovcolor"] = Color3.fromRGB(255, 255, 255),
            ["fovradius"] = 90,
            ["fovsides"] = 90,

            ["snapline"] = false,
            ["snaplinecolor"] = Color3.fromRGB(255, 255, 255),

            ["wallbang"] = false,

            ["triggerbot"] = false,
        } 
    },
    ["visuals"] = {
        ["world"] = {
            ["changeambient"] = false,
            ["ambient"] = Color3.fromRGB(255, 255, 255),

            ["changefogcolor"] = false,
            ["fogcolor"] = Color3.fromRGB(255, 255, 255),

            ["nofog"] = false,

            ["changefov"] = false,
            ["fov"] = 70,
        }
    }
}

local esplibrary = loadstring(game:HttpGet("https://pastebin.com/raw/KxGEFQ6e"))()

local Pots = {}
local Camera = game:GetService("Workspace").CurrentCamera

for i,v in next, workspace.FrameworkApartments:GetChildren() do
    if v:IsA("Model") then
        table.insert(Pots,v.Pots)
    end
end



local PotEspToggle = false

local function ESPPot(Pot)
    local PotText = Drawing.new("Text")
    PotText.Color = Color3.fromRGB(1,1,1)
    PotText.Size = esplibrary.textsize
    PotText.Center = true
    PotText.Outline = true
    PotText.Visible = false
    PotText.Text = ""
    PotText.Font = esplibrary.textfont

    game:GetService("RunService").RenderStepped:Connect(function()
        PotText.Size = esplibrary.textsize
        PotText.Font = esplibrary.textfont
        local Vector, onScreen = Camera:WorldToViewportPoint(Pot.WorldPivot.Position)
        local FlowerData = {
            ['Type'] = "";
            ['Color'] = Color3. fromRGB(1,1,1);
        }
        local PromptText;

        if Pot:FindFirstChild("Soil") then
            PromptText = Pot.Soil.ProximityPrompt.ActionText
        else
            PromptText = ""
        end

        if PromptText == "HARVEST THE PURPLE SLUM FLOWER" then
            FlowerData.Type = "Purple Slum Flower"
            FlowerData.Color = Color3.fromRGB(171, 87, 219)
        elseif PromptText == "HARVEST THE PINK SLUM FLOWER" then
            FlowerData.Type = "Pink Slum Flower"
            FlowerData.Color = Color3.fromRGB(255, 143, 216)
        elseif PromptText == "HARVEST THE ORANGE SLUM FLOWER" then
            FlowerData.Type = "Orange Slum Flower"
            FlowerData.Color = Color3.fromRGB(255, 144, 41)
        elseif PromptText == "HARVEST THE GHOST SLUM FLOWER" then
            FlowerData.Type = "Ghost Slum Flower"
            FlowerData.Color = Color3.fromRGB(143, 236, 255)
        end
        
        if PotEspToggle then
            if onScreen and esplibrary.enabled then
                PotText.Visible = true
                PotText.Text = FlowerData.Type
                PotText.Position = Vector2.new(Vector.X,Vector.Y)
                PotText.Color = FlowerData.Color
                else
                PotText.Visible = false
            end
            else
            PotText.Visible = false
        end
    end)
end


for i,v in next, Pots do
    for x,Pot in next, v:GetChildren() do
        ESPPot(Pot)
    end
end

for i,v in next, Pots do
    v.ChildAdded:Connect(function(Child)
        ESPPot(Child)
    end)
end

for i,v in next, workspace.FrameworkPots:GetChildren() do
    if v:IsA("Model") then
        ESPPot(v)
    end
end

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet('https://pastebin.com/raw/sJGspAAR'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()


local Window = Library:CreateWindow({

    Title = 'Weed Hub', -- cheat name
    Center = true,
    AutoShow = true,
    TabPadding = 0,
    MenuFadeTime = 0.2 -- animation length when the ui is closed.
})


local gmt = getrawmetatable(game)
setreadonly(gmt,false)

local oldindex = gmt.__index

gmt.__index = newcclosure(function(self,index)
    if tostring(self) == "Head" and index == "Size" then
        return Vector3.new(2,1,1)
    elseif tostring(self) == "Humanoid" and index == "WalkSpeed" then
        return 10
    elseif index == "CanCollide" and not checkcaller() then
        return true
    end
    return oldindex(self,index)
end)

setreadonly(gmt,true)


getgenv().Settings = {
    WalkSpeedEnabled = false,
    InfiniteStamina = false,
    InfiniteEnergy = false,
    InfiniteAmmo = false,
    JamaicanBoxAutoFarm = false,
    HitPart = "Head",
    SilentAimToggled = false,
    PackAutoFarm = false
}

Profile = tostring(game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name].SelectedProfile.Value)
local StaminaPath,MaxStaminaPath = game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Statistics.Stamina, game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Statistics.MaxStamina
local EnergyPath,MaxEnergyPath = game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Statistics.Energy, game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Statistics.MaxEnergy
local LightAmmoPath,MediumAmmoPath,HeavyAmmoPath = game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.LightAmmo, game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.MediumAmmo, game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.HeavyAmmo
local PhoneCrack = game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.PhoneCrack
PhoneCrack.Value = false

local IndexHook;IndexHook = hookmetamethod(game,"__index",newcclosure(function(self,index)
    if self == StaminaPath and index == "Value" and getgenv().Settings.InfiniteStamina then
        return 999999999999999999
    elseif self == MaxStaminaPath and index == "Value" and getgenv().Settings.InfiniteStamina then
        return 999999999999999999
    elseif self == MaxEnergyPath and index == "Value" and getgenv().Settings.InfiniteEnergy then
        return 999999999999999999
    elseif self == EnergyPath and index == "Value" and getgenv().Settings.InfiniteEnergy then
        return 999999999999999999
    elseif self == LightAmmoPath and index == "Value" and getgenv().Settings.InfiniteAmmo then
        return 999999999999999999
    elseif self == MediumAmmoPath and index == "Value" and getgenv().Settings.InfiniteAmmo then
        return 999999999999999999
    elseif self == HeavyAmmoPath and index == "Value" and getgenv().Settings.InfiniteAmmo then
        return 999999999999999999
    elseif self == PhoneCrack and index == "Value" then
        return false
    end
    return IndexHook(self,index)
end))


local Tabs = { -- these are your tabs
    Main = Window:AddTab('Main');
    Aiming = Window:AddTab('Aiming');
    Visuals = Window:AddTab('Visuals');
    ['UI Settings'] = Window:AddTab('UI Settings');
}



getgenv().PlayerBox = Tabs.Main:AddRightGroupbox('Player')

local BuyItemTab = Tabs.Main:AddLeftGroupbox('Items')

local MiscTab = Tabs.Main:AddLeftGroupbox('Misc')

getgenv().TeleportBox = Tabs.Main:AddRightGroupbox('Teleports')


TeleportBox:AddDivider()

TeleportBox:AddDropdown('DrugTP', {
    Values = {"Isaac","Susan","Robby"},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Teleport To Drug NPC",

    Callback = function(v)
        if v=="Susan"then
            for _,o in next, workspace.FrameworkFlowerSelling.FlowerSelling:GetChildren() do
                if o:FindFirstChild('Susan') then
                    Susan = o:FindFirstChild('Susan')
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Susan.WorldPivot + Vector3.new(0,5,0)
                    break
                end
            end
        elseif v=="Robby" then
            for _,o in next, workspace.FrameworkFlowerSelling.FlowerSelling:GetChildren() do
                if o:FindFirstChild('Robby') then
                    Susan = o:FindFirstChild('Robby')
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Susan.WorldPivot + Vector3.new(0,5,0)
                    break
                end
            end
        elseif v == "Isaac" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkFlowerSelling.Issac.WorldPivot + Vector3.new(0,5,0)
        end
    end
})

local Facilities = {"Gold Shop","Barber","Banks Burgers","Monderella","Deli","Library","Lab","Hot Dog Stand","Gym","Laundromat",'Coke Factory','Cooking Pots'}
table.sort(Facilities,function(a,b) return a<b end)

TeleportBox:AddDropdown('FacTP', {
    Values = Facilities,
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Teleport To Facility",

    Callback = function(v)
        if v == "Gold Shop" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-78.1158218383789, 2563.1123046875, 944.74365234375)
        elseif v== "Barber"then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1217.6531982421875, 2557.93896484375, 981.182861328125)
        elseif v== "Monderella"then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(428.89581298828125, 2563.31005859375, 1275.4918212890625)
        elseif v == "Deli" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-70.2744369506836, 2562.807861328125, 719.9676513671875)
        elseif v == "Library" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(53.477169036865234, 2562.908203125, 1960.6444091796875)
        elseif v == "Lab" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(564, 2563, 1957)
        elseif v == "Hot Dog Stand" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(295.57403564453125, 2562.7646484375, 1996.2435302734375)
        elseif v == "Gym" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-37.920719146728516, 2563.05029296875, 442.32647705078125)
        elseif v == "Banks Burgers" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(794.2547607421875, 2562.93701171875, 311.8097229003906)
        elseif v== "Laundromat" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(402.6617126464844, 2562.892822265625, 1503.2645263671875)
        elseif v== "Coke Factory" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1227, 2529, 1987)
        elseif v == "Cooking Pots" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(131, 2540, 1004)
        end
    end
})

--//
local ATMS = {}
if workspace:FindFirstChild("FrameworkFlowerSelling") then
    for i,Atm in next, workspace.FrameworkATMs:GetChildren() do
        Atm.Name = Atm.Name..tostring(i)
        table.insert(ATMS,Atm.Name)
    end
end

table.sort(ATMS,function(a,b)
    return a<b
end)
--//


TeleportBox:AddDropdown('ATMTP', {
    Values = ATMS,
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Teleport To ATM",

    Callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkATMs[v].WorldPivot + Vector3.new(0,5,0)
    end
})


local Logs = {}
if workspace:FindFirstChild("FrameworkMushroomLogs") then
    for i,Log in next, workspace.FrameworkMushroomLogs:GetChildren() do
        if Log:IsA("Model") then
            Log.Name = Log.Name..tostring(" "..i)
            table.insert(Logs,Log.Name)
        end
    end
end

table.sort(Logs,function(a,b)
    return a<b
end)

Logs[1] = "Log 1"
workspace.FrameworkMushroomLogs['Log 10'].Name = "Log 1"

TeleportBox:AddDropdown('LogTP', {
    Values = Logs,
    Text = 'Teleport To Log',
    Multi = false,
    AllowNull = true,
    Callback = function(v)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkMushroomLogs[v].WorldPivot + Vector3.new(0,5,0)
    end
})

TeleportBox:AddDropdown('PlayerTP', {
    SpecialType = 'Player',
    Text = 'Teleport To Player',
    Multi = false,
    AllowNull = true,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Value].Character.HumanoidRootPart.CFrame
    end
})

TeleportBox:AddButton('Sit In Car', function() 
    workspace.Vehicles[tostring(game.Players.LocalPlayer)].DriveSeat:Sit(game.Players.LocalPlayer.Character.Humanoid)
end)

local DimitriImportrs = {}
local ArmoryTable = {}
local DeliTable = {}
for i,v in next, game:GetService("ReplicatedStorage").StoreMenus["DV Imports"]:GetDescendants() do
    if tostring(v.Parent) ~= "DV Imports" then
        table.insert(DimitriImportrs,tostring(v))
    end
end

table.sort(DimitriImportrs,function(a,b) return a<b end)

for i,v in next, game:GetService("ReplicatedStorage").StoreMenus["The Armory"]:GetDescendants() do
    if tostring(v.Parent) ~= "The Armory" then
        table.insert(ArmoryTable,tostring(v))
    end
end

table.sort(ArmoryTable,function(a,b) return a<b end)

for i,v in next, game:GetService("ReplicatedStorage").StoreMenus.Deli:GetDescendants() do
    if tostring(v.Parent) ~= "Deli" then
        table.insert(DeliTable,tostring(v))
    end
end
table.sort(DeliTable,function(a,b) return a<b end)


BuyItemTab:AddDropdown('BuyDimitri', {
    Values = DimitriImportrs,
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Buy Item From DV Imports",

    Callback = function(v)
        ItemToBuy = game:GetService("ReplicatedStorage").StoreMenus["DV Imports"]:FindFirstChild(v,true)
        game:GetService("ReplicatedStorage").RemoteEvents.StorePurchase:InvokeServer(ItemToBuy)
    end
})

BuyItemTab:AddDropdown('BuyDeli', {
    Values = DeliTable,
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Buy Item From Deli",

    Callback = function(v)
        ItemToBuy = game:GetService("ReplicatedStorage").StoreMenus["Deli"]:FindFirstChild(v,true)
        game:GetService("ReplicatedStorage").RemoteEvents.StorePurchase:InvokeServer(ItemToBuy)
    end
})

BuyItemTab:AddDropdown('SellPack', {
    Values = {"Susan","Robby"},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Sell Pack To Junkie",

    Callback = function(v)
        game:GetService("ReplicatedStorage").RemoteEvents.SellPack:FireServer(v)
    end
})

BuyItemTab:AddDropdown('Pickupitem', {
    Values = {},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Pick Up Dropped Item",

    Callback = function(v)
        local OldCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        task.wait(0.01)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkDroppedTools[v].DropPosition.CFrame + Vector3.new(0,5,0)
        task.wait(.25)
        fireproximityprompt(workspace.FrameworkDroppedTools[v].DropPosition.ProximityPrompt)
        task.wait(.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldCFrame
    end
})


function UpdatedDroppedItems()
    Items = {}
    for _,v in next, workspace.FrameworkDroppedTools:GetChildren() do
        table.insert(Items,tostring(v))
    end
    table.sort(Items,function(a,b) return a<b end)
    Options.Pickupitem:SetValues(Items)
end 
UpdatedDroppedItems()
workspace.FrameworkDroppedTools.ChildAdded:Connect(UpdatedDroppedItems)
workspace.FrameworkDroppedTools.ChildRemoved:Connect(UpdatedDroppedItems)

MiscTab:AddDropdown('TakeStashItem', {
    Values = {},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Take Item From Stash",

    Callback = function(v)
        local ohInstance1 = game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.Stash[v]
        local ohString2 = "Take"
    
        game:GetService("ReplicatedStorage").RemoteEvents.StashItem:FireServer(ohInstance1, ohString2)
    end
})

MiscTab:AddDropdown('StashItem', {
    Values = {},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = "Stash Item",

    Callback = function(v)
        local ohInstance1 = LocalPlayer.Backpack[v]
        local ohString2 = "Stash"
    
        game:GetService("ReplicatedStorage").RemoteEvents.StashItem:FireServer(ohInstance1, ohString2)
    end
})
MiscTab:AddDivider()
MiscTab:AddToggle('Box Auto Farm', {
    Text = 'Box Auto Farm',
    Default = false,

    Callback = function(v)
        getgenv().Settings.JamaicanBoxAutoFarm = v
        while getgenv().Settings.JamaicanBoxAutoFarm do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0 then
                workspace.FrameworkWarehouseWorker.Pallet.Node.ProximityPrompt.HoldDuration = 0
                workspace.FrameworkWarehouseWorker.Box.Node.ProximityPrompt.HoldDuration = 0
                tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut,0,false,0)
                properties = {CFrame = CFrame.new(937.25732421875, 2564.085205078125, 153.64414978027344)}
                tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,tweenInfo,properties)
                tween:Play()
                task.wait(1.75)
                fireproximityprompt(workspace.FrameworkWarehouseWorker.Box.Node.ProximityPrompt)
                task.wait(2)
                tweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut,0,false,0)
                properties = {CFrame = CFrame.new(965.494384765625, 2563.1064453125, 124.77774810791016)}
                tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart,tweenInfo,properties)
                tween:Play()
                task.wait(3)
                fireproximityprompt(workspace.FrameworkWarehouseWorker.Pallet.Node.ProximityPrompt)
                task.wait(2)
            end
            task.wait()
        end
    end
})

local SellableItems = {
    'Pink Slum Flower Pack',
    'Purple Slum Flower Pack',
    'Orange Slum Flower Pack',
    'Ghost Slum Flower Pack',
    'Pink Baby Magic',
    'Purple Baby Magic',
    'Orange Baby Magic',
    'Ghost Baby Magic',
    'Purple Rummy Gummy Pack',
    'Orange Rummy Gummy Pack',
    'Ghost Rummy Gummy Pack'
}

MiscTab:AddToggle('Pack Auto Farm', {
    Text = 'Pack Auto Farm',
    Default = false,

    Callback = function(v)
        getgenv().Settings.PackAutoFarm = v
        while getgenv().Settings.PackAutoFarm do task.wait()
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health ~= 0  and game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Statistics.Cash.Value > 120 then
            repeat wait() until workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true) or workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Robby",true)
            repeat wait() until workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true).Node.ProximityPrompt.Enabled == true or workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Robby",true).Node.ProximityPrompt.Enabled == true
            if getgenv().Settings.PackAutoFarm then

                if workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Robby",true) and workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true).Node.ProximityPrompt.Enabled == true then
                    game:GetService("ReplicatedStorage").RemoteEvents.StorePurchase:InvokeServer(game:GetService("ReplicatedStorage").StoreMenus["DV Imports"].Misc["Pink Slum Flower Pack"])
                    
                    wait(0.25)
                    Pack = game.Players.LocalPlayer.Backpack:FindFirstChild("Pink Slum Flower Pack")
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(Pack)
                    wait(0.25)
                    
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Robby",true).WorldPivot+Vector3.new(0,5,0)
                    task.wait(0.15)
                    fireproximityprompt(workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Robby",true).Node.ProximityPrompt)
                    task.wait(2)
                    
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(117.56079864501953, 2572.6015625, 1908.165283203125)
                    task.wait()
                end

                if workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true) and workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true).Node.ProximityPrompt.Enabled == true then
                    game:GetService("ReplicatedStorage").RemoteEvents.StorePurchase:InvokeServer(game:GetService("ReplicatedStorage").StoreMenus["DV Imports"].Misc["Pink Slum Flower Pack"])
                    
                    wait(0.25)
                    Pack = game.Players.LocalPlayer.Backpack:FindFirstChild("Pink Slum Flower Pack")
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(Pack)
                    wait(0.25)
                    
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true).WorldPivot+Vector3.new(0,5,0)
                    task.wait(0.15)
                    fireproximityprompt(workspace.FrameworkFlowerSelling.FlowerSelling:FindFirstChild("Susan",true).Node.ProximityPrompt)
                    task.wait(2)
                    
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(117.56079864501953, 2572.6015625, 1908.165283203125)
                    task.wait()
                end

            end
            end
        end
    end
})

local LibraryAutoFarm = false;
MiscTab:AddToggle('Library Auto Farm', {
    Text = 'Library Auto Farm',
    Default = false,

    Callback = function(v)
        LibraryAutoFarm = v
        while LibraryAutoFarm do task.wait(3.5)
            game:GetService("ReplicatedStorage").RemoteEvents.LibrarySubmit:InvokeServer()
        end
    end
})


local StashItems = {}
function UpdateStashDropDowns()
    table.clear(StashItems)
    for i,v in next, game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.Stash:GetChildren() do
        table.insert(StashItems,tostring(v))
    end
    table.sort(StashItems,function(a,b) return a<b end)
    Options.TakeStashItem:SetValues(StashItems)
end
local bagpack = {}
UpdateStashDropDowns()
function ReturnBackpack()
    table.clear(bagpack)
    for i,v in next, game.Players.LocalPlayer:WaitForChild("Backpack"):GetChildren() do
        if tostring(v) ~= "Fists" then
            table.insert(bagpack,tostring(v))
        end
    end
    table.sort(bagpack,function(a,b) return a<b end)
    Options.StashItem:SetValues(bagpack)
end
ReturnBackpack()
LocalPlayer.Backpack.ChildAdded:Connect(ReturnBackpack)
LocalPlayer.Backpack.ChildRemoved:Connect(ReturnBackpack)
LocalPlayer.CharacterAdded:Connect(function()
    LocalPlayer.Backpack.ChildAdded:Connect(ReturnBackpack)
    LocalPlayer.Backpack.ChildRemoved:Connect(ReturnBackpack)
    ReturnBackpack()
end)

game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.Stash.ChildAdded:Connect(UpdateStashDropDowns)
game:GetService("ReplicatedStorage").PlayerData[game.Players.LocalPlayer.Name][Profile].Inventory.Stash.ChildRemoved:Connect(UpdateStashDropDowns)


PlayerBox:AddToggle('energy', {
    Text = 'Infinite Energy',
    Default = false,

    Callback = function(v)
        getgenv().Settings.InfiniteEnergy = v
    end
})

PlayerBox:AddToggle('stamina', {
    Text = 'Infinite Stamina',
    Default = false,

    Callback = function(v)
        getgenv().Settings.InfiniteStamina = v
    end
})

PlayerBox:AddToggle('ammo', {
    Text = 'Infinite Ammo',
    Default = false,

    Callback = function(v)
        getgenv().Settings.InfiniteAmmo = v
    end
})


local SpeedBox = PlayerBox:AddToggle('speed', {
    Text = 'Walk Speed',
    Default = false,

    Callback = function(v)
        getgenv().Settings.WalkSpeedEnabled = v
        Loop = v
        while Loop do task.wait()
            if getgenv().Settings.WalkSpeedEnabled then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 75
            else
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 10
            end
        end
    end
})SpeedBox:AddKeyPicker('SpeedPicker', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = ']', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = true,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = 'Walk Speed', -- Text to display in the keybind menu
    NoUI = false -- Set to true if you want to hide from the Keybind menu,
})

local clip = true
PlayerBox:AddToggle('noclip', {
    Text = 'No Clip',
    Default = false,

    Callback = function(toggle)
        if toggle == true then
            clip = false
        else
            clip = true
        end
    end
})

local HBSize,BigHeadToggle = 7
PlayerBox:AddToggle('BigHeads', {
    Text = 'Big Heads',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        BigHeadToggle = Value
            task.spawn(function()
            while BigHeadToggle do task.wait(.25)
            pcall(function()
                for i,v in next, game.Players:GetPlayers() do
                    if v~=game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                        Head = v.Character.Head
                        if BigHeadToggle then
                        Head.Size = Vector3.new(HBSize,HBSize,HBSize)
                        Head.Transparency = 0.75
                        Head.Massless = true
                        Head.CanCollide = false
                        else
                        Head.Size =Vector3.new(2,1,1)
                        Head.Transparency = 0
                        Head.Massless = true
                        Head.CanCollide = false
                        end
                    end
                end
            end)
            end
        end)
    end
})

PlayerBox:AddSlider('size', {
    Text = 'Head Size',
    Default = 7,
    Min = 2,
    Max = 15,
    Rounding = 1,
    Compact = true,

    Callback = function(Value)
        HBSize = Value
    end
})


function NoClip()
    if clip == false and game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

task.spawn(function()
    while true do task.wait(.25)
        if game.Players.LocalPlayer.Character then
            NoClip()
        end
    end
end)


-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
local AimbotBox = Tabs.Aiming:AddLeftGroupbox('Aimbot') -- these are your groupboxes better known as "sections"
local SilentBox = Tabs.Aiming:AddRightGroupbox('Silent') 




SilentBox:AddToggle('SilentEnabled', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.enabled = v
    end
})


SilentBox:AddLabel('Keybind'):AddKeyPicker('SilentBind', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'nil', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = '', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function()

    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        octoware.aiming.silent.keybind = New
    end
})

SilentBox:AddDropdown('SilentPart', {
    Values = { 'Head','HumanoidRootPart' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Target Part',

    Callback = function(v)
        octoware.aiming.silent.targetpart = v
    end
})

local silentclosest
SilentBox:AddDropdown('TargetMode', {
    Values = { 'Auto','Target' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Targetting Mode',

    Callback = function(v)
        silentclosest = nil
        octoware.aiming.silent.targetmode = v
    end
})


SilentBox:AddToggle('SilentFriend', {
    Text = 'Friend Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.friendcheck = v
    end
})


SilentBox:AddToggle('SilentVis', {
    Text = 'Visible Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.visiblecheck = v
    end
})


SilentBox:AddToggle('SilentAlive', {
    Text = 'Alive Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.alivecheck = v
    end
})


SilentBox:AddSlider('SilentHitChance', {
    Text = 'Hit Chance',
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Compact = true,

    Callback = function(v)
        octoware.aiming.silent.hitchance = v
    end
})






local silentfovbox = Tabs.Aiming:AddRightGroupbox('Silent FOV') -- these are your groupboxes better known as "sections"


silentfovbox:AddToggle('silentdrawfov', {
    Text = 'Show FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.showfov = v
    end
}):AddColorPicker('silentFOVCOLOR', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.aiming.silent.fovcolor = v
    end
})

silentfovbox:AddSlider('silentfovradius', {
    Text = 'Radius',
    Default = 100,
    Min = 0,
    Max = 800,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        octoware.aiming.silent.fovradius = v
    end
})

silentfovbox:AddSlider('silentfovsides', {
    Text = 'Sides',
    Default = 100,
    Min = 3,
    Max = 100,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        octoware.aiming.silent.fovsides = v
    end
})

local silentsnaplinebox = Tabs.Aiming:AddRightGroupbox('Silent Snapline') -- these are your groupboxes better known as "sections"

silentsnaplinebox:AddToggle('silentsilentsilentsilent', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.silent.snapline = v
    end
}):AddColorPicker('FakeSnapline', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Snapline Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.aiming.silent.snaplinecolor = v
    end
})


local silentwlbox = Tabs.Aiming:AddRightGroupbox('Silent Whitelist') -- these are your groupboxes better known as "sections"
local cachewl = {}
local silentwhitelisted = {}
silentwlbox:AddDropdown('silentwl', {
    SpecialType = 'Player',
    Text = 'Select Player',
    Multi = true,
    Callback = function(Value)
        table.clear(cachewl)
        table.clear(silentwhitelisted)
        table.insert(cachewl,Value) 
        for i,v in next, cachewl do   
            for k,p in next, v do
                table.insert(silentwhitelisted,k)
            end
        end  
    end
})





















AimbotBox:AddToggle('AimbotEnabled', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.enabled = v
    end
})


AimbotBox:AddLabel('Keybind'):AddKeyPicker('AimbotBind', {
    -- SyncToggleState only works with toggles.
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

    Default = 'nil', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    SyncToggleState = false,


    -- You can define custom Modes but I have never had a use for it.
    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

    Text = '', -- Text to display in the keybind menu
    NoUI = false, -- Set to true if you want to hide from the Keybind menu,

    -- Occurs when the keybind is clicked, Value is `true`/`false`
    Callback = function()

    end,

    -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
    ChangedCallback = function(New)
        octoware.aiming.aimbot.keybind = New
    end
})

AimbotBox:AddDropdown('AimPart', {
    Values = { 'Head','HumanoidRootPart' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Target Part',

    Callback = function(v)
        octoware.aiming.aimbot.targetpart = v
    end
})


AimbotBox:AddToggle('AimbotFriend', {
    Text = 'Friend Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.friendcheck = v
    end
})


AimbotBox:AddToggle('AimbotVisible', {
    Text = 'Visible Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.visiblecheck = v
    end
})


AimbotBox:AddToggle('AimbotAlive', {
    Text = 'Alive Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.alivecheck = v
    end
})



local AimbotFoxBox = Tabs.Aiming:AddLeftGroupbox('Aimbot FOV') -- these are your groupboxes better known as "sections"


AimbotFoxBox:AddToggle('aimbotdrawfov', {
    Text = 'Show FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.showfov = v
    end
}):AddColorPicker('AimbotFOVCOLOR', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.aiming.aimbot.fovcolor = v
    end
})

AimbotFoxBox:AddSlider('aimbotfovradius', {
    Text = 'Radius',
    Default = 100,
    Min = 0,
    Max = 800,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        octoware.aiming.aimbot.fovradius = v
    end
})

AimbotFoxBox:AddSlider('aimbotfovsides', {
    Text = 'Sides',
    Default = 100,
    Min = 3,
    Max = 100,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        octoware.aiming.aimbot.fovsides = v
    end
})

local AimbotSnapLineBox = Tabs.Aiming:AddLeftGroupbox('Aimbot Snapline') -- these are your groupboxes better known as "sections"

AimbotSnapLineBox:AddToggle('fuckkkkkkoff', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.aiming.aimbot.snapline = v
    end
}):AddColorPicker('FakeSnapline', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Snapline Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.aiming.aimbot.snaplinecolor = v
    end
})

local AimbotSmoothingBox = Tabs.Aiming:AddLeftGroupbox('Smoothing') -- these are your groupboxes better known as "sections"

AimbotSmoothingBox:AddSlider('smoothingslider', {
    Text = 'Smoothing',
    Default = 0,
    Min = 0,
    Max = 2,
    Rounding = 2,
    Compact = false,

    Callback = function(v)
        octoware.aiming.aimbot.smoothing = v
    end
})

AimbotSmoothingBox:AddDropdown('Easing Style', {
    Values = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Style',

    Callback = function(v)
        octoware.aiming.aimbot.smoothingstyle = v
    end
})

AimbotSmoothingBox:AddDropdown('Easing Direction', {
    Values = {"InOut", "In", "Out"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Direction',

    Callback = function(v)
        octoware.aiming.aimbot.easingdirection = v
    end
})


local ESPBox = Tabs.Visuals:AddLeftGroupbox('ESP') -- these are your groupboxes better known as "sections"

ESPBox:AddToggle('ESPEnabled', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.enabled = v
    end
})

ESPBox:AddToggle('EspBoxes', {
    Text = 'Boxes',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.boxes.enabled = v
    end
})

ESPBox:AddToggle('HealthBars', {
    Text = 'Healthbars',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.healthbars.enabled = v
    end
})

ESPBox:AddToggle('healthtext', {
    Text = 'Health text',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.healthtext.enabled = v
    end
})

ESPBox:AddToggle('names', {
    Text = 'Names',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.names.enabled = v
    end
})

ESPBox:AddToggle('distance', {
    Text = 'Distance',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.distance.enabled = v
    end
})

ESPBox:AddToggle('weapon', {
    Text = 'Weapon',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.weapon.enabled = v
    end
})

ESPBox:AddDivider()

ESPBox:AddToggle('Plants', {
    Text = 'Plants',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        PotEspToggle = v
    end
})



local EspSettings = Tabs.Visuals:AddLeftGroupbox('ESP Settings') -- these are your groupboxes better known as "sections"

EspSettings:AddDropdown('Type', {
    Values = {"Bounding","3D"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Style',

    Callback = function(v)
        esplibrary.boxes['type'] = v
    end
})

EspSettings:AddToggle('Namedisplay', {
    Text = 'Name Uses DisplayName',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        esplibrary.names.displaynames = v
    end
})

EspSettings:AddDropdown('Measuremtn', {
    Values = {"Meters","Studs"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Distance Measurement',

    Callback = function(v)
        if v == "Meters" then
            esplibrary.distance_measurement = "m"
            esplibrary.distance_format = 0.4
        else
            esplibrary.distance_measurement = "s"
            esplibrary.distance_format = 1
        end
    end
})

EspSettings:AddDropdown('FontEsp', {
    Values = {"1","2","3"},
    Default = 2, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Font',

    Callback = function(v)
        esplibrary.textfont = tonumber(v)
    end
})


EspSettings:AddSlider('textsiize', {
    Text = 'Text Size',
    Default = 12,
    Min = 0,
    Max = 16,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        esplibrary.textsize = v
    end
})

EspSettings:AddSlider('MaxDis', {
    Text = 'Max Distance',
    Default = 3000,
    Min = 0,
    Max = 6000,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        esplibrary.maxdistance = v
    end
})


local EspColors = Tabs.Visuals:AddRightGroupbox('ESP Colors') -- these are your groupboxes better known as "sections"

EspColors:AddLabel('Box'):AddColorPicker('BoxColor', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Box color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        esplibrary.boxes.color = v
    end
})

EspColors:AddLabel('Name'):AddColorPicker('NameColor', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Name color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        esplibrary.names.color = v
    end
})

EspColors:AddLabel('Distance'):AddColorPicker('DistanceColor', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Distance color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        esplibrary.distance.color = v
    end
})

EspColors:AddLabel('Weapon'):AddColorPicker('WeaponColor', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Weapon color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        esplibrary.weapon.color = v
    end
})

local WorldColors = Tabs.Visuals:AddRightGroupbox('World') -- these are your groupboxes better known as "sections"

WorldColors:AddToggle('AmbientColor', {
    Text = 'Ambient Color',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.visuals.world.changeambient = v
    end
})

WorldColors:AddLabel('Color'):AddColorPicker('AmbientClr', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.visuals.world.ambient = v
    end
})

WorldColors:AddToggle('FogColor', {
    Text = 'Fog Color',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.visuals.world.changefogcolor = v
    end
})

WorldColors:AddLabel('Color'):AddColorPicker('FogClr', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        octoware.visuals.world.fogcolor = v
    end
})

WorldColors:AddToggle('FOVtoggle', {
    Text = 'FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        octoware.visuals.world.changefov = v
    end
})

WorldColors:AddSlider('fovval', {
    Text = 'Value',
    Default = 70,
    Min = 0,
    Max = 120,
    Rounding = 0,
    Compact = false,

    Callback = function(v)
        octoware.visuals.world.fov = v
    end
})

-- you can remove things you dont want


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('octoware')
ThemeManager:ApplyToTab(Tabs['UI Settings']) -- if you gonna change UI Settings in the tabs you need to replace this as well for themes

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('octoware/games/'..game.PlaceId)
SaveManager:BuildConfigSection(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()




function utility:getclosestplayertomouse(fovradius, friendcheck, alivecheck, vischeck,silentwlcheck, hitchance)
    local curdistance, plr = fovradius
    local targetpart = octoware.aiming.aimbot.targetpart
    for _, player in pairs(getplayers(game.Players)) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local targetpart = findfirstchild(player.Character, targetpart)
            if targetpart then
                local wts, onscreen = wtsp(camera, targetpart.Position)
             if onscreen then
                local distance = (Vector2.new(wts.X, wts.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if distance < curdistance then
                        if friendcheck then if isfriendswith(localplayer, player.UserId) then continue end end
                        if alivecheck then if findfirstchildofclass(player.Character, "Humanoid").Health <= 0 then continue end end
                        if vischeck and not utility:wallcheck(player.Character) then continue end
                        if silentwlcheck then if table.find(silentwhitelisted,tostring(player)) then continue end end 
                        if hitchance then if math.random(0,100) > octoware.aiming.silent.hitchance + 1 then continue end end
                        curdistance = distance
                        plr = player 
                    end
                end
            end
        end
    end
    return plr
end
function utility:calcdistance(org, pos)
    return (pos - org).Unit * 1000
end
function utility:getwallbangabletable(player)
    local tbl = {}
    if player.Character then
        for _, part in pairs(getdescendants(player.Character)) do
            if isa(part, "Part") or isa(part, "BasePart") or isa(part, "MeshPart") then
                table.insert(tbl, part)
            end
        end
    end
    return tbl
end
local aimbotfov = utility:draw("Circle", {Visible = false, Color = Color3.new(1, 1, 1), Radius = 100, NumSides = 100, ZIndex = 2, Thickness = 2})
local aimbotfovoutline = utility:draw("Circle", {Visible = false, Color = Color3.new(0, 0, 0), Radius = 100, NumSides = 100, Thickness = 3})

local aimbotsnapline = utility:draw("Line", {Visible = false, Color = Color3.new(1, 1, 1), ZIndex = 2})
local aimbotsnaplineoutline = utility:draw("Line", {Visible = false, Color = Color3.new(0, 0, 0), Thickness = 3})

local silentfov = utility:draw("Circle", {Visible = false, Color = Color3.new(1, 1, 1), Radius = 100, NumSides = 100, ZIndex = 2, Thickness = 2})
local silentfovoutline = utility:draw("Circle", {Visible = false, Color = Color3.new(0, 0, 0), Radius = 100, NumSides = 100, Thickness = 3})

local silentsnapline = utility:draw("Line", {Visible = false, Color = Color3.new(1, 1, 1), ZIndex = 2})
local silentsnaplineoutline = utility:draw("Line", {Visible = false, Color = Color3.new(0, 0, 0), Thickness = 3})


local aimbotclosest
local holding = false



local aimbottween = nil

function runaimbot(part)
    aimbottween = tweenservice:Create(workspace.CurrentCamera, TweenInfo.new(octoware.aiming.aimbot.smoothing, octoware.aiming.aimbot.smoothingstyle), {CFrame = CFrame.new(camera.CFrame.Position, part.Position)})
    aimbottween:Play()
end
local setfog, setfov = false, false
local defambient = game.Lighting.Ambient
local deffogcolor = game.Lighting.FogColor
local tint = Instance.new("ColorCorrectionEffect", game.Lighting)
runservice.RenderStepped:Connect(function()
    if octoware.visuals.world.changefov then
        setfov = false
        camera.FieldOfView = octoware.visuals.world.fov
    else
        if not setfov then
            setfov = true
            camera.FieldOfView = 70
        end
    end
    if octoware.visuals.world.changeambient then
        
        tint.TintColor = octoware.visuals.world.ambient
    else
        tint.TintColor = Color3.new(1, 1, 1)
    end
    if octoware.visuals.world.changefogcolor then
        setfog = false
        game.Lighting.FogColor = octoware.visuals.world.fogcolor
    else
        if not setfog then
            setfog = true
            game.Lighting.FogColor = deffogcolor
        end
    end
    if not holding then
        aimbotclosest = utility:getclosestplayertomouse(octoware.aiming.aimbot.fovradius, octoware.aiming.aimbot.friendcheck, octoware.aiming.aimbot.alivecheck, octoware.aiming.aimbot.visiblecheck,false,false)
    end
    if octoware.aiming.silent.targetmode == "Auto" then
        silentclosest = utility:getclosestplayertomouse(octoware.aiming.silent.fovradius, octoware.aiming.silent.friendcheck, octoware.aiming.silent.alivecheck, octoware.aiming.silent.visiblecheck,true,true)
    end
    aimbotfov.Visible = octoware.aiming.aimbot.enabled and octoware.aiming.aimbot.showfov
    aimbotfovoutline.Visible = aimbotfov.Visible
    aimbotfov.Radius = octoware.aiming.aimbot.fovradius
    aimbotfovoutline.Radius = octoware.aiming.aimbot.fovradius + 1
    aimbotfov.Color = octoware.aiming.aimbot.fovcolor
    aimbotfov.NumSides = octoware.aiming.aimbot.fovsides
    aimbotfovoutline.NumSides = octoware.aiming.aimbot.fovsides
    local mouselocation = inputservice:GetMouseLocation()
    aimbotfov.Position = Vector2.new(mouselocation.X, mouselocation.Y)
    aimbotfovoutline.Position = aimbotfov.Position

    aimbotsnaplineoutline.Visible = aimbotsnapline.Visible
    aimbotsnapline.Color = octoware.aiming.aimbot.snaplinecolor
    if aimbotclosest and octoware.aiming.aimbot.enabled and octoware.aiming.aimbot.snapline and not holding then
        if aimbotclosest.Character and aimbotclosest.Character:FindFirstChild(octoware.aiming.aimbot.targetpart) then
            local wts, onscreen = camera:WorldToViewportPoint(aimbotclosest.Character:FindFirstChild(octoware.aiming.aimbot.targetpart).Position)
            aimbotsnapline.Visible = onscreen
            aimbotsnapline.From = Vector2.new(mouselocation.X, mouselocation.Y)
            aimbotsnapline.To = Vector2.new(wts.X, wts.Y)
            aimbotsnaplineoutline.From = aimbotsnapline.From
            aimbotsnaplineoutline.To = aimbotsnapline.To
        else
            aimbotsnapline.Visible = false
        end
    else
        aimbotsnapline.Visible = false
    end


    silentfov.Visible = octoware.aiming.silent.enabled and octoware.aiming.silent.showfov
    silentfovoutline.Visible = silentfov.Visible
    silentfov.Radius = octoware.aiming.silent.fovradius
    silentfovoutline.Radius = octoware.aiming.silent.fovradius + 1
    silentfov.Color = octoware.aiming.silent.fovcolor
    silentfov.NumSides = octoware.aiming.silent.fovsides
    silentfovoutline.NumSides = octoware.aiming.silent.fovsides
    local mouselocation = inputservice:GetMouseLocation()
    silentfov.Position = Vector2.new(mouselocation.X, mouselocation.Y)
    silentfovoutline.Position = silentfov.Position

    silentsnaplineoutline.Visible = silentsnapline.Visible
    silentsnapline.Color = octoware.aiming.silent.snaplinecolor
    if silentclosest and octoware.aiming.silent.enabled and octoware.aiming.silent.snapline and not holding then
        if silentclosest.Character and silentclosest.Character:FindFirstChild(octoware.aiming.silent    .targetpart) then
            local wts, onscreen = camera:WorldToViewportPoint(silentclosest.Character:FindFirstChild(octoware.aiming.silent.targetpart).Position)
            silentsnapline.Visible = onscreen
            silentsnapline.From = Vector2.new(mouselocation.X, mouselocation.Y)
            silentsnapline.To = Vector2.new(wts.X, wts.Y)
            silentsnaplineoutline.From = silentsnapline.From
            silentsnaplineoutline.To = silentsnapline.To
        else
            silentsnapline.Visible = false
        end
    else
        silentsnapline.Visible = false
    end
    if silentclosest and not silentclosest.Parent or silentclosest and not silentclosest.Character or not silentclosest then
        silentclosest = nil
    end
    if silentclosest and silentclosest.Character and silentclosest.Character:FindFirstChildOfClass("Humanoid") and silentclosest.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
        silentclosest = nil
    end
    
    if holding then
        local char = aimbotclosest.Character
        if char then
            local targetpart = char:FindFirstChild(octoware.aiming.aimbot.targetpart)
            if targetpart then
                runaimbot(targetpart)
            end 
        end
    else
        if aimbottween then
            aimbottween:Cancel()
            aimbottween = nil
        end
    end


end)
uis.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == octoware.aiming.aimbot.keybind and aimbotclosest and octoware.aiming.aimbot.enabled then
        holding = true
    end
    if not gameProcessedEvent and input.KeyCode == octoware.aiming.silent.keybind then
        if octoware.aiming.silent.targetmode == "Target" then
            if silentclosest then
                silentclosest = nil
            else
                silentclosest = utility:getclosestplayertomouse(octoware.aiming.silent.fovradius, octoware.aiming.silent.friendcheck, octoware.aiming.silent.alivecheck, octoware.aiming.silent.visiblecheck,true,true)
                if silentclosest ~= nil then
                    Library:Notify("WEED HUB | LOCKED ONTO "..tostring(silentclosest):upper(),5)
                end
            end
        end
    end
end)
uis.InputEnded:Connect(function(input)
    if input.KeyCode ==  octoware.aiming.aimbot.keybind then
        holding = false
    end
end)

local old; old = hookmetamethod(workspace, "__namecall", newcclosure(function(...)
    local method = getnamecallmethod()
    if octoware.aiming.silent.enabled and silentclosest and tostring(method) == "Raycast" then
        local args = {...}
        local origin = args[2]
        local targetpart = findfirstchild(silentclosest.Character, octoware.aiming.silent.targetpart)
        if targetpart then
            args[3] = utility:calcdistance(origin, targetpart.Position)
        end
        if octoware.aiming.silent.wallbang then
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Include
            params.IgnoreWater = false
            params.RespectCanCollide = false
            params.FilterDescendantsInstances = utility:getwallbangabletable(silentclosest)
            args[4] = params
        end
        return old(unpack(args))
    end
    return old(...)
end))
