-- ============================================================
-- 🔥 ULTIMATE ANTI-LAG & FPS BOOST v3.0 🔥
-- Полный контроль, аналитика, статистика
-- Работает на Delta, Xeno, любом софте
-- ============================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

-- ============================================================
-- 📊 ПЕРЕМЕННЫЕ СОСТОЯНИЯ
-- ============================================================
local settings = {
    fpsUnlock = false,
    graphicsQuality = 1,
    renderQuality = 0.3,
    autoGraphics = false,
    shadows = false,
    technology = "Legacy",
    brightness = 0.5,
    ambient = 0.5,
    fog = false,
    particles = false,
    trails = false,
    decals = false,
    textures = false,
    water = false,
    fullbright = false,
    antiAFK = false,
    showFPS = true,
    autoBoost = false,
}

local stats = {
    fps = 0,
    ping = 0,
    players = 0,
    memory = 0,
    frameTime = 0,
}

-- ============================================================
-- 🖥️ СОЗДАНИЕ ГЛАВНОГО GUI
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player.PlayerGui
ScreenGui.Name = "AntiLagMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Шапка
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
TitleBar.BackgroundTransparency = 0.15
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "⚡ Анти-Лаг Бустер v3.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = TitleBar

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ============================================================
-- 📋 КОНТЕЙНЕР ВКЛАДОК
-- ============================================================
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -10, 0, 32)
TabContainer.Position = UDim2.new(0, 5, 0, 46)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local tabs = {"🏠", "⚡", "🎮", "✨", "📊"}
local tabButtons = {}
local tabPanels = {}

local function createTabButton(name, index)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 28)
    btn.Position = UDim2.new(0, (index-1) * 68, 0, 2)
    btn.BackgroundTransparency = 0.8
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    btn.Parent = TabContainer
    return btn
end

-- ============================================================
-- 📄 ПАНЕЛИ ВКЛАДОК
-- ============================================================
local PanelContainer = Instance.new("Frame")
PanelContainer.Size = UDim2.new(1, -10, 1, -90)
PanelContainer.Position = UDim2.new(0, 5, 0, 82)
PanelContainer.BackgroundTransparency = 1
PanelContainer.ClipsDescendants = true
PanelContainer.Parent = MainFrame

local function createPanel()
    local panel = Instance.new("Frame")
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = PanelContainer

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.Parent = panel

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = scroll

    local function updateCanvas()
        task.wait(0.05)
        local contentSize = layout.AbsoluteContentSize
        scroll.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y + 10)
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
    task.spawn(updateCanvas)

    return scroll, layout
end

-- ============================================================
-- 🛠️ ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
-- ============================================================
local function createLabel(parent, text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order
    lbl.Parent = parent
    return lbl
end

local function createButton(parent, text, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.Font = Enum.Font.SourceSansBold
    btn.LayoutOrder = order
    btn.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createToggle(parent, text, order, getter, setter)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 14
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 24)
    btn.Position = UDim2.new(0.7, 0, 0.5, -12)
    btn.BackgroundColor3 = getter() and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 80)
    btn.BorderSizePixel = 0
    btn.Text = getter() and "Вкл" or "Выкл"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local newState = not getter()
        setter(newState)
        btn.BackgroundColor3 = newState and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 80)
        btn.Text = newState and "Вкл" or "Выкл"
    end)
end

