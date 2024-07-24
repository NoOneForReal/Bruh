loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua"))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/liam0999/Drawing2/main/Drawing2.lua'))()

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

local UserInputService = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Holding = false

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

local esplibrary = loadstring(game:HttpGet('https://pastebin.com/raw/KxGEFQ6e'))()


local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet('https://pastebin.com/raw/bUrAUKaL'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()


local Window = Library:CreateWindow({

    Title = 'Weed Hub', -- cheat name
    Center = true,
    AutoShow = true,
    TabPadding = 0,
    MenuFadeTime = 0.2 -- animation length when the ui is closed.
})




local Tabs = { -- these are your tabs
    Main = Window:AddTab('Main');
    Aiming = Window:AddTab('Aiming');
    Visuals = Window:AddTab('Visuals');
    ['UI Settings'] = Window:AddTab('UI Settings');
}

local LocalPlayer = game.Players.LocalPlayer

local LocalPlayerBox = Tabs.Main:AddLeftGroupbox("Player")
local ExtraPlayerBox = Tabs.Main:AddLeftGroupbox("Extra")
local SafeBox = Tabs.Main:AddRightGroupbox("Safe")
local GunModBox = Tabs.Main:AddLeftGroupbox("Gun Mods")
local MiscBox = Tabs.Main:AddRightGroupbox("Vehicle")
local TeleportBox = Tabs.Main:AddRightGroupbox("Teleportation")

local GunModToggles = {
    InfiniteAmmo = false;
    Auto = false;
    Recoil = false;
    Spread = false;
    Rifle = false;
    Whitelist = false;
}

local BypassApt  =  false;

game.Players.LocalPlayer.Character.ChildAdded:Connect(function(AddedChild)
    if AddedChild.Name == "InsideApartments" and BypassApt then
        task.wait()
        AddedChild:Destroy()
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(Char)
    Char.ChildAdded:Connect(function(AddedChild)
        if AddedChild.Name == "InsideApartments" and BypassApt then
            task.wait()
            AddedChild:Destroy()
        end
    end)
end)

local Whitelistedhook;Whitelistedhook = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    if GunModToggles.Whitelist then
        if tostring(self) == "Equipping" then
            return
        end
    end
    return Whitelistedhook(self,...)
end))

local badword;badword = hookmetamethod(workspace,"__index",function(self,index)
    if tostring(self) == "ClipSize" and index == "Value" and GunModToggles.InfiniteAmmo == true then
        return math.huge
    end
    if tostring(self) == "GunType" and index == "Value" and GunModToggles.Auto == true then
        return "Auto"
    end
    if tostring(self) == "FireRate" and index == "Value" and GunModToggles.Auto == true then
        return -1
    end
    if tostring(self) == "Recoil" and index == "Value" and GunModToggles.Recoil == true then
        if tostring(self.Parent) == "Stats" then
            return 0
        end
    end
    return badword(self,index)
end)

game.Players.LocalPlayer.Character.ChildAdded:Connect(function(X)
    if X:IsA("Tool") and X:FindFirstChild("Stats") then
        if GunModToggles.Rifle then
            if X.Stats:FindFirstChild("Rifle") then
                X.Stats.Rifle:Destroy()
            end
        end
        if GunModToggles.Spread then
            require(X.Stats.Local).MaxSpread = 0
            require(X.Stats.Local).MinSpread = 0
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(Char)
    Char.ChildAdded:Connect(function(X)
        if X:IsA("Tool") and X:FindFirstChild("Stats") then
            if GunModToggles.Rifle then
                if X.Stats:FindFirstChild("Rifle") then
                    X.Stats.Rifle:Destroy()
                end
            end
            if GunModToggles.Spread then
                require(X.Stats.Local).MaxSpread = 0
                require(X.Stats.Local).MinSpread = 0
            end
        end
    end)
end)


MiscBox:AddButton('Teleport Car', function() 
    vehicle = workspace[LocalPlayer.Name.."'s Car"]
    vehicle:MoveTo(LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position)
    task.wait(1)
    vehicle.DriveSeat:sit(LocalPlayer.Character:WaitForChild("Humanoid"))
end)

