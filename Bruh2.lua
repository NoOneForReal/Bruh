game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "WEED WARE",
    Text = "Please be patient as we bypass their anticheat.",
    Icon = "", -- Optional: You can specify an icon for the notification
    Duration = 15 -- Optional: Duration in seconds, defaults to 5 seconds
})

local nums = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}
local remote1;
local remote1args
local remote2;
local remote2args
local remote3;
local remote3args
local remote4;
local remote4args
local index = 0
for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
    for z, x in pairs(nums) do
        if string.match(v.Name, tostring(x)) then
            index += 1
            if index == 1 then
                remote1 = v:FindFirstChildOfClass("RemoteFunction")
            elseif index == 2 then
                remote2 = v:FindFirstChildOfClass("RemoteFunction")
            elseif index == 3 then
                remote3 = v:FindFirstChildOfClass("RemoteFunction")
            elseif index == 4 then
                remote4 = v:FindFirstChildOfClass("RemoteFunction")
            end
        end
    end
end
function deepclone(table)
    local tbl = {}
    for i, v in pairs(table) do
        if typeof(v) == "table" then
            table.insert(tbl, deepclone(v))
        else
            table.insert(tbl, v)
        end
    end
    return tbl
end
hookfunction(remote1.InvokeServer, function(args)
    print("Found Remote1")
    if not remote1args then
        if typeof(args) == "table" then
            remote1args = deepclone(args)
        else
            remote1args = args
        end
    end
end)
hookfunction(remote2.InvokeServer, function(args)
    if not remote2args then
        print("Found Remote2")
        if typeof(args) == "table" then
            remote2args = deepclone(args)
        else
            remote2args = args
        end
    end
end)
hookfunction(remote3.InvokeServer, function(args)
    if not remote3args then
        print("Found Remote3")
        if typeof(args) == "table" then
            remote3args = deepclone(args)
        else
            remote3args = args
        end
    end
end)
hookfunction(remote4.InvokeServer, function(args)

       if not remote4args then
        print("Found Remote4")
        if typeof(args) == "table" then
            remote4args = deepclone(args)
        else
            remote4args = args
        end
    end
end)

task.spawn(function()
    repeat task.wait() until remote1args
    while task.wait(1) do
        remote1:InvokeServer(remote1args)
    end
end)

task.spawn(function()
    repeat task.wait() until remote2args
    while task.wait(1) do
        remote2:InvokeServer(remote2args)
    end
end)
task.spawn(function()
    repeat task.wait() until remote3args
    while task.wait(1) do
        remote3:InvokeServer(remote3args)
    end
end)
task.spawn(function()
    repeat task.wait() until remote2args
    while task.wait(1) do
        remote4:InvokeServer(remote2args)
    end
end)
repeat task.wait() until remote1args or remote2args or remote3args or remote4args
for _,v in next, getgc(true) do
  if type(v) == "function" then
        name = tostring(getinfo(v).name)
        if name == "delay" then
        local Old;Old = hookfunction(v, function(...)
        Args = {...}
        if type(Args[2]) ~= "function" then
            Args[2] = function()
                return game:WaitForChild(tostring(math.random(1,9e9)))
            end
        end
        return Old(...)
        end)
    end
    if name == "find" or name == "string.find" then
          local new;new = hookfunction(v,function(...)
              if string.match(tostring(getcallingscript()),"?") then
                  return game:WaitForChild(tostring(math.random(1,9e9)))
              end
              return new(...)
          end)
      end
  end
end
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


local weedware = {
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
    Aiming = Window:AddTab('Aiming');
    Visuals = Window:AddTab('Visuals');
    ['UI Settings'] = Window:AddTab('UI Settings');
}


local AimbotBox = Tabs.Aiming:AddLeftGroupbox('Aimbot') -- these are your groupboxes better known as "sections"
local SilentBox = Tabs.Aiming:AddRightGroupbox('Silent') 




SilentBox:AddToggle('SilentEnabled', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.enabled = v
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
        weedware.aiming.silent.keybind = New
    end
})

SilentBox:AddDropdown('SilentPart', {
    Values = { 'Head','HumanoidRootPart' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Target Part',

    Callback = function(v)
        weedware.aiming.silent.targetpart = v
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
        weedware.aiming.silent.targetmode = v
    end
})


SilentBox:AddToggle('SilentFriend', {
    Text = 'Friend Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.friendcheck = v
    end
})


SilentBox:AddToggle('SilentVis', {
    Text = 'Visible Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.visiblecheck = v
    end
})


SilentBox:AddToggle('SilentAlive', {
    Text = 'Alive Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.alivecheck = v
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
        weedware.aiming.silent.hitchance = v
    end
})






local silentfovbox = Tabs.Aiming:AddRightGroupbox('Silent FOV') -- these are your groupboxes better known as "sections"


silentfovbox:AddToggle('silentdrawfov', {
    Text = 'Show FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.showfov = v
    end
}):AddColorPicker('silentFOVCOLOR', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.aiming.silent.fovcolor = v
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
        weedware.aiming.silent.fovradius = v
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
        weedware.aiming.silent.fovsides = v
    end
})

