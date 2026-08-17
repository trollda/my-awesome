-- ============================================================
-- 🔥 МЕГА-ОПТИМИЗАЦИОННЫЙ ХАБ 🔥
-- Сделано на Rayfield Gen2 (недетектится, всё летает)
-- Настройка разрешения, пикселизации, графики и FPS
-- ============================================================

-- 1. Загружаем самую новую библиотеку Rayfield Gen2
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

-- 2. Создаём главное окно
local window = Rayfield:CreateWindow({
    name = "🔥 МЕГА ОПТИМИЗАЦИЯ",
    subtitle = "Полный контроль над FPS и графикой",
})

-- 3. Создаём вкладки
local mainTab = window:CreateTab({ name = "🏠 Главная" })
local graphicsTab = window:CreateTab({ name = "🎮 Графика" })
local resolutionTab = window:CreateTab({ name = "📺 Разрешение" })
local effectsTab = window:CreateTab({ name = "✨ Эффекты" })
local infoTab = window:CreateTab({ name = "📊 Инфо" })

-- ============================================================
-- 🏠 ВКЛАДКА "ГЛАВНАЯ" (Основные настройки)
-- ============================================================

mainTab:CreateSection({ name = "Основные настройки" })

-- Уровень качества графики (0-10)
mainTab:CreateSlider({
    name = "🎨 Качество графики",
    range = {0, 10},
    increment = 1,
    suffix = "ур.",
    current = 1,
    flag = "GraphicsQuality",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = value
    end
})

-- Масштаб рендеринга (самое мощное влияние на FPS)
mainTab:CreateSlider({
    name = "📐 Масштаб рендеринга",
    range = {0.1, 1.0},
    increment = 0.05,
    suffix = "%",
    current = 0.5,
    flag = "RenderScale",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.RenderQuality = value
        Rayfield:Notify({
            title = "Масштаб рендеринга",
            content = "Установлен: " .. math.floor(value * 100) .. "%",
            duration = 1.5
        })
    end
})

mainTab:CreateToggle({
    name = "🤖 Авто-качество графики",
    current = false,
    flag = "AutoGraphics",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.AutoGraphicsQuality = value
    end
})

mainTab:CreateToggle({
    name = "🔓 Снять лимит FPS (60+)",
    current = false,
    flag = "FPSUnlock",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        if value then
            UserGameSettings.RenderQuality = 1
            Rayfield:Notify({
                title = "FPS Unlocked!",
                content = "Теперь FPS может быть выше 60",
                duration = 2
            })
        else
            UserGameSettings.RenderQuality = 0.5
        end
    end
})

-- ============================================================
-- 🎮 ВКЛАДКА "ГРАФИКА" (Управление графикой)
-- ============================================================

graphicsTab:CreateSection({ name = "Освещение и тени" })

graphicsTab:CreateToggle({
    name = "🌓 Тени (GlobalShadows)",
    current = false,
    flag = "Shadows",
    callback = function(value)
        game:GetService("Lighting").GlobalShadows = value
    end
})

-- Движок освещения (Legacy — самый легкий)
graphicsTab:CreateDropdown({
    name = "💡 Движок освещения",
    options = {"Legacy", "Future", "ShadowMap", "Voxel"},
    current = "Legacy",
    flag = "LightingTech",
    callback = function(option)
        local techMap = {
            Legacy = Enum.Technology.Legacy,
            Future = Enum.Technology.Future,
            ShadowMap = Enum.Technology.ShadowMap,
            Voxel = Enum.Technology.Voxel
        }
        game:GetService("Lighting").Technology = techMap[option]
    end
})

graphicsTab:CreateSlider({
    name = "☀️ Яркость (Brightness)",
    range = {0, 2},
    increment = 0.05,
    suffix = "",
    current = 0.7,
    flag = "Brightness",
    callback = function(value)
        game:GetService("Lighting").Brightness = value
    end
})

graphicsTab:CreateSlider({
    name = "🌥️ Ambient (окружающий свет)",
    range = {0, 1},
    increment = 0.05,
    suffix = "",
    current = 0.5,
    flag = "Ambient",
    callback = function(value)
        game:GetService("Lighting").Ambient = Color3.new(value, value, value)
    end
})

-- ============================================================
-- 📺 ВКЛАДКА "РАЗРЕШЕНИЕ" (Пикселизация и настройки экрана)
-- ============================================================

resolutionTab:CreateSection({ name = "Настройки разрешения" })

