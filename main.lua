--/ Services
local Players = game:GetService("Players")
local runService = game:GetService("RunService")
local ts = game:GetService("TweenService")

local tinf = TweenInfo.new(.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local p = Players.LocalPlayer
local mouse = p:GetMouse()
local pGui = p:WaitForChild("PlayerGui")

local limbs = {
    "Head",
    "Torso",
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg",
    "HumanoidRootPart",
    "UpperTorso",
    "LowerTorso",
    "LeftUpperArm",
    "LeftLowerArm",
    "LeftHand",
    "RightUpperArm",
    "RightLowerArm",
    "RightHand",
    "LeftUpperLeg",
    "LeftLowerLeg",
    "LeftFoot",
    "RightUpperLeg",
    "RightLowerLeg",
    "RightFoot"
}

local espConn
local namesConn
local speedConn
local jumpConn
local spinbotConn
local glueConn

--{}[]

mouse.Button1Down:Connect(function()
    if (not pGui:FindFirstChild("CCoreGui")) then return end
    local gui = pGui:FindFirstChild("CCoreGui")
    if (not gui:FindFirstChild("CtoTeleport")) then return end
    if (gui:FindFirstChild("CtoTeleport").Value == false) then return end
    local hitPos = mouse.Hit
    local char = p.Character
    if (char) and (hitPos) and (char:FindFirstChild("HumanoidRootPart")) then
        char.HumanoidRootPart.CFrame = hitPos * CFrame.new(0,5,0)
    end
end)

local function TeleportPlayer(givenName)
    local tPlayer = nil
    if (Players:FindFirstChild(givenName)) and (p.Character) and (p.Character:FindFirstChild("HumanoidRootPart")) then
        tPlayer = Players:FindFirstChild(givenName)
        if (tPlayer.Character) and (tPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            p.Character.HumanoidRootPart.CFrame = tPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
        end
    else
        for i, plyrs in pairs(Players:GetPlayers()) do
            if (plyrs.DisplayName == givenName) then
                tPlayer = plyrs
                if (tPlayer.Character) and (tPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                    if (p.Character) and (p.Character:FindFirstChild("HumanoidRootPart")) then
                        p.Character.HumanoidRootPart.CFrame = tPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                    end
                end
            end
        end
    end
end

local function ToggleEsp(bool)
    if (bool == true) then
        espConn = runService.RenderStepped:Connect(function()
            for i, plrs in pairs(Players:GetPlayers()) do
                if (plrs) and (plrs.Character) then
                    local char = plrs.Character
                    if (char) then

                        if (plrs == p) then continue end

                        if (plrs.Character:FindFirstChild("ESPLight")) then
                            if (pGui.CCoreGui.Chams.Value == false) then
                                plrs.Character:FindFirstChild("ESPLight").FillTransparency = 1
                            else
                                plrs.Character:FindFirstChild("ESPLight").FillTransparency = .5
                            end
                            continue
                        end

                        local highlight = Instance.new("Highlight", plrs.Character)
                        highlight.Name = "ESPLight"

                        for i, v in pairs(plrs.Character:GetChildren()) do
                            if (limbs[v.Name]) then
                                highlight.Parent = v.Parent
                            end
                        end

                        if (pGui.CCoreGui.Chams.Value == false) then
                            plrs.Character:FindFirstChild("ESPLight").FillTransparency = 1
                        else
                            plrs.Character:FindFirstChild("ESPLight").FillTransparency = .5
                        end

                    end
                end
            end
        end)
    else
        if (espConn) then
            espConn:Disconnect()
        end
        for i, plrs in pairs(Players:GetPlayers()) do
            if (plrs) and (plrs.Character) then
                if (plrs.Character:FindFirstChild("ESPLight")) then
                    plrs.Character:FindFirstChild("ESPLight"):Destroy()
                end
            end
        end
    end
end

local function ToggleNames(bool)
    if (bool == true) then
        namesConn = runService.RenderStepped:Connect(function()
            for i, plrs in pairs(Players:GetPlayers()) do
                if (plrs) and (plrs.Character) then
                    if (plrs.Character:FindFirstChild("Head")) then
                        if (plrs.Character.Head:FindFirstChild("BiggerName")) then continue end

                        local billboard = Instance.new("BillboardGui", plrs.Character.Head)
                        billboard.Name = "BiggerName"
                        billboard.StudsOffset = Vector3.new(0,3.5,0)
                        billboard.Size = UDim2.fromScale(9,1.5)
                        billboard.MaxDistance = 250

                        local textlabel = Instance.new("TextLabel", billboard)
                        textlabel.BackgroundTransparency = 1
                        textlabel.Size = UDim2.fromScale(1,1)
                        textlabel.Font = Enum.Font.ArimoBold
                        textlabel.TextColor3 = Color3.fromRGB(255,255,255)
                        textlabel.TextScaled = true
                        textlabel.Text = plrs.DisplayName.."(@"..plrs.Name..")"

                        local stroke = Instance.new("UIStroke", textlabel)
                    end
                end
            end
        end)
    else
        if (namesConn) then
            namesConn:Disconnect()
        end
        for i, plrs in pairs(Players:GetPlayers()) do
            if (plrs) and (plrs.Character) and (plrs.Character:FindFirstChild("Head")) then
                if (plrs.Character.Head:FindFirstChild("BiggerName")) then
                    plrs.Character.Head.BiggerName:Destroy()
                end
            end
        end
    end
end

local function ToggleSpeed(bool, value)
    if (bool == true) then
        speedConn = runService.RenderStepped:Connect(function()
            if (p.Character) and (p.Character:FindFirstChildWhichIsA("Humanoid")) then
                p.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = value
            end
        end)
    else
        if (speedConn) then
            speedConn:Disconnect()
        end
        if (p.Character) and (p.Character:FindFirstChildWhichIsA("Humanoid")) then
            p.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = 16
        end
    end
end

local function ToggleJump(bool, value)
    if (bool == true) then
        jumpConn = runService.RenderStepped:Connect(function()
            if (p.Character) and (p.Character:FindFirstChildWhichIsA("Humanoid")) then
                p.Character:FindFirstChildWhichIsA("Humanoid").UseJumpPower = false
                p.Character:FindFirstChildWhichIsA("Humanoid").JumpHeight = value
            end
        end)
    else
        if (jumpConn) then
            jumpConn:Disconnect()
        end
        if (p.Character) and (p.Character:FindFirstChildWhichIsA("Humanoid")) then
            p.Character:FindFirstChildWhichIsA("Humanoid").JumpHeight = 7.2
        end
    end
end

local function ToggleSpinbot(bool)
    if (bool == true) then
        spinbotConn = runService.RenderStepped:Connect(function()
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if (hrp) then
                local random = math.random(0,120)
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(random), 0)
            else
                if (spinbotConn) then
                    spinbotConn:Disconnect()
                end
            end
        end)
    else
        if (spinbotConn) then
            spinbotConn:Disconnect()
        end
    end
end

local function ToggleGlueHack(bool, user)
    if (bool == true) then
        for i, plrs in pairs(Players:GetPlayers()) do
            if (plrs.Name == user) or (plrs.DisplayName == user) then
                glueConn = runService.RenderStepped:Connect(function()
                    if (p.Character) and (plrs.Character) then
                        if (p.Character:FindFirstChild("HumanoidRootPart")) and (plrs.Character:FindFirstChild("HumanoidRootPart")) then
                            p.Character.HumanoidRootPart.CFrame = plrs.Character.HumanoidRootPart.CFrame * CFrame.new(
                                math.random(.2,.5),
                                math.random(.2,.5),
                                math.random(.2,.5)
                            )
                        end
                    end
                end)
            end
        end
    else
        if (glueConn) then
            glueConn:Disconnect()
        end
    end
end

local function CreateButton(name, parent, gui)
    local barFrame = Instance.new("CanvasGroup", parent)
    barFrame.BackgroundColor3 = Color3.fromRGB(61,61,61)
    barFrame.Size = UDim2.new(0.197, 0,0.64, 0)
    barFrame.Position = UDim2.new(0.728, 0,0.162, 0)

    local corner = Instance.new("UICorner", barFrame)
    corner.CornerRadius = UDim.new(1,0)

    local stroke = Instance.new("UIStroke", barFrame)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    stroke.Color = Color3.fromRGB(255,255,255)
    --{}[]
    local button = Instance.new("TextButton", barFrame)
    button.Name = name
    button.Text = ""
    button.Size = UDim2.new(0.391, 0,1, 0)
    button.Position = UDim2.new(0.609, 0,0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255,0,0)

    local onAnim = ts:Create(button, tinf, {
        Position = UDim2.fromScale(button.Position.X.Scale - .6, button.Position.Y.Scale),
        BackgroundColor3 = Color3.fromRGB(0,255,0)
    })

    local offAnim = ts:Create(button, tinf, {
        Position = UDim2.fromScale(button.Position.X.Scale, button.Position.Y.Scale),
        BackgroundColor3 = Color3.fromRGB(255,0,0)
    })

    button.Activated:Connect(function()
        local status = gui:FindFirstChild(name)
        if (status) and (gui:FindFirstChild(name).Value == false) then
            onAnim:Play()
            gui:FindFirstChild(button.Name).Value = true
        else
            offAnim:Play()
            gui:FindFirstChild(button.Name).Value = false
        end
    end)

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(1,0)
end

local function SetupBools(parent)
    local spinbot = Instance.new("BoolValue", parent)
    spinbot.Name = "Spinbot"
    spinbot.Changed:Connect(function()
        ToggleSpinbot(spinbot.Value)
    end)
    local names = Instance.new("BoolValue", parent)
    names.Name = "Names"
    names.Changed:Connect(function()
        ToggleNames(names.Value)
    end)
    local esp = Instance.new("BoolValue", parent)
    esp.Name = "ESP"
    esp.Changed:Connect(function()
        ToggleEsp(esp.Value)
    end)
    local chams = Instance.new("BoolValue", parent)
    chams.Name = "Chams"
    local aimbot = Instance.new("BoolValue", parent)
    aimbot.Name = "Aimbot"
    local ctotp = Instance.new("BoolValue", parent)
    ctotp.Name = "CtoTeleport"
    local fly = Instance.new("BoolValue", parent)
    fly.Name = "Fly"
end

local function InitUI()
    if (not pGui) then return end
    local coreGui = Instance.new("ScreenGui")
    coreGui.Name = "CCoreGui"
    coreGui.ResetOnSpawn = false
    coreGui.Parent = pGui

    SetupBools(coreGui)

    local mainFrame = Instance.new("Frame")

    local mainCorner = Instance.new("UICorner")
    mainCorner.Parent = mainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(230,230,230)
    mainStroke.Thickness = 2
    mainStroke.Parent = mainFrame

    local dragDetect = Instance.new("UIDragDetector")
    dragDetect.Parent = mainFrame

    mainFrame.Size = UDim2.new(0.196, 0,0.539, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)

    local list = Instance.new("Frame")
    list.BackgroundTransparency = 1
    list.Parent = mainFrame
    list.Size = UDim2.new(0.964, 0,0.896, 0)
    list.Position = UDim2.new(0.018, 0,0.034, 0)

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0.02, 0)
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    listLayout.Parent = list

    local teleportFrame = Instance.new("CanvasGroup")
    teleportFrame.Parent = list
    teleportFrame.BackgroundColor3 = Color3.fromRGB(61,61,61)
    teleportFrame.Size = UDim2.new(0, 296,0, 36)
    
    local teleportCorner = Instance.new("UICorner", teleportFrame)

    local teleportStroke = Instance.new("UIStroke", teleportFrame)
    teleportStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    teleportStroke.Color = Color3.fromRGB(255,255,255)

    local teleportBox = Instance.new("TextBox", teleportFrame)
    teleportBox.Text = ""
    teleportBox.Font = Enum.Font.ArimoBold
    teleportBox.BackgroundColor3 = Color3.fromRGB(61,61,61)
    teleportBox.Size = UDim2.new(0.41, 0,0.728, 0)
    teleportBox.Position = UDim2.new(0.559, 0,0.13, 0)
    teleportBox.PlaceholderText = "Username..."
    teleportBox.TextColor3 = Color3.fromRGB(255,255,255)
    teleportBox.TextScaled = true
    teleportBox.FocusLost:Connect(function(enter)
        if (enter) then
            TeleportPlayer(teleportBox.Text)
            teleportBox.Text = ""
        end
    end)

    local teleportBoxCorner = Instance.new("UICorner", teleportBox)

    local teleportBoxStroke = Instance.new("UIStroke", teleportBox)
    teleportBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    teleportBoxStroke.Color = Color3.fromRGB(255,255,255)

    local teleportLabel = Instance.new("TextLabel", teleportFrame)
    teleportLabel.Font = Enum.Font.ArimoBold
    teleportLabel.TextScaled = true
    teleportLabel.BackgroundTransparency = 1
    teleportLabel.Size = UDim2.new(0.494, 0,0.728, 0)
    teleportLabel.Position = UDim2.new(0.021, 0,0.13, 0)
    teleportLabel.Text = "Teleport"
    teleportLabel.TextColor3 = Color3.fromRGB(255,255,255)
    
    local ccTFrame = teleportFrame:Clone()
    ccTFrame.Parent = list
    ccTFrame.TextBox:Destroy()
    ccTFrame.TextLabel.Text = "Click to Teleport"
    CreateButton("CtoTeleport", ccTFrame, coreGui)

    local espFrame = teleportFrame:Clone()
    espFrame.Parent = list
    espFrame.TextBox:Destroy()
    espFrame.TextLabel.Text = "ESP"
    CreateButton("ESP", espFrame, coreGui)

    local chamsFrame = teleportFrame:Clone()
    chamsFrame.Parent = list
    chamsFrame.TextBox:Destroy()
    chamsFrame.TextLabel.Text = "Chams"
    CreateButton("Chams", chamsFrame, coreGui)

    local namesFrame = teleportFrame:Clone()
    namesFrame.Parent = list
    namesFrame.TextBox:Destroy()
    namesFrame.TextLabel.Text = "Bigger Names"
    CreateButton("Names", namesFrame, coreGui)

    local spinFrame = teleportFrame:Clone()
    spinFrame.Parent = list
    spinFrame.TextBox:Destroy()
    spinFrame.TextLabel.Text = "Spinbot"
    CreateButton("Spinbot", spinFrame, coreGui)

    local speedFrame = teleportFrame:Clone()
    speedFrame.Parent = list
    speedFrame.TextBox.PlaceholderText = "Value..."
    speedFrame.TextLabel.Text = "Speed"
    speedFrame.TextBox.FocusLost:Connect(function(enter)
        if (enter) then
            ToggleSpeed(false, 0)
            ToggleSpeed(true, speedFrame.TextBox.Text)
            speedFrame.TextBox.Text = ""
        end
    end)
    local speedClr = Instance.new("TextButton", speedFrame)
    speedClr.Size = UDim2.fromScale(.104, .802)
    speedClr.Position = UDim2.fromScale(.430,.1)
    speedClr.Font = Enum.Font.ArimoBold
    speedClr.BackgroundColor3 = Color3.fromRGB(61,61,61)
    speedClr.TextScaled = true
    speedClr.TextColor3 = Color3.fromRGB(255,0,0)
    speedClr.Text = "Clr"
    local speedClrStroke = Instance.new("UIStroke", speedClr)
    speedClrStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    speedClrStroke.Color = Color3.fromRGB(255,255,255)
    local speedClrCorner = Instance.new("UICorner", speedClr)
    speedClr.Activated:Connect(function()
        ToggleSpeed(false, 0)
    end)

    local jumpFrame = speedFrame:Clone()
    jumpFrame.Parent = list
    jumpFrame.TextLabel.Text = "Jump"
    jumpFrame.TextBox.FocusLost:Connect(function(enter)
        if (enter) then
            ToggleJump(false, 0)
            ToggleJump(true, jumpFrame.TextBox.Text)
            jumpFrame.TextBox.Text = ""
        end
    end)
    jumpFrame.TextButton.Activated:Connect(function()
        ToggleJump(false, 0)
    end)

    local glueFrame = speedFrame:Clone()
    glueFrame.Parent = list
    glueFrame.TextLabel.Text = "Glue"
    glueFrame.TextBox.PlaceholderText = "Username..."
    glueFrame.TextBox.FocusLost:Connect(function(enter)
        if (enter) then
            ToggleGlueHack(true, glueFrame.TextBox.Text)
            glueFrame.TextBox.Text = ""
        end
    end)
    glueFrame.TextButton.Activated:Connect(function()
        ToggleGlueHack(false, "")
    end)

    
    mainFrame.Parent = coreGui
end

InitUI()