MiscBox:AddButton('Sit In Car', function() 
    vehicle = workspace[LocalPlayer.Name.."'s Car"]
    vehicle.DriveSeat:sit(LocalPlayer.Character:WaitForChild("Humanoid"))
end)


local AutoTP = false;
local PlayerToTp = tostring(LocalPlayer)

TeleportBox:AddToggle('tpptot', {
    Text = 'Teleport To Player On Spawn',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        AutoTP = v
    end
})

TeleportBox:AddDropdown('TpToSpawn', {
    SpecialType = 'Player',
    Text = 'Player To Teleport To',
    Multi = false,

    Callback = function(Value)
        PlayerToTp = Value
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(Char)
    Char:WaitForChild("HumanoidRootPart")
    if AutoTP and game.Players[PlayerToTp] then
        Char.HumanoidRootPart.CFrame = game.Players[PlayerToTp].Character.HumanoidRootPart.CFrame
    end
end)

local ExtraGunMods = Tabs.Main:AddLeftGroupbox('Beta Gun Mods') 

GunModBox:AddToggle('WLBYP', {
    Text = 'Whitelist Bypass',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.Whitelist = v
    end
})


GunModBox:AddToggle('infam', {
    Text = 'Infinite Ammo',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.InfiniteAmmo = v
    end
})

GunModBox:AddToggle('fulauto', {
    Text = 'Automatic Gun',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.Auto = v
    end
})

GunModBox:AddToggle('Recoil', {
    Text = 'No Recoil',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.Recoil = v
    end
})


ExtraGunMods:AddToggle('Spread', {
    Text = 'No Spread',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.Spread = v
        if v == true then
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                X = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if X:FindFirstChild("Stats") then
                    require(X.Stats.Local).MaxSpread = 0
                    require(X.Stats.Local).MinSpread = 0
                end
            end
        end
    end
})

ExtraGunMods:AddToggle('Rifle', {
    Text = 'No Rifle',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        GunModToggles.Rifle = v

        if v == true then
            if LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                X = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if X:FindFirstChild("Stats") then
                    if X.Stats:FindFirstChild("Rifle") then
                        X.Stats.Rifle:Destroy()
                    end
                end
            end
        end
    end
})




local OldSpeed; local SetSpeed = 30;
LocalPlayerBox:AddToggle('ws234e', {
    Text = 'Walk Speed',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        OldSpeed = v
        while OldSpeed do task.wait()
            if OldSpeed then
                if LocalPlayer.Character then
                    LocalPlayer.Character.Humanoid.WalkSpeed = SetSpeed 
                end
            else
                if LocalPlayer.Character then
                    LocalPlayer.Character.Humanoid.WalkSpeed = 10 
                end
            end
        end
    end
})

LocalPlayerBox:AddSlider('Speed', {
    Text = 'Speed',
    Default = 30,
    Min = 0,
    Max = 50,
    Rounding = 0,
    Compact = true,

    Callback = function(v)
        SetSpeed = v
    end
})

LocalPlayerBox:AddDivider()

LocalPlayerBox:AddToggle('Anti-Cuff', {
    Text = 'Anti Cuff',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        CuffToggle = Value
        Iscffed = game.Players.LocalPlayer.isCuffed
        Iscffed.Value = false
        Iscffed:GetPropertyChangedSignal("Value"):Connect(function()
            if CuffToggle then
                Iscffed.Value = false
            end
        end)
    
        game:GetService("CoreGui").RobloxGui.Backpack.Visible = true
        game:GetService("CoreGui").RobloxGui.Backpack:GetPropertyChangedSignal("Visible"):Connect(function()
            if CuffToggle then
                game:GetService("CoreGui").RobloxGui.Backpack.Visible = true
            end
        end)
    end
})

local PickupLoop;
LocalPlayerBox:AddToggle('Auto-Pick', {
    Text = 'Auto Pick Up',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        PickupLoop = Value
        while PickupLoop do task.wait(.05)
            for i,v in next, game.Workspace.tools:GetChildren() do
                if v:IsA("Tool") and v.Name ~="Crate" then
                    LocalPlayer.Character:FindFirstChild("Humanoid"):EquipTool(v)
                end
            end
        end
    end
})        

local Run;
Run = game.Players.LocalPlayer.PlayerGui.Run
game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(args)
    if args.Name == "Run" and args:IsA("LocalScript") then
        Run = args
    end
end)