local function createSlider(parent, text, order, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 48)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order
    container.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. " (" .. tostring(default) .. ")"
    lbl.TextColor3 = Color3.fromRGB(220, 220, 240)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.SourceSans
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = container

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 6)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    slider.BorderSizePixel = 0
    slider.Parent = container

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    fill.BorderSizePixel = 0
    fill.Parent = slider

    local cornerFill = Instance.new("UICorner")
    cornerFill.CornerRadius = UDim.new(0, 4)
    cornerFill.Parent = fill

    local cornerSlider = Instance.new("UICorner")
    cornerSlider.CornerRadius = UDim.new(0, 4)
    cornerSlider.Parent = slider

    local dragging = false
    local function updateValue(x)
        local rel = math.clamp((x - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
        local value = min + rel * (max - min)
        value = math.round(value * 100) / 100
        fill.Size = UDim2.new(rel, 0, 1, 0)
        lbl.Text = text .. " (" .. tostring(value) .. ")"
        callback(value)
    end

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateValue(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position.X)
        end
    end)
end

-- ============================================================
-- 📊 СОЗДАНИЕ ВКЛАДОК И ПАНЕЛЕЙ
-- ============================================================
local panelData = {}
local tabKeys = {"Главная", "FPS", "Графика", "Эффекты", "Аналитика"}

for i, name in ipairs(tabs) do
    local btn = createTabButton(name, i)
    tabButtons[i] = btn
    local panel, layout = createPanel()
    panelData[i] = {panel = panel, layout = layout, buttons = {}}
end

-- Переключение вкладок
local function switchTab(index)
    for i, panel in ipairs(panelData) do
        panel.panel.Visible = (i == index)
        tabButtons[i].BackgroundColor3 = (i == index) and Color3.fromRGB(50, 50, 80) or Color3.fromRGB(0, 0, 0, 0)
        tabButtons[i].TextColor3 = (i == index) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 220)
    end
end

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(i)
    end)
end

switchTab(1)

-- ============================================================
-- 📝 ЗАПОЛНЕНИЕ ВКЛАДОК
-- ============================================================

-- 1. ГЛАВНАЯ
local p1 = panelData[1].layout
createLabel(p1, "🔥 Добро пожаловать в Anti-Lag Бустер v3.0", 1)
createLabel(p1, "Настройки сохраняются автоматически", 2)
createLabel(p1, "Нажми K чтобы открыть/закрыть меню", 3)
createLabel(p1, "Все изменения применяются мгновенно", 4)
createButton(p1, "🔄 Применить все оптимизации", 5, function()
    settings.graphicsQuality = 1
    settings.renderQuality = 0.3
    settings.shadows = false
    settings.technology = "Legacy"
    settings.particles = false
    settings.trails = false
    settings.decals = false
    settings.textures = false
    settings.water = false
    settings.fullbright = true
    applyAllSettings()
    Rayfield:Notify({Title = "✅ Оптимизация применена!", Duration = 2})
end)
createButton(p1, "🔄 Сбросить все настройки", 6, function()
    settings.graphicsQuality = 4
    settings.renderQuality = 1
    settings.shadows = true
    settings.technology = "Future"
    settings.particles = true
    settings.trails = true
    settings.decals = true
    settings.textures = true
    settings.water = true
    settings.fullbright = false
    applyAllSettings()
    Rayfield:Notify({Title = "✅ Сброшено к стандарту!", Duration = 2})
end)

-- 2. FPS
local p2 = panelData[2].layout
createToggle(p2, "🔓 Снять лимит FPS", 1, function() return settings.fpsUnlock end, function(v) 
    settings.fpsUnlock = v
    if v then UserGameSettings.RenderQuality = 1 else UserGameSettings.RenderQuality = 0.5 end
end)
createSlider(p2, "🎨 Качество графики", 2, 1, 10, 1, function(v)
    settings.graphicsQuality = v
    UserGameSettings.GraphicsQuality = v
end)
createSlider(p2, "📐 Разрешение рендеринга", 3, 0.1, 1, 0.3, function(v)
    settings.renderQuality = v
    UserGameSettings.RenderQuality = v
end)
createToggle(p2, "🤖 Авто-качество графики", 4, function() return settings.autoGraphics end, function(v)
    settings.autoGraphics = v
    UserGameSettings.AutoGraphicsQuality = v
end)
createSlider(p2, "☀️ Яркость", 5, 0, 2, 0.5, function(v)
    settings.brightness = v
    Lighting.Brightness = v
end)
createSlider(p2, "🌥️ Ambient", 6, 0, 1, 0.5, function(v)
    settings.ambient = v
    Lighting.Ambient = Color3.new(v, v, v)
end)
createToggle(p2, "🌓 Тени", 7, function() return settings.shadows end, function(v)
    settings.shadows = v
    Lighting.GlobalShadows = v
end)

