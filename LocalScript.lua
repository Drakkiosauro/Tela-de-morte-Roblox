local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local pGui = player:WaitForChild("PlayerGui")

if pGui:FindFirstChild("DeathScreenUi") then
	pGui.DeathScreenUi:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeathScreenUi"
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 1000
screenGui.ResetOnSpawn = false
screenGui.Parent = pGui

local blur = Lighting:FindFirstChild("DeathBlur") or Instance.new("BlurEffect")
blur.Name = "DeathBlur"
blur.Size = 0
blur.Parent = Lighting

local cc = Lighting:FindFirstChild("DeathColor") or Instance.new("ColorCorrectionEffect")
cc.Name = "DeathColor"
cc.Saturation = 0
cc.Parent = Lighting

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
overlay.BackgroundTransparency = 1
overlay.Visible = false
overlay.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 80)
title.Position = UDim2.new(0, 0, 0.42, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "N E U T R A L I Z A D O"
title.Font = Enum.Font.GothamMedium
title.TextSize = 20
title.TextTransparency = 1
title.Parent = overlay

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 30)
sub.Position = UDim2.new(0, 0, 0.52, 0)
sub.BackgroundTransparency = 1
sub.TextColor3 = Color3.fromRGB(180, 180, 180)
sub.Text = "Sinal vital perdido. Reiniciando..."
sub.Font = Enum.Font.Gotham
sub.TextSize = 18
sub.TextTransparency = 1
sub.Parent = overlay

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 350, 0, 3)
barBg.Position = UDim2.new(0.5, -175, 0.6, 0)
barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barBg.BackgroundTransparency = 1
barBg.BorderSizePixel = 0
barBg.Parent = overlay

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local function deathSequence()
	local cam = workspace.CurrentCamera
	cam.CameraType = Enum.CameraType.Scriptable
	
	overlay.Visible = true
	
	TweenService:Create(blur, TweenInfo.new(0.6), {Size = 70}):Play()
	TweenService:Create(cc, TweenInfo.new(0.6), {Saturation = -1, Contrast = 0.2}):Play()
	TweenService:Create(overlay, TweenInfo.new(0.6), {BackgroundTransparency = 0.15}):Play()

	task.wait(0.3)
	TweenService:Create(title, TweenInfo.new(1.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0, TextSize = 45}):Play()

	task.wait(0.5)
	TweenService:Create(sub, TweenInfo.new(0.8), {TextTransparency = 0.5}):Play()

	task.wait(0.5)
	barBg.BackgroundTransparency = 0
	barFill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 4.5)

	task.wait(4.5)
end

local function init(char)
	local hum = char:WaitForChild("Humanoid")
	local cam = workspace.CurrentCamera
	
	cam.CameraType = Enum.CameraType.Custom
	cam.CameraSubject = hum
	
	blur.Size = 0
	cc.Saturation = 0
	cc.Contrast = 0
	
	overlay.Visible = false
	overlay.BackgroundTransparency = 1
	title.TextTransparency = 1
	sub.TextTransparency = 1
	barBg.BackgroundTransparency = 1
	barFill.Size = UDim2.new(0, 0, 1, 0)

	hum.Died:Connect(deathSequence)
end

player.CharacterAdded:Connect(init)
if player.Character then init(player.Character) end

-- Obrigado por ver esté codigo :)