local Run = game.Players.LocalPlayer.PlayerGui.Run
local SkitOnOrOff = false;
LocalPlayerBox:AddToggle('Inf-Skittles', {
    Text = 'Infinite Skittles',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        SkitOnOrOff = Value
        Run.Value.Value = Value
        Run.Value:GetPropertyChangedSignal("Value"):Connect(function()
            if SkitOnOrOff then
                Run.Value.Value = SkitOnOrOff
            else
            end
        end)
        game.Players.LocalPlayer.Character:WaitForChild("Resistance")
        Res = game.Players.LocalPlayer.Character:WaitForChild("Resistance")
        Res.Value = SkitOnOrOff
        Res:GetPropertyChangedSignal("Value"):Connect(function()
            if SkitOnOrOff then
            Res.Value = SkitOnOrOff
            else
            end
        end)
    end
})

LocalPlayerBox:AddToggle('InfStamina', {
    Text = 'Infinite Stamina',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        local Stamina = LocalPlayer.Valuestats.Stamina
        StaminaToggle = Value
        if StaminaToggle then
            Stamina.Value = 999999999999
        else
            Stamina.Value = 100
        end
    end
})

game.Players.LocalPlayer.CharacterAdded:Connect(function(Char)
    game.Players.LocalPlayer.PlayerGui:WaitForChild("Run")
    Run = game.Players.LocalPlayer.PlayerGui:WaitForChild("Run")

    if SkitOnOrOff then
        Run.Value.Value = SkitOnOrOff
        Run.Value:GetPropertyChangedSignal("Value"):Connect(function()
            if SkitOnOrOff then
                Run.Value.Value = SkitOnOrOff
            else
            end
        end)
        game.Players.LocalPlayer.Character:WaitForChild("Resistance")
        Res = game.Players.LocalPlayer.Character:WaitForChild("Resistance")
        Res.Value = SkitOnOrOff
        Res:GetPropertyChangedSignal("Value"):Connect(function()
            if SkitOnOrOff then
                Res.Value = SkitOnOrOff
                else
            end
        end)
    end
end)

local SlotsToggle = false;
LocalPlayer:WaitForChild("PlayerGui").ChildAdded:Connect(function(v)
    if v.Name == "Safe" then
        v.Frame.Badge.Value = SlotsToggle
    end
end) 

local SkitOnOrOff;
LocalPlayerBox:AddToggle('SafeSlots', {
    Text = '10 Safe Slots',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        SlotsToggle = Value
        LocalPlayer.PlayerGui.Safe.Frame.Badge.Value = Value
    end
})

ExtraPlayerBox:AddToggle('Hood', {
    Text = 'Anti Apartment Check',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        BypassApt = Value
    end
})

local HoodNo,oldhood;
ExtraPlayerBox:AddToggle('Hood', {
    Text = 'Anti Hood Pull',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        oldhood = Value
        HoodNo = Value
        LocalPlayer = game.Players.LocalPlayer
        while HoodNo do task.wait(0.1)
            if LocalPlayer.Backpack:FindFirstChild("Hood/Walljump") then
                LocalPlayer.Backpack:FindFirstChild("Hood/Walljump").Disabled=oldhood
            end
        end
    end
})

local CameraBobDisableLoop
ExtraPlayerBox:AddToggle('Camerabob', {
    Text = 'Anti Camera Bob',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        CameraBobDisableLoop = Value
        while CameraBobDisableLoop do task.wait(0.25)
        if CameraBobDisableLoop then
            LocalPlayer.PlayerGui:WaitForChild("Camera_Bob").Disabled = true
            else
            LocalPlayer.PlayerGui:WaitForChild("Camera_Bob").Disabled = false
        end
        end
    end
})

