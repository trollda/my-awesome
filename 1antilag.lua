-- =============================================================
-- 🔥 МЕГА-ОПТИМИЗАТОР 3000 🔥
-- Самая мощная оптимизация для Roblox в 2026
-- Сделано на Rayfield Gen2
-- =============================================================

-- 1. Загружаем библиотеку Rayfield Gen2
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

-- 2. Создаём главное окно
local window = Rayfield:CreateWindow({
    name = "🔥 МЕГА ОПТИМИЗАТОР 3000",
    subtitle = "Полный контроль над FPS, графикой и системой",
})

-- ============================================================
-- 📂 СОЗДАНИЕ ВКЛАДОК
-- ============================================================
local mainTab = window:CreateTab({ name = "🏠 Главная" })
local graphicsTab = window:CreateTab({ name = "🎮 Графика" })
local effectsTab = window:CreateTab({ name = "✨ Эффекты" })
local systemTab = window:CreateTab({ name = "💻 Система" })
local networkTab = window:CreateTab({ name = "🌐 Сеть" })
local infoTab = window:CreateTab({ name = "📊 Инфо" })

-- ============================================================
-- 🏠 ВКЛАДКА "ГЛАВНАЯ"
-- ============================================================
mainTab:CreateSection({ name = "⚡ Быстрый старт" })

mainTab:CreateButton({
    name = "🚀 МАКСИМАЛЬНЫЙ FPS (Всё в ноль)",
    callback = function()
        -- Графика в ноль
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = 0
        UserGameSettings.RenderQuality = 0.1
        UserGameSettings.AutoGraphicsQuality = false
        
        -- Освещение в ноль
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.Technology = Enum.Technology.Legacy
        Lighting.Brightness = 0.3
        Lighting.Ambient = Color3.new(0.3, 0.3, 0.3)
        Lighting.FogEnd = 9e9
        Lighting.OutdoorAmbient = Color3.new(0.3, 0.3, 0.3)
        
        -- Удаляем все эффекты
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or 
               v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or
               v:IsA("DepthOfFieldEffect") or v:IsA("RimLightEffect") then
                v:Destroy()
            end
        end
        
        -- Отключаем всё что можно
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") then v.Enabled = false end
            if v:IsA("Trail") then v.Enabled = false end
            if v:IsA("Smoke") then v.Enabled = false end
            if v:IsA("Fire") then v.Enabled = false end
            if v:IsA("Sparkles") then v.Enabled = false end
            if v:IsA("Decal") then v.Transparency = 1 end
            if v:IsA("Texture") then v.Transparency = 1 end
            if v:IsA("BasePart") and v.Material ~= Enum.Material.Plastic then
                v.Material = Enum.Material.Plastic
            end
        end
        
        -- Выключаем воду
        local terrain = workspace.Terrain
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end
        
        Rayfield:Notify({
            title = "🚀 Максимальный FPS!",
            content = "Все настройки выкручены на минимум",
            duration = 2
        })
    end
})

mainTab:CreateButton({
    name = "🔄 Сбросить всё к стандарту",
    callback = function()
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = 4
        UserGameSettings.RenderQuality = 1
        UserGameSettings.AutoGraphicsQuality = true
        
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = true
        Lighting.Technology = Enum.Technology.Future
        Lighting.Brightness = 1
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.FogEnd = 100000
        Lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        
        local terrain = workspace.Terrain
        if terrain then
            terrain.WaterWaveSize = 0.5
            terrain.WaterWaveSpeed = 1
            terrain.WaterReflectance = 0.5
            terrain.WaterTransparency = 0.5
        end
        
        Rayfield:Notify({
            title = "✅ Сброшено!",
            content = "Настройки возвращены к стандартным",
            duration = 2
        })
    end
})

-- ============================================================
-- 🎮 ВКЛАДКА "ГРАФИКА"
-- ============================================================
graphicsTab:CreateSection({ name = "Основные настройки" })

graphicsTab:CreateSlider({
    name = "🎨 Качество графики (0-10)",
    range = {0, 10},
    increment = 1,
    suffix = "ур.",
    current = 1,
    flag = "GraphicsQuality",
    callback = function(value)
        game:GetService("UserSettings"):GetService("UserGameSettings").GraphicsQuality = value
    end
})