local silentsnaplinebox = Tabs.Aiming:AddRightGroupbox('Silent Snapline') -- these are your groupboxes better known as "sections"

silentsnaplinebox:AddToggle('silentsilentsilentsilent', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.silent.snapline = v
    end
}):AddColorPicker('FakeSnapline', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Snapline Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.aiming.silent.snaplinecolor = v
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
        weedware.aiming.aimbot.enabled = v
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
        weedware.aiming.aimbot.keybind = New
    end
})

AimbotBox:AddDropdown('AimPart', {
    Values = { 'Head','HumanoidRootPart' },
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Target Part',

    Callback = function(v)
        weedware.aiming.aimbot.targetpart = v
    end
})


AimbotBox:AddToggle('AimbotFriend', {
    Text = 'Friend Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.aimbot.friendcheck = v
    end
})


AimbotBox:AddToggle('AimbotVisible', {
    Text = 'Visible Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.aimbot.visiblecheck = v
    end
})


AimbotBox:AddToggle('AimbotAlive', {
    Text = 'Alive Check',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.aimbot.alivecheck = v
    end
})



local AimbotFoxBox = Tabs.Aiming:AddLeftGroupbox('Aimbot FOV') -- these are your groupboxes better known as "sections"


AimbotFoxBox:AddToggle('aimbotdrawfov', {
    Text = 'Show FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.aimbot.showfov = v
    end
}):AddColorPicker('AimbotFOVCOLOR', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'FOV Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.aiming.aimbot.fovcolor = v
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
        weedware.aiming.aimbot.fovradius = v
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
        weedware.aiming.aimbot.fovsides = v
    end
})

local AimbotSnapLineBox = Tabs.Aiming:AddLeftGroupbox('Aimbot Snapline') -- these are your groupboxes better known as "sections"

AimbotSnapLineBox:AddToggle('ZZZZ', {
    Text = 'Enabled',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.aiming.aimbot.snapline = v
    end
}):AddColorPicker('FakeSnapline', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Snapline Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = nil, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.aiming.aimbot.snaplinecolor = v
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
        weedware.aiming.aimbot.smoothing = v
    end
})

AimbotSmoothingBox:AddDropdown('Easing Style', {
    Values = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Style',

    Callback = function(v)
        weedware.aiming.aimbot.smoothingstyle = Enum.EasingStyle[v]
    end
})

AimbotSmoothingBox:AddDropdown('Easing Direction', {
    Values = {"InOut", "In", "Out"},
    Default = 1, -- number index of the value / string
    Multi = false, -- true / false, allows multiple choices to be selected

    Text = 'Easing Direction',

    Callback = function(v)
        weedware.aiming.aimbot.easingdirection = Enum.EasingDirection[v]
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
        weedware.visuals.world.changeambient = v
    end
})

WorldColors:AddLabel('Color'):AddColorPicker('AmbientClr', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.visuals.world.ambient = v
    end
})

WorldColors:AddToggle('FogColor', {
    Text = 'Fog Color',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.visuals.world.changefogcolor = v
    end
})

WorldColors:AddLabel('Color'):AddColorPicker('FogClr', {
    Default = Color3.new(1, 1, 1), -- Bright green
    Title = 'Color', -- Optional. Allows you to have a custom color picker title (when you open it)
    Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

    Callback = function(v)
        weedware.visuals.world.fogcolor = v
    end
})

WorldColors:AddToggle('FOVtoggle', {
    Text = 'FOV',
    Default = false, -- Default value (true / false)

    Callback = function(v)
        weedware.visuals.world.changefov = v
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
        weedware.visuals.world.fov = v
    end
})