local AntiCrash = false;
ExtraPlayerBox:AddToggle('fgfgv', {
    Text = 'Anti Crash',
    Default = false, -- Default value (true / false)

    Callback = function(Value)
        AntiCrash = Value
    end
})

local AntiCrashHook;AntiCrashHook = hookmetamethod(game.ReplicatedStorage,"__namecall",function(self,...)
    if tostring(self) == "AirbagSystem" and AntiCrash then
        Args = {...}
        Args[2] = 0
        return AntiCrashHook(self,unpack(Args))
    end
    return AntiCrashHook(self,...)
end)

SafeRemote = game.ReplicatedStorage.UI.Safe
SafeStats = game.Players.LocalPlayer.SafeStats

getgenv().BlacklistedTools = {
    ['Skittles'] = true,
    ['SkittlesPack'] = true,
    ['Bally'] = true,
    ['Mask'] = true,
    ['Fist'] = true,
    ['Phone'] = true,
    ['MXHelmet'] = true,
    ['SBGlock'] = true,
    ['Radio'] = true,
    ['SBDraco'] = true,
    ['AK'] = true,
    ['Airpods'] = true,
    ['Bandana'] = true
}

getgenv().MaxClips = false
getgenv().SafeGunsWhenYouDie = false
SafeBox:AddToggle('SafeGunsDead', {
    Text = 'Safe Guns When You Die',
    Default = false,

    Callback = function(v)
        getgenv().SafeGunsWhenYouDie = v
        while getgenv().SafeGunsWhenYouDie do task.wait(0.25)
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health < 1 then
                for _,Tool in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                    if not BlacklistedTools[Tool.Name] == true and Tool:IsA("Tool") and not Tool:FindFirstChild("Drink") and not Tool:FindFirstChild("Bite") and not Tool:FindFirstChild("Cork") then
                        if getgenv().MaxClips == true then
                            SafeRemote:FireServer("Movetosafe",Tool.Name,999999999999999999,ChosenPlayer)
                        elseif getgenv().MaxClips == false then
                            if game.Players.LocalPlayer.Backpack[Tool.Name]:FindFirstChild("Stats") then
                                SafeRemote:FireServer("Movetosafe",Tool.Name,game.Players.LocalPlayer.Backpack[Tool.Name].Stats.MaxAmmo.Value,ChosenPlayer)
                            elseif game.Players.LocalPlayer.Backpack[Tool.Name]:FindFirstChild("USES") then
                                SafeRemote:FireServer("Movetosafe",Tool.Name,game.Players.LocalPlayer.Backpack[Tool.Name].USES.Value,ChosenPlayer)
                            elseif game.Players.LocalPlayer.Backpack[Tool.Name]:FindFirstChild("val") then
                                SafeRemote:FireServer("Movetosafe",Tool.Name,game.Players.LocalPlayer.Backpack[Tool.Name].val.Value,ChosenPlayer)
                            else
                                SafeRemote:FireServer("Movetosafe",Tool.Name,999999999999999999,ChosenPlayer)
                            end
                        end
                    end
                end
            else
                
            end
        end
    end
})

SafeBox:AddToggle('MxClips', {
    Text = 'Max Clips/Uses On Item',
    Default = false,

    Callback = function(v)
        getgenv().MaxClips = v
    end
})

local OldHook;OldHook = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    if getgenv().MaxClips then
        if tostring(self) == "Safe" then
            Arguments = {...}
            if Arguments[1] == "Movetosafe" then
                Arguments[3] = 999999999999999999
                return OldHook(self,unpack(Arguments))
            end
        end
    end
    return OldHook(self,...)
end))

function GetItemFromSafe(Name)
    for i,v in pairs(SafeStats:GetChildren()) do
        if v.Value == Name then
            return v
        end
    end
end

local ChosenPlayer = game.Players.LocalPlayer.UserId