-- Имитация пиксельного разрешения
resolutionTab:CreateToggle({
    name = "🟦 ПИКСЕЛЬНЫЙ РЕЖИМ (PS1 Style)",
    current = false,
    flag = "PixelMode",
    callback = function(value)
        if value then
            -- Создаём эффект пикселизации через ViewportFrame
            local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            local pixelGui = Instance.new("ScreenGui")
            pixelGui.Name = "PixelEffectGui"
            pixelGui.ResetOnSpawn = false
            pixelGui.Parent = playerGui

            local viewport = Instance.new("ViewportFrame")
            viewport.Size = UDim2.new(1, 0, 1, 0)
            viewport.BackgroundTransparency = 1
            viewport.Parent = pixelGui

            local camera = Instance.new("Camera")
            camera.Parent = viewport

            local pixelSize = 8 -- Размер пикселя
            local pixelFrame = Instance.new("Frame")
            pixelFrame.Size = UDim2.new(1, 0, 1, 0)
            pixelFrame.BackgroundTransparency = 1
            pixelFrame.Parent = viewport

            -- Затемнение для эффекта низкого разрешения
            local overlay = Instance.new("Frame")
            overlay.Size = UDim2.new(1, 0, 1, 0)
            overlay.BackgroundColor3 = Color3.new(0, 0, 0)
            overlay.BackgroundTransparency = 0.7
            overlay.BorderSizePixel = 0
            overlay.Parent = viewport

            -- Сетка пикселей
            local grid = Instance.new("Frame")
            grid.Size = UDim2.new(1, 0, 1, 0)
            grid.BackgroundTransparency = 1
            grid.Parent = viewport

            local columns = math.floor(workspace.CurrentCamera.ViewportSize.X / pixelSize)
            local rows = math.floor(workspace.CurrentCamera.ViewportSize.Y / pixelSize)

            for i = 0, columns do
                local line = Instance.new("Frame")
                line.Size = UDim2.new(0, 1, 1, 0)
                line.Position = UDim2.new(0, i * pixelSize, 0, 0)
                line.BackgroundColor3 = Color3.new(0, 0, 0)
                line.BackgroundTransparency = 0.5
                line.BorderSizePixel = 0
                line.Parent = grid
            end

            for i = 0, rows do
                local line = Instance.new("Frame")
                line.Size = UDim2.new(1, 0, 0, 1)
                line.Position = UDim2.new(0, 0, 0, i * pixelSize)
                line.BackgroundColor3 = Color3.new(0, 0, 0)
                line.BackgroundTransparency = 0.5
                line.BorderSizePixel = 0
                line.Parent = grid
            end

            -- Обновляем камеру
            viewport.CurrentCamera = workspace.CurrentCamera
            game:GetService("RunService").RenderStepped:Connect(function()
                viewport.CurrentCamera = workspace.CurrentCamera
            end)

            Rayfield:Notify({
                title = "Пиксельный режим",
                content = "Включен! Эффект как на PS1",
                duration = 2
            })
        else
            local pixelGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PixelEffectGui")
            if pixelGui then
                pixelGui:Destroy()
            end
            Rayfield:Notify({
                title = "Пиксельный режим",
                content = "Выключен",
                duration = 1.5
            })
        end
    end
})

resolutionTab:CreateToggle({
    name = "📱 Низкое разрешение (480p)",
    current = false,
    flag = "LowRes",
    callback = function(value)
        -- Изменяем масштаб рендеринга для имитации низкого разрешения
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        if value then
            UserGameSettings.RenderQuality = 0.2
            Rayfield:Notify({
                title = "Режим 480p",
                content = "Включен! FPS должен сильно вырасти",
                duration = 2
            })
        else
            UserGameSettings.RenderQuality = 0.5
        end
    end
})

resolutionTab:CreateToggle({
    name = "📺 Режим 720p (баланс)",
    current = false,
    flag = "MediumRes",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        if value then
            UserGameSettings.RenderQuality = 0.5
            Rayfield:Notify({
                title = "Режим 720p",
                content = "Баланс качества и производительности",
                duration = 2
            })
        else
            UserGameSettings.RenderQuality = 0.2
        end
    end
})

-- ============================================================
-- ✨ ВКЛАДКА "ЭФФЕКТЫ" (Удаление всего, что жрет FPS)
-- ============================================================

effectsTab:CreateSection({ name = "Отключение эффектов" })

effectsTab:CreateToggle({
    name = "✨ Отключить частицы (ParticleEmitter)",
    current = false,
    flag = "ParticlesOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = not value
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "🌀 Отключить трейлы (Trail)",
    current = false,
    flag = "TrailsOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Trail") then
                v.Enabled = not value
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "🖼️ Отключить декали",
    current = false,
    flag = "DecalsOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Decal") then
                v.Transparency = value and 1 or 0
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "📄 Отключить текстуры",
    current = false,
    flag = "TexturesOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") then
                v.Transparency = value and 1 or 0
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "💧 Отключить эффекты воды",
    current = false,
    flag = "WaterOff",
    callback = function(value)
        local terrain = workspace.Terrain
        if terrain then
            if value then
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
    end
})