-- you can remove things you dont want


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })


ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('weedware')
ThemeManager:ApplyToTab(Tabs['UI Settings']) -- if you gonna change UI Settings in the tabs you need to replace this as well for themes

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('weedware/games/'..game.PlaceId)
SaveManager:BuildConfigSection(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()




function utility:getclosestplayertomouse(fovradius, friendcheck, alivecheck, vischeck,silentwlcheck, hitchance)
    local curdistance, plr = fovradius
    local targetpart = weedware.aiming.aimbot.targetpart
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
                        if hitchance then if math.random(0,100) > weedware.aiming.silent.hitchance + 1 then continue end end
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
    aimbottween = tweenservice:Create(workspace.CurrentCamera, TweenInfo.new(weedware.aiming.aimbot.smoothing, weedware.aiming.aimbot.smoothingstyle), {CFrame = CFrame.new(camera.CFrame.Position, part.Position)})
    aimbottween:Play()
end
local setfog, setfov = false, false
local defambient = game.Lighting.Ambient
local deffogcolor = game.Lighting.FogColor
local tint = Instance.new("ColorCorrectionEffect", game.Lighting)
runservice.RenderStepped:Connect(function()
    if weedware.visuals.world.changefov then
        setfov = false
        camera.FieldOfView = weedware.visuals.world.fov
    else
        if not setfov then
            setfov = true
            camera.FieldOfView = 70
        end
    end
    if weedware.visuals.world.changeambient then
        
        tint.TintColor = weedware.visuals.world.ambient
    else
        tint.TintColor = Color3.new(1, 1, 1)
    end
    if weedware.visuals.world.changefogcolor then
        setfog = false
        game.Lighting.FogColor = weedware.visuals.world.fogcolor
    else
        if not setfog then
            setfog = true
            game.Lighting.FogColor = deffogcolor
        end
    end
    if not holding then
        aimbotclosest = utility:getclosestplayertomouse(weedware.aiming.aimbot.fovradius, weedware.aiming.aimbot.friendcheck, weedware.aiming.aimbot.alivecheck, weedware.aiming.aimbot.visiblecheck,false,false)
    end
    if weedware.aiming.silent.targetmode == "Auto" then
        silentclosest = utility:getclosestplayertomouse(weedware.aiming.silent.fovradius, weedware.aiming.silent.friendcheck, weedware.aiming.silent.alivecheck, weedware.aiming.silent.visiblecheck,true,true)
    end
    aimbotfov.Visible = weedware.aiming.aimbot.enabled and weedware.aiming.aimbot.showfov
    aimbotfovoutline.Visible = aimbotfov.Visible
    aimbotfov.Radius = weedware.aiming.aimbot.fovradius
    aimbotfovoutline.Radius = weedware.aiming.aimbot.fovradius + 1
    aimbotfov.Color = weedware.aiming.aimbot.fovcolor
    aimbotfov.NumSides = weedware.aiming.aimbot.fovsides
    aimbotfovoutline.NumSides = weedware.aiming.aimbot.fovsides
    local mouselocation = inputservice:GetMouseLocation()
    aimbotfov.Position = Vector2.new(mouselocation.X, mouselocation.Y)
    aimbotfovoutline.Position = aimbotfov.Position

    aimbotsnaplineoutline.Visible = aimbotsnapline.Visible
    aimbotsnapline.Color = weedware.aiming.aimbot.snaplinecolor
    if aimbotclosest and weedware.aiming.aimbot.enabled and weedware.aiming.aimbot.snapline and not holding then
        if aimbotclosest.Character and aimbotclosest.Character:FindFirstChild(weedware.aiming.aimbot.targetpart) then
            local wts, onscreen = camera:WorldToViewportPoint(aimbotclosest.Character:FindFirstChild(weedware.aiming.aimbot.targetpart).Position)
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


    silentfov.Visible = weedware.aiming.silent.enabled and weedware.aiming.silent.showfov
    silentfovoutline.Visible = silentfov.Visible
    silentfov.Radius = weedware.aiming.silent.fovradius
    silentfovoutline.Radius = weedware.aiming.silent.fovradius + 1
    silentfov.Color = weedware.aiming.silent.fovcolor
    silentfov.NumSides = weedware.aiming.silent.fovsides
    silentfovoutline.NumSides = weedware.aiming.silent.fovsides
    local mouselocation = inputservice:GetMouseLocation()
    silentfov.Position = Vector2.new(mouselocation.X, mouselocation.Y)
    silentfovoutline.Position = silentfov.Position

    silentsnaplineoutline.Visible = silentsnapline.Visible
    silentsnapline.Color = weedware.aiming.silent.snaplinecolor
    if silentclosest and weedware.aiming.silent.enabled and weedware.aiming.silent.snapline and not holding then
        if silentclosest.Character and silentclosest.Character:FindFirstChild(weedware.aiming.silent    .targetpart) then
            local wts, onscreen = camera:WorldToViewportPoint(silentclosest.Character:FindFirstChild(weedware.aiming.silent.targetpart).Position)
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
            local targetpart = char:FindFirstChild(weedware.aiming.aimbot.targetpart)
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
    if not gameProcessedEvent and input.KeyCode == weedware.aiming.aimbot.keybind and aimbotclosest and weedware.aiming.aimbot.enabled then
        holding = true
    end
    if not gameProcessedEvent and input.KeyCode == weedware.aiming.silent.keybind then
        if weedware.aiming.silent.targetmode == "Target" then
            if silentclosest then
                silentclosest = nil
            else
                silentclosest = utility:getclosestplayertomouse(weedware.aiming.silent.fovradius, weedware.aiming.silent.friendcheck, weedware.aiming.silent.alivecheck, weedware.aiming.silent.visiblecheck,true,true)
                if silentclosest ~= nil and weedware.aiming.silent.enabled then
                Library:Notify("WEED HUB | LOCKED ONTO "..tostring(silentclosest):upper(),5)
                end
            end
        end
    end
end)
uis.InputEnded:Connect(function(input)
    if input.KeyCode ==  weedware.aiming.aimbot.keybind then
        holding = false
    end
end)

local old; old = hookmetamethod(workspace, "__namecall", newcclosure(function(...)
    local method = getnamecallmethod()
    if weedware.aiming.silent.enabled and silentclosest and tostring(method) == "Raycast" then
        local args = {...}
        local origin = args[2]
        local targetpart = findfirstchild(silentclosest.Character, weedware.aiming.silent.targetpart)
        if targetpart then
            args[3] = utility:calcdistance(origin, targetpart.Position)
        end
        if weedware.aiming.silent.wallbang then
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

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu
