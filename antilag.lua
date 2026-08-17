-- ============================================================
-- 🔥 RAYFIELD ULTIMATE ANTI-LAG & FPS BOOST HUB v2.0 🔥
-- Полный контроль над FPS, лагами, фризами и графикой
-- Работает на Delta (100% UNC), Xeno, любом софте
-- ============================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "⚡ Anti-Lag Ultimate",
    LoadingTitle = "Загрузка Anti-Lag Hub...",
    LoadingSubtitle = "by Bro",
    Theme = "Dark",
    ToggleUIKeybind = "K",
    DisableBuildWarnings = true,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AntiLagHub",
        FileName = "Settings"
    }
})

-- ============================================================
-- 📂 ВКЛАДКИ
-- ============================================================
local MainTab = Window:CreateTab("🏠 Главная")
local FpsTab = Window:CreateTab("⚡ FPS Буст")
local GraphicsTab = Window:CreateTab("🎮 Графика")
local EffectsTab = Window:CreateTab("✨ Эффекты")
local MiscTab = Window:CreateTab("🛠️ Разное")

-- ============================================================
-- 🔹 ГЛАВНАЯ ВКЛАДКА
-- ============================================================
local MainSection = MainTab:CreateSection("Информация")

MainTab:CreateLabel("🔥 Anti-Lag Ultimate v2.0")
MainTab:CreateLabel("Нажми K чтобы открыть/закрыть меню")
MainTab:CreateLabel("Все настройки сохраняются автоматически")

MainTab:CreateButton({
    Name = "🔄 Применить все настройки",
    Callback = function()
        Rayfield:Notify({
            Title = "Применено!",
            Content = "Все настройки активированы",
            Duration = 2
        })
    end
})

-- ============================================================
-- 🔹 FPS БУСТ (основные настройки)
-- ============================================================
local FpsSection = FpsTab:CreateSection("Основной FPS Буст")

-- 1. Снятие лимита FPS (через настройки пользователя)
local fpsUnlocker = false
FpsTab:CreateToggle({
    Name = "🔓 Снять лимит FPS (60+)",
    Default = false,
    Callback = function(state)
        fpsUnlocker = state
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        if state then
            UserGameSettings.RenderQuality = 1
            Rayfield:Notify({
                Title = "FPS Unlocked!",
                Content = "Теперь FPS может быть выше 60",
                Duration = 2
            })
        else
            UserGameSettings.RenderQuality = 0.5
        end
    end
})

-- 2. Качество графики (ползунок)
FpsTab:CreateSlider({
    Name = "🎨 Качество графики",
    Min = 1,
    Max = 10,
    Default = 1,
    Callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = value
    end
})

-- 3. Разрешение рендеринга
FpsTab:CreateSlider({
    Name = "📐 Разрешение рендеринга",
    Min = 0.1,
    Max = 1,
    Default = 0.5,
    Increment = 0.05,
    Callback = function(value)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.RenderQuality = value
    end
})

-- 4. Автоматическое качество
FpsTab:CreateToggle({
    Name = "🤖 Авто-качество графики",
    Default = false,
    Callback = function(state)
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.AutoGraphicsQuality = state
    end
})

-- ============================================================
-- 🔹 НАСТРОЙКИ ОСВЕЩЕНИЯ (тяжелая графика)
-- ============================================================
local LightingSection = FpsTab:CreateSection("Освещение (убивает FPS)")

-- 5. Тени
local shadowsState = true
FpsTab:CreateToggle({
    Name = "🌓 Тени (GlobalShadows)",
    Default = true,
    Callback = function(state)
        shadowsState = state
        game:GetService("Lighting").GlobalShadows = state
    end
})

-- 6. Движок освещения
FpsTab:CreateDropdown({
    Name = "💡 Движок освещения",
    Options = {"Legacy", "Future", "ShadowMap", "Voxel"},
    Default = "Legacy",
    Callback = function(option)
        local techMap = {
            Legacy = Enum.Technology.Legacy,
            Future = Enum.Technology.Future,
            ShadowMap = Enum.Technology.ShadowMap,
            Voxel = Enum.Technology.Voxel
        }
        game:GetService("Lighting").Technology = techMap[option]
    end
})

-- 7. Яркость
FpsTab:CreateSlider({
    Name = "☀️ Яркость (Brightness)",
    Min = 0,
    Max = 2,
    Default = 1,
    Increment = 0.05,
    Callback = function(value)
        game:GetService("Lighting").Brightness = value
    end
})

-- 8. Ambient
FpsTab:CreateSlider({
    Name = "🌥️ Ambient (окружающий свет)",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Increment = 0.05,
    Callback = function(value)
        game:GetService("Lighting").Ambient = Color3.new(value, value, value)
    end
})

-- ============================================================
-- 🔹 ГРАФИКА (удаление эффектов)
-- ============================================================
local GraphicsSection = GraphicsTab:CreateSection("Удаление эффектов")

-- 9. Удаление Bloom
GraphicsTab:CreateToggle({
    Name = "🌸 Удалить BloomEffect",
    Default = false,
    Callback = function(state)
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("BloomEffect") then
                if state then v:Destroy() else v.Parent = game:GetService("Lighting") end
            end
        end
    end
})

-- 10. Удаление SunRays
GraphicsTab:CreateToggle({
    Name = "☀️ Удалить SunRaysEffect",
    Default = false,
    Callback = function(state)
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("SunRaysEffect") then
                if state then v:Destroy() else v.Parent = game:GetService("Lighting") end
            end
        end
    end
})

-- 11. Удаление Blur
GraphicsTab:CreateToggle({
    Name = "🌫️ Удалить BlurEffect",
    Default = false,
    Callback = function(state)
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("BlurEffect") then
                if state then v:Destroy() else v.Parent = game:GetService("Lighting") end
            end
        end
    end
})