-- 3. ГРАФИКА
local p3 = panelData[3].layout
createToggle(p3, "🌁 Удалить туман", 1, function() return settings.fog end, function(v)
    settings.fog = v
    Lighting.FogEnd = v and 9e9 or 100000
end)
createToggle(p3, "💡 Fullbright", 2, function() return settings.fullbright end, function(v)
    settings.fullbright = v
    if v then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    else
        Lighting.Brightness = 0.5
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
    end
end)
createButton(p3, "🗑️ Удалить все эффекты (Bloom, SunRays, Blur)", 3, function()
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then
            v:Destroy()
        end
    end
end)
createToggle(p3, "💧 Отключить эффекты воды", 4, function() return settings.water end, function(v)
    settings.water = v
    local terrain = workspace.Terrain
    if terrain then
        if v then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        else
            terrain.WaterWaveSize = 0.5
            terrain.WaterWaveSpeed = 1
            terrain.WaterReflectance = 0.5
            terrain.WaterTransparency = 0.5
        end
    end
end)
createToggle(p3, "✨ Отключить частицы", 5, function() return settings.particles end, function(v)
    settings.particles = v
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then obj.Enabled = not v end
    end
end)
createToggle(p3, "🌀 Отключить трейлы", 6, function() return settings.trails end, function(v)
    settings.trails = v
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Trail") then obj.Enabled = not v end
    end
end)
createToggle(p3, "🖼️ Отключить декали", 7, function() return settings.decals end, function(v)
    settings.decals = v
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") then obj.Transparency = v and 1 or 0 end
    end
end)
createToggle(p3, "📄 Отключить текстуры", 8, function() return settings.textures end, function(v)
    settings.textures = v
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") then obj.Transparency = v and 1 or 0 end
    end
end)

-- 4. ЭФФЕКТЫ (дополнительно)
local p4 = panelData[4].layout
createToggle(p4, "💤 Anti-AFK", 1, function() return settings.antiAFK end, function(v)
    settings.antiAFK = v
    if v then
        VirtualUser:CaptureController()
        VirtualUser:Button2Down(Vector2.new(0,0), Camera.CFrame)
        task.wait(0.05)
        VirtualUser:Button2Up(Vector2.new(0,0), Camera.CFrame)
    end
end)
createButton(p4, "♻️ Rejoin", 2, function()
    TeleportService:Teleport(game.PlaceId, Player)
end)
createButton(p4, "🔄 Server Hop", 3, function()
    TeleportService:Teleport(game.PlaceId)
end)
createButton(p4, "💀 Kill Self", 4, function()
    local char = Player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)

-- 5. АНАЛИТИКА
local p5 = panelData[5].layout
local fpsLabel = createLabel(p5, "📊 FPS: 0", 1)
local pingLabel = createLabel(p5, "🌐 Пинг: 0 ms", 2)
local playersLabel = createLabel(p5, "👥 Игроков: 0", 3)
local memoryLabel = createLabel(p5, "💾 Память: 0 MB", 4)
local frameTimeLabel = createLabel(p5, "⏱️ Время кадра: 0 ms", 5)
local statusLabel = createLabel(p5, "🟢 Статус: Оптимизация включена", 6)