graphicsTab:CreateSlider({
    name = "📐 Масштаб рендеринга",
    range = {0.05, 1.0},
    increment = 0.05,
    suffix = "%",
    current = 0.3,
    flag = "RenderScale",
    callback = function(value)
        game:GetService("UserSettings"):GetService("UserGameSettings").RenderQuality = value
        Rayfield:Notify({
            title = "Масштаб рендеринга",
            content = math.floor(value * 100) .. "%",
            duration = 1
        })
    end
})

graphicsTab:CreateToggle({
    name = "🤖 Авто-качество графики",
    current = false,
    flag = "AutoGraphics",
    callback = function(value)
        game:GetService("UserSettings"):GetService("UserGameSettings").AutoGraphicsQuality = value
    end
})

graphicsTab:CreateToggle({
    name = "🔓 Снять лимит FPS",
    current = false,
    flag = "FPSUnlock",
    callback = function(value)
        if value then
            game:GetService("UserSettings"):GetService("UserGameSettings").RenderQuality = 1
        end
    end
})

graphicsTab:CreateSection({ name = "Освещение" })

graphicsTab:CreateToggle({
    name = "🌓 Тени (GlobalShadows)",
    current = false,
    flag = "Shadows",
    callback = function(value)
        game:GetService("Lighting").GlobalShadows = value
    end
})

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
    current = 0.5,
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
    current = 0.4,
    flag = "Ambient",
    callback = function(value)
        game:GetService("Lighting").Ambient = Color3.new(value, value, value)
    end
})

graphicsTab:CreateSlider({
    name = "🌫️ Туман (FogEnd)",
    range = {100, 100000},
    increment = 100,
    suffix = "студий",
    current = 9000000000,
    flag = "FogEnd",
    callback = function(value)
        game:GetService("Lighting").FogEnd = value
    end
})

graphicsTab:CreateSection({ name = "Материалы" })

graphicsTab:CreateDropdown({
    name = "🧱 Материалы всех частей",
    options = {"Plastic", "SmoothPlastic", "Metal", "Wood", "Glass", "Neon"},
    current = "Plastic",
    flag = "Materials",
    callback = function(option)
        local matMap = {
            Plastic = Enum.Material.Plastic,
            SmoothPlastic = Enum.Material.SmoothPlastic,
            Metal = Enum.Material.Metal,
            Wood = Enum.Material.Wood,
            Glass = Enum.Material.Glass,
            Neon = Enum.Material.Neon
        }
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = matMap[option]
            end
        end
    end
})

-- ============================================================
-- ✨ ВКЛАДКА "ЭФФЕКТЫ"
-- ============================================================
effectsTab:CreateSection({ name = "Отключение эффектов" })

effectsTab:CreateToggle({
    name = "✨ Отключить частицы (ParticleEmitter)",
    current = true,
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
    current = true,
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
    name = "🔥 Отключить огонь (Fire)",
    current = true,
    flag = "FireOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Fire") then
                v.Enabled = not value
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "💨 Отключить дым (Smoke)",
    current = true,
    flag = "SmokeOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Smoke") then
                v.Enabled = not value
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "✨ Отключить искры (Sparkles)",
    current = true,
    flag = "SparklesOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Sparkles") then
                v.Enabled = not value
            end
        end
    end
})

effectsTab:CreateToggle({
    name = "🖼️ Отключить декали",
    current = true,
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
    current = true,
    flag = "TexturesOff",
    callback = function(value)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") then
                v.Transparency = value and 1 or 0
            end
        end
    end
})

effectsTab:CreateSection({ name = "Вода" })