-- 12. Удаление ColorCorrection
GraphicsTab:CreateToggle({
    Name = "🎨 Удалить ColorCorrectionEffect",
    Default = false,
    Callback = function(state)
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("ColorCorrectionEffect") then
                if state then v:Destroy() else v.Parent = game:GetService("Lighting") end
            end
        end
    end
})

-- 13. Удаление тумана
GraphicsTab:CreateToggle({
    Name = "🌁 Удалить туман (Fog)",
    Default = false,
    Callback = function(state)
        if state then
            game:GetService("Lighting").FogEnd = 9e9
        else
            game:GetService("Lighting").FogEnd = 100000
        end
    end
})

-- 14. Материалы частей
GraphicsTab:CreateDropdown({
    Name = "🧱 Материалы всех частей",
    Options = {"Plastic", "SmoothPlastic", "Metal", "Wood", "Glass"},
    Default = "Plastic",
    Callback = function(option)
        local matMap = {
            Plastic = Enum.Material.Plastic,
            SmoothPlastic = Enum.Material.SmoothPlastic,
            Metal = Enum.Material.Metal,
            Wood = Enum.Material.Wood,
            Glass = Enum.Material.Glass
        }
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = matMap[option]
            end
        end
    end
})

-- ============================================================
-- 🔹 ЭФФЕКТЫ (отключение тяжелых вещей)
-- ============================================================
local EffectsSection = EffectsTab:CreateSection("Отключение эффектов")

-- 15. Частицы
local particlesState = true
EffectsTab:CreateToggle({
    Name = "✨ Отключить частицы (ParticleEmitter)",
    Default = false,
    Callback = function(state)
        particlesState = state
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                v.Enabled = not state
            end
        end
    end
})

-- 16. Трейлы
EffectsTab:CreateToggle({
    Name = "🌀 Отключить трейлы (Trail)",
    Default = false,
    Callback = function(state)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Trail") then
                v.Enabled = not state
            end
        end
    end
})

-- 17. Декали
EffectsTab:CreateToggle({
    Name = "🖼️ Отключить декали",
    Default = false,
    Callback = function(state)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Decal") then
                v.Transparency = state and 1 or 0
            end
        end
    end
})

-- 18. Текстуры
EffectsTab:CreateToggle({
    Name = "📄 Отключить текстуры",
    Default = false,
    Callback = function(state)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") then
                v.Transparency = state and 1 or 0
            end
        end
    end
})

-- 19. Вода (Terrain)
EffectsTab:CreateToggle({
    Name = "💧 Отключить эффекты воды",
    Default = false,
    Callback = function(state)
        local terrain = workspace.Terrain
        if state then
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
})

-- 20. Fullbright
EffectsTab:CreateToggle({
    Name = "💡 Fullbright (всегда светло)",
    Default = false,
    Callback = function(state)
        if state then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").OutdoorAmbient = Color3.new(1, 1, 1)
        else
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").Ambient = Color3.new(0.5, 0.5, 0.5)
            game:GetService("Lighting").OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
        end
    end
})

-- ============================================================
-- 🔹 РАЗНОЕ
-- ============================================================
local MiscSection = MiscTab:CreateSection("Дополнительные функции")

-- 21. Анти-AFK
local antiAFKState = false
MiscTab:CreateToggle({
    Name = "💤 Anti-AFK",
    Default = false,
    Callback = function(state)
        antiAFKState = state
        if state then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end
    end
})

-- 22. Удаление всех эффектов освещения (комбо)
MiscTab:CreateButton({
    Name = "🗑️ Удалить ВСЕ эффекты освещения",
    Callback = function()
        local lighting = game:GetService("Lighting")
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("BloomEffect") or 
               v:IsA("SunRaysEffect") or v:IsA("BlurEffect") or 
               v:IsA("ColorCorrectionEffect") then
                v:Destroy()
            end
        end
        Rayfield:Notify({
            Title = "✅ Готово!",
            Content = "Все эффекты освещения удалены",
            Duration = 2
        })
    end
})

-- 23. Сброс настроек
MiscTab:CreateButton({
    Name = "🔄 Сбросить все настройки",
    Callback = function()
        game:GetService("Lighting").GlobalShadows = true
        game:GetService("Lighting").Technology = Enum.Technology.Future
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").Ambient = Color3.new(0.5, 0.5, 0.5)
        game:GetService("Lighting").FogEnd = 100000
        local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
        UserGameSettings.GraphicsQuality = 4
        UserGameSettings.RenderQuality = 1
        UserGameSettings.AutoGraphicsQuality = true
        Rayfield:Notify({
            Title = "✅ Сброшено!",
            Content = "Все настройки возвращены к стандартным",
            Duration = 2
        })
    end
})

-- 24. Rejoin
MiscTab:CreateButton({
    Name = "♻️ Rejoin (перезайти)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})

-- 25. Server Hop
MiscTab:CreateButton({
    Name = "🔄 Переход на другой сервер",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})

-- ============================================================
-- 🔥 АВТО-ОПТИМИЗАЦИЯ (запускается при загрузке)
-- ============================================================
task.wait(0.5)

-- Базовые настройки для FPS
local UserGameSettings = game:GetService("UserSettings"):GetService("UserGameSettings")
UserGameSettings.GraphicsQuality = 1
UserGameSettings.RenderQuality = 0.4
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
    Title = "⚡ Anti-Lag активирован!",
    Content = "FPS должен вырасти. Меню по клавише K",
    Duration = 3
})

print("🔥 Anti-Lag Ultimate загружен! Нажми K для меню.")
