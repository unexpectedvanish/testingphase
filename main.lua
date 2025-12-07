--/ Services
local Players = game:GetService("Players")
local runService = game:GetService("RunService")
local ts = game:GetService("TweenService")

local p = Players.LocalPlayer
local pGui = p:WaitForChild("PlayerGui")

--{}[]

local variables = {
    CtoTeleport = false,
    ESP = false,
    Aimbot = false,
    Spintbot = false
}

local function CreateButton(name, parent)
    local barFrame = Instance.new("CanvasGroup", parent)
    barFrame.Size = UDim2.new(0.197, 0,0.64, 0)
    barFrame.Position = UDim2.new(0.728, 0,0.162, 0)

    local corner = Instance.new("UICorner", barFrame)

    local stroke = Instance.new("UIStroke", barFrame)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    stroke.Color = Color3.fromRGB(255,255,255)

    local button = Instance.new("TextButton", barFrame)
    button.Name = name
    button.TextLabel = ""
    button.Size = UDim2.new(0.391, 0,1, 0)
    button.Position = UDim2.new(0.609, 0,0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255,0,0)

    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = Udim.new(1,0)
end

local function InitUI()
    if (not pGui) then return end
    local coreGui = Instance.new("ScreenGui")
    coreGui.ResetOnSpawn = false
    coreGui.Parent = pGui

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
    CreateButton("CtoTeleport", ccTFrame)
    
    mainFrame.Parent = coreGui
end

InitUI()

local functions = {
    
}