effectsTab:CreateToggle({
    name = "💧 Отключить эффекты воды",
    current = true,
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

effectsTab:CreateSection({ name = "Пост-эффекты" })

effectsTab:CreateButton({
    name = "🗑️ Удалить ВСЕ пост-эффекты",
    callback = function()
        local lighting = game:GetService("Lighting")
        local count = 0
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or 
               v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or
               v:IsA("DepthOfFieldEffect") or v:IsA("RimLightEffect") or
               v:IsA("Atmosphere") then
                v:Destroy()
                count = count + 1
            end
        end
        Rayfield:Notify({
            title = "✅ Удалено " .. count .. " эффектов!",
            content = "FPS должен вырасти",
            duration = 2
        })
    end
})

-- ============================================================
-- 💻 ВКЛАДКА "СИСТЕМА"
-- ============================================================
systemTab:CreateSection({ name = "Управление ресурсами" })

systemTab:CreateToggle({
    name = "💤 Anti-AFK",
    current = false,
    flag = "AntiAFK",
    callback = function(value)
        if value then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end
    end
})

systemTab:CreateToggle({
    name = "🔇 Отключить звук (экономия CPU)",
    current = false,
    flag = "SoundOff",
    callback = function(value)
        if value then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Sound") then
                    v.Volume = 0
                end
            end
            game:GetService("SoundService").RespectFilteringEnabled = false
            for _, v in pairs(game:GetService("SoundService"):GetChildren()) do
                if v:IsA("Sound") then
                    v.Volume = 0
                end
            end
        else
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Sound") then
                    v.Volume = 1
                end
            end
            game:GetService("SoundService").RespectFilteringEnabled = true
            for _, v in pairs(game:GetService("SoundService"):GetChildren()) do
                if v:IsA("Sound") then
                    v.Volume = 1
                end
            end
        end
    end
})

systemTab:CreateToggle({
    name = "🧊 Очистка памяти (сборка мусора)",
    current = false,
    flag = "GC",
    callback = function(value)
        if value then
            game:GetService("RunService").Heartbeat:Connect(function()
                if math.random(1, 100) > 95 then
                    collectgarbage("collect")
                end
            end)
            Rayfield:Notify({
                title = "✅ Сборка мусора активна",
                content = "Память будет очищаться автоматически",
                duration = 2
            })
        end
    end
})

systemTab:CreateSection({ name = "Разрешение экрана" })

systemTab:CreateToggle({
    name = "📱 Режим 480p (макс FPS)",
    current = false,
    flag = "LowRes",
    callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        if value then
            UserGameSettings.RenderQuality = 0.1
            Rayfield:Notify({
                title = "Режим 480p",
                content = "Включен! Максимальный FPS",
                duration = 1.5
            })
        else
            UserGameSettings.RenderQuality = 0.3
        end
    end
})

systemTab:CreateToggle({
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
                duration = 1.5
            })
        else
            UserGameSettings.RenderQuality = 0.1
        end
    end
})

systemTab:CreateToggle({
    name = "🟦 ПИКСЕЛЬНЫЙ РЕЖИМ (PS1 Style)",
    current = false,
    flag = "PixelMode",
    callback = function(value)
        local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        local pixelGui = playerGui:FindFirstChild("PixelEffectGui")
        
        if value and not pixelGui then
            local newPixelGui = Instance.new("ScreenGui")
            newPixelGui.Name = "PixelEffectGui"
            newPixelGui.ResetOnSpawn = false
            newPixelGui.Parent = playerGui
            
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.BackgroundTransparency = 0.6
            frame.BorderSizePixel = 0
            frame.Parent = newPixelGui
            
            -- Сетка пикселей
            local grid = Instance.new("Frame")
            grid.Size = UDim2.new(1, 0, 1, 0)
            grid.BackgroundTransparency = 1
            grid.Parent = newPixelGui
            
            local pixelSize = 10
            local viewport = workspace.CurrentCamera.ViewportSize
            local cols = math.floor(viewport.X / pixelSize)
            local rows = math.floor(viewport.Y / pixelSize)
            
            for i = 0, cols do
                local line = Instance.new("Frame")
                line.Size = UDim2.new(0, 1, 1, 0)
                line.Position = UDim2.new(0, i * pixelSize, 0, 0)
                line.BackgroundColor3 = Color3.new(0, 0, 0)
                line.BackgroundTransparency = 0.4
                line.BorderSizePixel = 0
                line.Parent = grid
            end
            
            for i = 0, rows do
                local line = Instance.new("Frame")
                line.Size = UDim2.new(1, 0, 0, 1)
                line.Position = UDim2.new(0, 0, 0, i * pixelSize)
                line.BackgroundColor3 = Color3.new(0, 0, 0)
                line.BackgroundTransparency = 0.4
                line.BorderSizePixel = 0
                line.Parent = grid
            end
            
            Rayfield:Notify({
                title = "Пиксельный режим",
                content = "Включен! Эффект как на PS1",
                duration = 2
            })
        elseif not value and pixelGui then
            pixelGui:Destroy()
            Rayfield:Notify({
                title = "Пиксельный режим",
                content = "Выключен",
                duration = 1.5
            })
        end
    end
})