SafeBox:AddDropdown('SafeDropDown', {
    Values = {},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = 'Take Gun',

    Callback = function(v)
        SafeRemote:FireServer("Takeout",GetItemFromSafe(v).Value,GetItemFromSafe(v):FindFirstChildOfClass("IntValue").Value,ChosenPlayer)
    end
})

SafeBox:AddDropdown('PuttingDropDown', {
    Values = {},
    Default = '', -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected
    AllowNull = true,
    Text = 'Safe Gun',

    Callback = function(v)
        if getgenv().MaxClips == false then
            if game.Players.LocalPlayer.Backpack[v]:FindFirstChild("Stats") then
                SafeRemote:FireServer("Movetosafe",v,game.Players.LocalPlayer.Backpack[v].Stats.MaxAmmo.Value,ChosenPlayer)
            elseif game.Players.LocalPlayer.Backpack[v]:FindFirstChild("USES") then
                SafeRemote:FireServer("Movetosafe",v,game.Players.LocalPlayer.Backpack[v].USES.Value,ChosenPlayer)
            elseif game.Players.LocalPlayer.Backpack[v]:FindFirstChild("val") then
                SafeRemote:FireServer("Movetosafe",v,game.Players.LocalPlayer.Backpack[v].val.Value,ChosenPlayer)
            else
                SafeRemote:FireServer("Movetosafe",v,999999999999999999,ChosenPlayer)
            end
        elseif getgenv().MaxClips == true then
            SafeRemote:FireServer("Movetosafe",v,999999999999999999,ChosenPlayer)
        end
    end
})

SafeBox:AddDropdown('TheWLThing', {
    SpecialType = 'Player',
    Text = 'Player To Whitelist',
    Multi = false,

    Callback = function(Value)
        ChosenPlayer = game.Players[Value].UserId
    end
})

Options.TheWLThing:SetValue(tostring(LocalPlayer))



function ReturnSafeStats()
    Safe = {}
    for i,v in next, game.Players.LocalPlayer.SafeStats:GetChildren() do
        table.insert(Safe,v.Value)
    end
    table.sort(Safe,function(a,b) return a<b end)
    Options.SafeDropDown:SetValues(Safe)
end

ReturnSafeStats()

for i,v in pairs(game.Players.LocalPlayer.SafeStats:GetChildren()) do
    v:GetPropertyChangedSignal("Value"):Connect(ReturnSafeStats)
end

function ReturnBackpack()
    Backpack = {}
    for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if v.Name ~= 'Fist' and v.Name ~= 'Phone' and v:IsA("Tool") then
            table.insert(Backpack,v.Name)
        end
    end
    table.sort(Backpack,function(a,b) return a<b end)
    Options.PuttingDropDown:SetValues(Backpack);
end

ReturnBackpack()
LocalPlayer.Backpack.ChildAdded:Connect(ReturnBackpack)
LocalPlayer.Backpack.ChildRemoved:Connect(ReturnBackpack)

LocalPlayer.CharacterAdded:Connect(function()
    ReturnBackpack()
    LocalPlayer.Backpack.ChildAdded:Connect(ReturnBackpack)
    LocalPlayer.Backpack.ChildRemoved:Connect(ReturnBackpack)
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

AimbotSnapLineBox:AddToggle('ZZZZ', {
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
        octoware.aiming.aimbot.smoothingstyle = Enum.EasingStyle[v]
    end
})

AimbotSmoothingBox:AddDropdown('Easing Direction', {
    Values = {"InOut", "In", "Out"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Direction',

    Callback = function(v)
        octoware.aiming.aimbot.easingdirection = Enum.EasingDirection[v]
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



local EspSettings = Tabs.Visuals:AddLeftGroupbox('ESP Settings') -- these are your groupboxes better known as "sections"

EspSettings:AddDropdown('Type', {
    Values = {"Bounding","3D"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Bounding Style',

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


game:GetService("RunService").RenderStepped:Connect(function()
    if GunModToggles.Whitelist and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HoldPistol",true) then
        LocalPlayer.Character:FindFirstChild("HoldPistol",true).Transparency = 1
    end
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
