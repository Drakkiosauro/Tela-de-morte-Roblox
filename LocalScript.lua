local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local guiName = "DeathScreenUi"

if player:WaitForChild("PlayerGui"):FindFirstChild(guiName) then
	player.PlayerGui[guiName]:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = guiName
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 1000
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Name = "DeathBlur"
blur.Parent = Lighting

local colorCorrection = Instance.new("ColorCorrectionEffect")
colorCorrection.Saturation = 0
colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
colorCorrection.Name = "DeathColor"
colorCorrection.Parent = Lighting

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
mainFrame.BackgroundTransparency = 1
mainFrame.Parent = screenGui

local container = Instance.new("Frame")
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundTransparency = 1
container.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 0, 80)
titleText.Position = UDim2.new(0, 0, 0.42, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Text = "N E U T R A L I Z A D O"
titleText.Font = Enum.Font.GothamMedium
titleText.TextSize = 0 
titleText.TextTransparency = 1
titleText.Parent = container

local subtitleText = Instance.new("TextLabel")
subtitleText.Size = UDim2.new(1, 0, 0, 30)
subtitleText.Position = UDim2.new(0, 0, 0.52, 0)
subtitleText.BackgroundTransparency = 1
subtitleText.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitleText.Text = "Sinal vital perdido. Reiniciando..."
subtitleText.Font = Enum.Font.Gotham
subtitleText.TextSize = 18
subtitleText.TextTransparency = 1
subtitleText.Parent = container

local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(0, 350, 0, 3)
progressBarBg.Position = UDim2.new(0.5, -175, 0.6, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
progressBarBg.BackgroundTransparency = 1
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = container

local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
progressBarFill.BorderSizePixel = 0
progressBarFill.Parent = progressBarBg

local function onDeath()
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Scriptable

	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = 0
		player.Character.Humanoid.JumpPower = 0
	end

	mainFrame.Visible = true
	mainFrame.BackgroundTransparency = 1
	titleText.TextTransparency = 1
	titleText.TextSize = 20
	subtitleText.TextTransparency = 1
	progressBarBg.BackgroundTransparency = 1
	progressBarFill.Size = UDim2.new(0, 0, 1, 0)

	TweenService:Create(blur, TweenInfo.new(0.5), {Size = 50}):Play()
	TweenService:Create(colorCorrection, TweenInfo.new(0.5), {Saturation = -1, Contrast = 0.2}):Play()
	TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0.2}):Play()

	task.wait(0.2)

	local textTween = TweenService:Create(titleText, 
		TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), 
		{TextTransparency = 0, TextSize = 45}
	)
	textTween:Play()

	task.wait(0.5)
	TweenService:Create(subtitleText, TweenInfo.new(0.8), {TextTransparency = 0.5}):Play()

	task.wait(0.5)
	TweenService:Create(progressBarBg, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

	progressBarFill:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Linear, Enum.EasingStyle.Linear, 4.5)

	task.wait(4.5)

	TweenService:Create(titleText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
	TweenService:Create(subtitleText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
	TweenService:Create(progressBarBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(progressBarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
	TweenService:Create(mainFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
end

local function setup(char)
	local camera = workspace.CurrentCamera
	camera.CameraType = Enum.CameraType.Custom
	camera.CameraSubject = char:WaitForChild("Humanoid")

	TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
	TweenService:Create(colorCorrection, TweenInfo.new(1), {Saturation = 0, Contrast = 0}):Play()
	mainFrame.Visible = false

	local hum = char:WaitForChild("Humanoid")
	hum.Died:Connect(onDeath)
end

if player.Character then setup(player.Character) end
player.CharacterAdded:Connect(setup)

-- Obrigado por ver esté codigo :)