-- ============================================================
-- 🌐 ВКЛАДКА "СЕТЬ"
-- ============================================================
networkTab:CreateSection({ name = "Настройки сети" })

networkTab:CreateToggle({
    name = "🌐 Стабилизация пинга",
    current = false,
    flag = "PingStab",
    callback = function(value)
        if value then
            settings().Network.IncomingReplicationLag = -1000
            Rayfield:Notify({
                title = "Пинг стабилизирован!",
                content = "IncomingReplicationLag = -1000",
                duration = 2
            })
        else
            settings().Network.IncomingReplicationLag = 0
        end
    end
})

networkTab:CreateToggle({
    name = "⚡ Оптимизация сетевых пакетов",
    current = false,
    flag = "NetworkOpt",
    callback = function(value)
        if value then
            settings().Network.AllowClientServerMovement = false
            Rayfield:Notify({
                title = "Сетевая оптимизация",
                content = "Включена",
                duration = 1.5
            })
        else
            settings().Network.AllowClientServerMovement = true
        end
    end
})

-- ============================================================
-- 📊 ВКЛАДКА "ИНФО" (Мониторинг)
-- ============================================================
infoTab:CreateSection({ name = "Системный мониторинг" })

local fpsLabel = infoTab:CreateLabel({ name = "📊 FPS: 0" })
local pingLabel = infoTab:CreateLabel({ name = "🌐 Пинг: 0 ms" })
local playersLabel = infoTab:CreateLabel({ name = "👥 Игроков: 0" })
local memoryLabel = infoTab:CreateLabel({ name = "💾 Память: 0 MB" })
local frameLabel = infoTab:CreateLabel({ name = "⏱️ Время кадра: 0 ms" })
local gpuLabel = infoTab:CreateLabel({ name = "🖥️ GPU: -" })

infoTab:CreateSection({ name = "Быстрые действия" })

infoTab:CreateButton({
    name = "♻️ Rejoin",
    callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})

infoTab:CreateButton({
    name = "🔄 Server Hop",
    callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

infoTab:CreateButton({
    name = "💀 Kill Self",
    callback = function()
        local char = game:GetService("Players").LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
            end
        end
    end
})

-- Обновление статистики в реальном времени
game:GetService("RunService").Heartbeat:Connect(function()
    local fps = math.round(1 / game:GetService("RunService").Heartbeat:Wait())
    local ping = math.round(game:GetService("Players").LocalPlayer:GetNetworkPing() * 1000)
    local players = #game:GetService("Players"):GetPlayers()
    local memory = math.round(collectgarbage("count") / 1000)
    local frameTime = math.round(game:GetService("RunService").Heartbeat:Wait() * 1000)
    
    fpsLabel:SetText("📊 FPS: " .. fps)
    pingLabel:SetText("🌐 Пинг: " .. ping .. " ms")
    playersLabel:SetText("👥 Игроков: " .. players)
    memoryLabel:SetText("💾 Память: " .. memory .. " MB")
    frameLabel:SetText("⏱️ Время кадра: " .. frameTime .. " ms")
    
    if fps >= 60 then
        gpuLabel:SetText("🖥️ Статус: ✅ Отлично")
    elseif fps >= 30 then
        gpuLabel:SetText("🖥️ Статус: ⚠️ Нормально")
    else
        gpuLabel:SetText("🖥️ Статус: ❌ Включи оптимизацию!")
    end
end)

-- ============================================================
-- ⚡ АВТО-ОПТИМИЗАЦИЯ ПРИ СТАРТЕ
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
       v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or
       v:IsA("DepthOfFieldEffect") then
        v:Destroy()
    end
end

-- Отключаем частицы, трейлы, огонь, дым
for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") then v.Enabled = false end
    if v:IsA("Trail") then v.Enabled = false end
    if v:IsA("Fire") then v.Enabled = false end
    if v:IsA("Smoke") then v.Enabled = false end
    if v:IsA("Sparkles") then v.Enabled = false end
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
    title = "⚡ МЕГА ОПТИМИЗАЦИЯ АКТИВИРОВАНА!",
    content = "FPS должен сильно вырасти. Меню всегда с тобой.",
    duration = 4
})

print("🔥 МЕГА-ОПТИМИЗАТОР 3000 загружен! Меню открыто.")