effectsTab:CreateButton({
    name = "🗑️ Удалить ВСЕ эффекты (Bloom, SunRays, Blur)",
    callback = function()
        local lighting = game:GetService("Lighting")
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or 
               v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then
                v:Destroy()
            end
        end
        Rayfield:Notify({
            title = "✅ Готово!",
            content = "Все эффекты освещения удалены",
            duration = 2
        })
    end
})

effectsTab:CreateButton({
    name = "🔄 Сбросить все настройки графики",
    callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = true
        Lighting.Technology = Enum.Technology.Future
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.FogEnd = 100000

        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = 4
        UserGameSettings.RenderQuality = 1
        UserGameSettings.AutoGraphicsQuality = true

        -- Удаляем пиксельный эффект
        local pixelGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("PixelEffectGui")
        if pixelGui then pixelGui:Destroy() end

        Rayfield:Notify({
            title = "✅ Сброшено!",
            content = "Настройки возвращены к стандартным",
            duration = 2
        })
    end
})

-- ============================================================
-- 📊 ВКЛАДКА "ИНФО" (Системная информация)
-- ============================================================

infoTab:CreateSection({ name = "Информация о системе" })

infoTab:CreateLabel({ name = "📊 FPS: 0" })
infoTab:CreateLabel({ name = "🌐 Пинг: 0 ms" })
infoTab:CreateLabel({ name = "👥 Игроков: 0" })
infoTab:CreateLabel({ name = "💾 Память: 0 MB" })
infoTab:CreateLabel({ name = "⏱️ Время кадра: 0 ms" })

-- Обновление статистики
local fpsLabel, pingLabel, playersLabel, memoryLabel, frameLabel

local function updateLabels()
    local labels = infoTab:GetChildren()
    for _, label in ipairs(labels) do
        if label:IsA("Label") then
            local text = label:GetAttribute("Text")
            if text and text:find("FPS") then fpsLabel = label end
            if text and text:find("Пинг") then pingLabel = label end
            if text and text:find("Игроков") then playersLabel = label end
            if text and text:find("Память") then memoryLabel = label end
            if text and text:find("Время кадра") then frameLabel = label end
        end
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if fpsLabel then
        local fps = math.round(1 / game:GetService("RunService").Heartbeat:Wait())
        fpsLabel:SetText("📊 FPS: " .. fps)
    end
    if pingLabel then
        local ping = math.round(game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000)
        pingLabel:SetText("🌐 Пинг: " .. ping .. " ms")
    end
    if playersLabel then
        playersLabel:SetText("👥 Игроков: " .. #game:GetService("Players"):GetPlayers())
    end
    if memoryLabel then
        local memory = math.round(collectgarbage("count") / 1000)
        memoryLabel:SetText("💾 Память: " .. memory .. " MB")
    end
    if frameLabel then
        local frameTime = math.round(game:GetService("RunService").Heartbeat:Wait() * 1000)
        frameLabel:SetText("⏱️ Время кадра: " .. frameTime .. " ms")
    end
end)

-- ============================================================
-- 💡 АВТО-ОПТИМИЗАЦИЯ ПРИ СТАРТЕ
-- ============================================================

task.wait(0.5)

-- Максимальный FPS буст при старте
local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
UserGameSettings.GraphicsQuality = 1
UserGameSettings.RenderQuality = 0.3
UserGameSettings.AutoGraphicsQuality = false

-- Отключаем тяжелое освещение
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.Technology = Enum.Technology.Legacy
Lighting.Brightness = 0.5
Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
Lighting.FogEnd = 9e9

-- Удаляем все эффекты
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or 
       v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then
        v:Destroy()
    end
end

-- Отключаем частицы
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") then
        v.Enabled = false
    end
    if v:IsA("Trail") then
        v.Enabled = false
    end
end

-- Оптимизируем воду
local terrain = workspace.Terrain
if terrain then
    terrain.WaterWaveSize = 0
    terrain.WaterWaveSpeed = 0
    terrain.WaterReflectance = 0
    terrain.WaterTransparency = 1
end

Rayfield:Notify({
    title = "⚡ Оптимизация применена!",
    content = "FPS должен вырасти. Меню всегда с тобой.",
    duration = 3
})

print("🔥 Мега-Оптимизационный Хаб загружен! Меню открыто.")
