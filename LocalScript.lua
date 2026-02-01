local Plrs = game:GetService("Players") local Tw = game:GetService("TweenService") local Ligh = game:GetService("Lighting")

local plr = Plrs.LocalPlayer local pGui = plr:WaitForChild("PlayerGui")

if pGui:FindFirstChild("DeathScreenUi") then pGui.DeathScreenUi:Destroy() end

local sg = Instance.new("ScreenGui") sg.Name = "DeathScreenUi" sg.IgnoreGuiInset = true sg.DisplayOrder = 1000 sg.ResetOnSpawn = false sg.Parent = pGui

local bl = Ligh:FindFirstChild("DeathBlur") or Instance.new("BlurEffect") bl.Name = "DeathBlur" bl.Size = 0 bl.Parent = Ligh

local cc = Ligh:FindFirstChild("DeathColor") or Instance.new("ColorCorrectionEffect") cc.Name = "DeathColor" cc.Saturation = 0 cc.Parent = Ligh

local f = Instance.new("Frame") f.Size = UDim2.new(1, 0, 1, 0) f.BackgroundColor3 = Color3.fromRGB(5, 5, 5) f.BackgroundTransparency = 1 f.Visible = false f.Parent = sg

local t1 = Instance.new("TextLabel") t1.Size = UDim2.new(1, 0, 0, 80) t1.Position = UDim2.new(0, 0, 0.42, 0) t1.BackgroundTransparency = 1 t1.TextColor3 = Color3.new(1,1,1) t1.Text = "N E U T R A L I Z A D O" t1.Font = 'GothamMedium' t1.TextSize = 20 t1.TextTransparency = 1 t1.Parent = f

local t2 = Instance.new("TextLabel") t2.Size = UDim2.new(1, 0, 0, 30) t2.Position = UDim2.new(0, 0, 0.52, 0) t2.BackgroundTransparency = 1 t2.TextColor3 = Color3.fromRGB(180, 180, 180) t2.Text = "Sinal vital perdido. Reiniciando..." t2.Font = Enum.Font.Gotham t2.TextSize = 18 t2.TextTransparency = 1 t2.Parent = f

local b_bg = Instance.new("Frame") b_bg.Size = UDim2.new(0, 350, 0, 3) b_bg.Position = UDim2.new(0.5, -175, 0.6, 0) b_bg.BackgroundColor3 = Color3.fromRGB(40, 40, 40) b_bg.BackgroundTransparency = 1 b_bg.BorderSizePixel = 0 b_bg.Parent = f

local b_fill = Instance.new("Frame") b_fill.Size = UDim2.new(0, 0, 1, 0) b_fill.BackgroundColor3 = Color3.new(1,1,1) b_fill.BorderSizePixel = 0 b_fill.Parent = b_bg

local function on_death() local cam = workspace.CurrentCamera cam.CameraType = 'Scriptable'

f.Visible = true

Tw:Create(bl, TweenInfo.new(0.6), {Size = 70}):Play()
Tw:Create(cc, TweenInfo.new(0.6), {Saturation = -1, Contrast = 0.2}):Play()
Tw:Create(f, TweenInfo.new(0.6), {BackgroundTransparency = 0.15}):Play()

task.wait(0.3)
Tw:Create(t1, TweenInfo.new(1.2, 7, 0), {TextTransparency = 0, TextSize = 45}):Play()

task.wait(0.5)
Tw:Create(t2, TweenInfo.new(0.8), {TextTransparency = 0.5}):Play()

task.wait(0.5)
b_bg.BackgroundTransparency = 0
b_fill:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Linear", 4.5)

task.wait(4.5)
end

local function setup(char) local hum = char:WaitForChild("Humanoid") local cam = workspace.CurrentCamera

cam.CameraType = Enum.CameraType.Custom
cam.CameraSubject = hum

bl.Size = 0
cc.Saturation = 0
cc.Contrast = 0

f.Visible = false
f.BackgroundTransparency = 1
t1.TextTransparency = 1
t2.TextTransparency = 1
b_bg.BackgroundTransparency = 1
b_fill.Size = UDim2.new(0, 0, 1, 0)

hum.Died:Connect(on_death)
end

plr.CharacterAdded:Connect(setup) if plr.Character then setup(plr.Character) end

-- Tamo junto por ver esté codigo ❤️