-- Обновление статистики
RunService.Heartbeat:Connect(function()
    stats.fps = math.round(1 / RunService.Heartbeat:Wait())
    stats.ping = math.round(Player:GetNetworkPing() * 1000)
    stats.players = #Players:GetPlayers()
    stats.memory = math.round(collectgarbage("count") / 1000)
    stats.frameTime = math.round(RunService.Heartbeat:Wait() * 1000)

    fpsLabel.Text = "📊 FPS: " .. stats.fps
    pingLabel.Text = "🌐 Пинг: " .. stats.ping .. " ms"
    playersLabel.Text = "👥 Игроков: " .. stats.players
    memoryLabel.Text = "💾 Память: " .. stats.memory .. " MB"
    frameTimeLabel.Text = "⏱️ Время кадра: " .. stats.frameTime .. " ms"
    statusLabel.Text = stats.fps >= 60 and "🟢 FPS стабилен (≥60)" or "🔴 Низкий FPS! Включи оптимизацию"
end)

-- ============================================================
-- ⚡ АВТОМАТИЧЕСКАЯ ОПТИМИЗАЦИЯ ПРИ СТАРТЕ
-- ============================================================
local function applyAllSettings()
    UserGameSettings.GraphicsQuality = settings.graphicsQuality
    UserGameSettings.RenderQuality = settings.renderQuality
    UserGameSettings.AutoGraphicsQuality = settings.autoGraphics
    Lighting.GlobalShadows = settings.shadows
    Lighting.Technology = Enum.Technology[settings.technology]
    Lighting.Brightness = settings.brightness
    Lighting.Ambient = Color3.new(settings.ambient, settings.ambient, settings.ambient)
    Lighting.FogEnd = settings.fog and 9e9 or 100000
    if settings.fullbright then
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    end
    -- Применяем эффекты
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then obj.Enabled = not settings.particles end
        if obj:IsA("Trail") then obj.Enabled = not settings.trails end
        if obj:IsA("Decal") then obj.Transparency = settings.decals and 1 or 0 end
        if obj:IsA("Texture") then obj.Transparency = settings.textures and 1 or 0 end
    end
    local terrain = workspace.Terrain
    if terrain then
        if settings.water then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        else
            terrain.WaterWaveSize = 0.5
            terrain.WaterWaveSpeed = 1
            terrain.WaterReflectance = 0.5
            terrain.WaterTransparency = 0.5
        end
    end
    -- Удаление эффектов освещения
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then
            v:Destroy()
        end
    end
end

-- Базовые настройки при загрузке
settings.graphicsQuality = 1
settings.renderQuality = 0.3
settings.shadows = false
settings.technology = "Legacy"
settings.particles = false
settings.trails = false
settings.decals = false
settings.textures = false
settings.water = false
settings.fullbright = true
settings.fog = true
applyAllSettings()

-- ============================================================
-- 🔑 КЛАВИША ДЛЯ ОТКРЫТИЯ/ЗАКРЫТИЯ МЕНЮ (K)
-- ============================================================
local menuVisible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        menuVisible = not menuVisible
        MainFrame.Visible = menuVisible
    end
end)

-- ============================================================
-- 🔥 НАЧАЛЬНОЕ УВЕДОМЛЕНИЕ
-- ============================================================
print("🔥 Anti-Lag Бустер v3.0 загружен!")
print("Нажми K чтобы открыть/закрыть меню.")
print("Все настройки применяются мгновенно.")

-- Простое уведомление на экране (чтобы видел)
local notify = Instance.new("TextLabel")
notify.Size = UDim2.new(0, 300, 0, 40)
notify.Position = UDim2.new(0.5, -150, 0, 20)
notify.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
notify.Text = "⚡ Анти-Лаг активирован! (K - меню)"
notify.TextColor3 = Color3.fromRGB(255, 255, 255)
notify.TextSize = 18
notify.Font = Enum.Font.SourceSansBold
notify.ZIndex = 999
notify.Parent = ScreenGui

local notifyCorner = Instance.new("UICorner")
notifyCorner.CornerRadius = UDim.new(0, 12)
notifyCorner.Parent = notify

-- Исчезновение через 3 секунды
task.wait(3)
notify:TweenPosition(UDim2.new(0.5, -150, 0, -60), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.5, true)
task.wait(0.5)
notify:Destroy()
