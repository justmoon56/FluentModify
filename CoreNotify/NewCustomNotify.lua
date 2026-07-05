local FluentModify = {}

function FluentModify:CountdownNotify(config)
    local title = config.Title or "Notification"
    local content = config.Content or ""
    local baseSubContent = config.SubContent or "info"
    local ntype = config.Type or "Info"
    local duration = config.Duration or 5

    task.spawn(function()
        for i = duration, 1, -1 do
            Fluent:Notify({
                Title = title,
                Content = content,
                SubContent = baseSubContent .. " " .. i .. "s",
                Type = ntype,
                Duration = 0.8
            })
            if i > 1 then
                task.wait(1)
            end
        end
    end)
end

function FluentModify:CustomNotify(config)
    config = config or {}
    local titleText = config.Title or "Notification"
    local contentText = config.Content or ""
    local subContentText = config.SubContent or ""
    local notificationType = config.Type or "Info"
    local duration = config.Duration or 5

    local players = game:GetService("Players")
    local tweenService = game:GetService("TweenService")
    local runService = game:GetService("RunService")
    local localPlayer = players.LocalPlayer
    local playerGui = localPlayer:WaitForChild("PlayerGui")

    local typeColorMap = {
        Info = Color3.fromRGB(76, 194, 255),
        Success = Color3.fromRGB(50, 205, 80),
        Warning = Color3.fromRGB(255, 185, 30),
        Error = Color3.fromRGB(220, 55, 55),
    }

    local stripeColor = typeColorMap[notificationType] or typeColorMap.Info

    local folderName = "MyInterfaceManager" 
    local fileName = folderName .. "/options.json"
    local activeTheme = ""

    pcall(function()
        if isfile and isfile(fileName) then
            local HttpService = game:GetService("HttpService")
            local fileContent = readfile(fileName)
            local data = HttpService:JSONDecode(fileContent)
            if data and data.Theme then
                activeTheme = data.Theme
            end
        end
    end)

    local themePresets = {
        ["Darker"] = {
            Accent=Color3.fromRGB(255,255,255),
            AcrylicMain=Color3.fromRGB(0,0,0),
            AcrylicBorder=Color3.fromRGB(20,20,20),
            AcrylicGradient=ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0)),
            AcrylicNoise=1,
            Element=Color3.fromRGB(10,10,10),
            ElementBorder=Color3.fromRGB(0,0,0),
            InElementBorder=Color3.fromRGB(30,30,30),
            ElementTransparency=0.96,
            Text=Color3.fromRGB(255,255,255),
            SubText=Color3.fromRGB(150,150,150),
            ShineEnabled=false,
            Shine={
                Speed=0,
                RotationSpeed=0,
                ColorSequence=ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0))
            },
            StrokeShine=false,
            StrokeDark=Color3.fromRGB(18,18,18),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(10,10,10)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,30)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(60,60,60)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(30,30,30))
                })
            },
            Background=nil,
            BackgroundTransparency=0,
            ThemeAccentColors={Color3.fromRGB(255,255,255)},
        },     
        ["RGB"] = {
            Accent=Color3.fromRGB(0,255,180),
            AcrylicMain=Color3.fromRGB(8,8,14),
            AcrylicBorder=Color3.fromRGB(0,255,180),
            AcrylicGradient=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(20,0,40)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(0,20,50)),ColorSequenceKeypoint.new(1,Color3.fromRGB(30,0,30))}),
            AcrylicNoise=0.95,
            Element=Color3.fromRGB(20,20,35),
            ElementBorder=Color3.fromRGB(5,5,12),
            InElementBorder=Color3.fromRGB(0,200,160),
            ElementTransparency=0.88,
            Text=Color3.fromRGB(220,255,245),
            SubText=Color3.fromRGB(100,220,190),
            ShineEnabled=true,
            Shine={
                Speed=1.2,
                RotationSpeed=40,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,180)),
                    ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,0,255)),
                    ColorSequenceKeypoint.new(0.66,Color3.fromRGB(255,0,150)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,255,180))
                })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(0,180,140),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,40,30)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,20,15))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(0,255,180)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(120,0,255)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(0,255,180))
                })
            },
            Background=nil,
            BackgroundTransparency=0, IsRGB=true,
            ThemeAccentColors={Color3.fromRGB(0,255,180),Color3.fromRGB(120,0,255),Color3.fromRGB(255,0,150)},
        },
        ["Neon Cyber"] = {
            Accent=Color3.fromRGB(57,255,20),
            AcrylicMain=Color3.fromRGB(5,10,5),
            AcrylicBorder=Color3.fromRGB(40,200,20),
            AcrylicGradient=ColorSequence.new(Color3.fromRGB(10,25,10),Color3.fromRGB(3,8,3)),
            AcrylicNoise=0.93,
            Element=Color3.fromRGB(10,22,10),
            ElementBorder=Color3.fromRGB(3,8,3),
            InElementBorder=Color3.fromRGB(35,160,15),
            ElementTransparency=0.88,
            Text=Color3.fromRGB(200,255,190),
            SubText=Color3.fromRGB(80,200,60),
            ShineEnabled=true,
            Shine={
                Speed=0.8,
                RotationSpeed=30,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(5,30,5)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(57,255,20)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(5,30,5))
                })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(35,160,15),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(8,22,8)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(3,8,3))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(35,160,15)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(57,255,20)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(35,160,15))
                })
            },
            Background=nil,
            BackgroundTransparency=0,
            ThemeAccentColors={Color3.fromRGB(57,255,20)},
        },
        ["Arctic Frost"] = {
            Accent=Color3.fromRGB(100,180,240),
            AcrylicMain=Color3.fromRGB(185,215,235),
            AcrylicBorder=Color3.fromRGB(200,228,248),
            AcrylicGradient=ColorSequence.new(Color3.fromRGB(235,248,255), Color3.fromRGB(210,235,250)),
            AcrylicNoise=0.97,
            Element=Color3.fromRGB(210,235,250),
            ElementBorder=Color3.fromRGB(170,200,225),
            InElementBorder=Color3.fromRGB(140,185,218),
            ElementTransparency=0.65,
            Text=Color3.fromRGB(20,40,70),
            SubText=Color3.fromRGB(65,105,148),
            ShineEnabled=true,
            Shine={
                Speed=0.3,
                RotationSpeed=15,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(200,235,255)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(200,235,255))
                })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(170,210,238),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(190,225,248)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(220,240,255))
                 }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(150,200,235)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(200,235,255)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(150,200,235))
                 })
             },
             Background=nil,
             BackgroundTransparency=0,
             ThemeAccentColors={Color3.fromRGB(100,180,240)},
        },
        ["Cotton Candy"] = {
            Accent=Color3.fromRGB(255,130,190),
            AcrylicMain=Color3.fromRGB(255,225,245),
            AcrylicBorder=Color3.fromRGB(255,190,230),
            AcrylicGradient=ColorSequence.new(Color3.fromRGB(255,235,250),Color3.fromRGB(235,210,255)),
            AcrylicNoise=0.96,
            Element=Color3.fromRGB(255,200,235),
            ElementBorder=Color3.fromRGB(230,165,210),
            InElementBorder=Color3.fromRGB(235,170,215),
            ElementTransparency=0.70,
            Text=Color3.fromRGB(75,25,55),
            SubText=Color3.fromRGB(145,75,115),
            ShineEnabled=true,
            Shine={
                Speed=0.4,
                RotationSpeed=18,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(255,180,220)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(220,180,255)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(255,180,220))
                })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(228,172,213),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(250,198,232)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(232,182,252))
                }),
                Stroke=ColorSequence.new({
                       ColorSequenceKeypoint.new(0,Color3.fromRGB(228,172,213)),
                       ColorSequenceKeypoint.new(0.5,Color3.fromRGB(250,198,232)),
                       ColorSequenceKeypoint.new(1,Color3.fromRGB(228,172,213))
                })
            },
            Background=nil,
            BackgroundTransparency=0,
            ThemeAccentColors={Color3.fromRGB(255,130,190),Color3.fromRGB(175,140,255)},
        },
        ["Orange"] = {
            Accent=Color3.fromRGB(255,140,30),
            AcrylicMain=Color3.fromRGB(4,4,4),
            AcrylicBorder=Color3.fromRGB(200,90,10),
            AcrylicGradient=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(30,10,0)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(10,5,0)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))}),
            AcrylicNoise=0.98,
            Element=Color3.fromRGB(22,10,2),
            ElementBorder=Color3.fromRGB(80,35,5),
            InElementBorder=Color3.fromRGB(200,90,10),
            ElementTransparency=0.92,
            Text=Color3.fromRGB(255,240,220),
            SubText=Color3.fromRGB(220,175,130),
            Shine={
                Speed=0.7,
                RotationSpeed=30,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(30,10,0)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,140,30)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(30,10,0))
                })
            },
            StrokeDark=Color3.fromRGB(180,80,10),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(40,18,4)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(8,3,0))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(180,80,10)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(180,140,25)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(180,80,10))
                })
            },
            Background=nil,
            BackgroundTransparency=0.05,
            ThemeAccentColors={Color3.fromRGB(255,140,30),Color3.fromRGB(200,90,10)},
        },
        ["Cyanic"] = {
            Accent=Color3.fromRGB(57,197,187),
            AcrylicMain=Color3.fromRGB(8,18,22),
            AcrylicBorder=Color3.fromRGB(40,170,165),
            AcrylicGradient=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(15,45,55)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(8,25,32)),ColorSequenceKeypoint.new(1,Color3.fromRGB(4,12,16))}),
            AcrylicNoise=0.92,
            Element=Color3.fromRGB(14,38,46),
            ElementBorder=Color3.fromRGB(8,22,28),
            InElementBorder=Color3.fromRGB(40,165,160),
            ElementTransparency=0.88,
            Text=Color3.fromRGB(210,248,246),
            SubText=Color3.fromRGB(130,210,205),
            ShineEnabled=true,
            Shine={
                Speed=0.6,
                RotationSpeed=25,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(10,40,50)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(57,197,187)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(10,40,50))
                 })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(35,155,150),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(18,55,65)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(8,22,28))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(35,155,150)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(57,197,187)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(35,155,150))
                })
            },
            Background=nil,
            BackgroundTransparency=0.12,
            ThemeAccentColors={Color3.fromRGB(57,197,187),Color3.fromRGB(35,155,150)},
        },
        ["Amber Glow"] = {
            Accent=Color3.fromRGB(255,170,40),
            AcrylicMain=Color3.fromRGB(18,10,4),
            AcrylicBorder=Color3.fromRGB(200,130,30),
            AcrylicGradient=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(50,25,5)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(28,14,3)),ColorSequenceKeypoint.new(1,Color3.fromRGB(10,5,1))}),
            AcrylicNoise=0.9,
            Element=Color3.fromRGB(38,20,5),
            ElementBorder=Color3.fromRGB(18,10,2),
            InElementBorder=Color3.fromRGB(200,130,30),
            ElementTransparency=0.88,
            Text=Color3.fromRGB(255,245,225),
            SubText=Color3.fromRGB(230,195,145),
            ShineEnabled=true,
            Shine={
                Speed=0.6,
                RotationSpeed=25,
                ColorSequence=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(50,22,4)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,170,40)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(50,22,4))
                })
            },
            StrokeShine=true,
            StrokeDark=Color3.fromRGB(185,120,25),
            ButtonGradient={
                Background=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(60,30,6)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(22,10,2))
                }),
                Stroke=ColorSequence.new({
                    ColorSequenceKeypoint.new(0,Color3.fromRGB(185,120,25)),
                    ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,170,40)),
                    ColorSequenceKeypoint.new(1,Color3.fromRGB(185,120,25))
                })
            },
            Background=nil,
            BackgroundTransparency=0.12,
            ThemeAccentColors={Color3.fromRGB(255,170,40),Color3.fromRGB(200,130,30)},
        },
        ["Deep Violet"] = {
            Accent = Color3.fromRGB(97, 62, 167),
            AcrylicMain = Color3.fromRGB(20, 20, 20),
            AcrylicBorder = Color3.fromRGB(110, 90, 130),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(85, 57, 139), Color3.fromRGB(40, 25, 65)),
            AcrylicNoise = 0.92,
            Element = Color3.fromRGB(140, 120, 160),
            ElementBorder = Color3.fromRGB(60, 50, 70),
            InElementBorder = Color3.fromRGB(100, 90, 110),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(240, 240, 240),
            SubText = Color3.fromRGB(170, 170, 170),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.5,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 25, 65)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 120, 220)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 25, 65))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(110, 90, 130),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 25, 65)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 120, 220))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 25, 65)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 120, 220)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 25, 65))
                })
            },
            Background = nil,
            BackgroundTransparency = 0.15,
        },
        ["Ash Gray"] = {
            Accent = Color3.fromRGB(150, 150, 150),
            AcrylicMain = Color3.fromRGB(60, 60, 60),
            AcrylicBorder = Color3.fromRGB(90, 90, 90),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(120, 120, 120),
            ElementBorder = Color3.fromRGB(35, 35, 35),
            InElementBorder = Color3.fromRGB(90, 90, 90),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(240, 240, 240),
            SubText = Color3.fromRGB(170, 170, 170),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.4,
                RotationSpeed = 20,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(105, 105, 105)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(90, 90, 90),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 120, 120)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
                })
            }
        },
        ["Charcoal"] = {
            Accent = Color3.fromRGB(102, 102, 102),
            AcrylicMain = Color3.fromRGB(20, 20, 20),
            AcrylicBorder = Color3.fromRGB(60, 60, 60),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(10, 10, 10)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(35, 35, 35),
            ElementBorder = Color3.fromRGB(60, 60, 60),
            InElementBorder = Color3.fromRGB(45, 45, 45),
            ElementTransparency = 0.9,
            Text = Color3.fromRGB(240, 240, 240),
            SubText = Color3.fromRGB(170, 170, 170),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.45,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 150, 150)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(60, 60, 60),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(175, 175, 175))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 180)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                })
            }
        },
        ["Pearl White"] = {
            Accent = Color3.fromRGB(214, 214, 214),
            AcrylicMain = Color3.fromRGB(240, 240, 240),
            AcrylicBorder = Color3.fromRGB(200, 200, 200),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(220, 220, 220)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(220, 220, 220),
            ElementBorder = Color3.fromRGB(200, 200, 200),
            InElementBorder = Color3.fromRGB(210, 210, 210),
            ElementTransparency = 0.9,
            Text = Color3.fromRGB(20, 20, 20),
            SubText = Color3.fromRGB(90, 90, 90),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.4,
                RotationSpeed = 20,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(200, 200, 200),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 160, 160)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
                })
            }
        },
        ["Red"] = {
            Accent = Color3.fromRGB(180, 10, 20),
            AcrylicMain = Color3.fromRGB(35, 8, 10),
            AcrylicBorder = Color3.fromRGB(140, 15, 25),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(130, 12, 20), Color3.fromRGB(28, 5, 8)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(130, 12, 22),
            ElementBorder = Color3.fromRGB(85, 8, 14),
            InElementBorder = Color3.fromRGB(150, 18, 28),
            ElementTransparency = 0.9,
            Text = Color3.fromRGB(255, 230, 230),
            SubText = Color3.fromRGB(210, 175, 178),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.5,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(71, 0, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(159, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 0, 0))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(145, 15, 25),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(141, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 0, 0))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(71, 0, 0)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(159, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(71, 0, 0))
                })
            }
        },
        ["Neon Purple"] = {
            Accent = Color3.fromRGB(180, 0, 255),
            AcrylicMain = Color3.fromRGB(5, 0, 15),
            AcrylicBorder = Color3.fromRGB(140, 0, 255),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(5, 0, 15), Color3.fromRGB(45, 0, 160)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(120, 0, 210),
            ElementBorder = Color3.fromRGB(50, 0, 100),
            InElementBorder = Color3.fromRGB(155, 0, 245),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(252, 245, 255),
            SubText = Color3.fromRGB(210, 185, 255),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.4,
                RotationSpeed = 20,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 5, 137)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 32, 253)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 5, 137))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(60, 0, 150),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 18, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 5, 137))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 18, 255)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 32, 253)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 18, 255))
                })
            }
        },
        ["Deep Ocean"] = {
            Accent = Color3.fromRGB(0, 150, 200),
            AcrylicMain = Color3.fromRGB(15, 30, 45),
            AcrylicBorder = Color3.fromRGB(0, 100, 150),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(0, 80, 120), Color3.fromRGB(10, 25, 40)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(0, 90, 135),
            ElementBorder = Color3.fromRGB(0, 70, 105),
            InElementBorder = Color3.fromRGB(0, 110, 165),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(240, 248, 255),
            SubText = Color3.fromRGB(180, 210, 230),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.5,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 60, 90)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 90))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(0, 100, 150),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 180)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 90))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 150))
                })
            },
            Background = nil,
            BackgroundTransparency = 0
        },
        ["Midnight Blue"] = {
            Accent = Color3.fromRGB(100, 80, 200),
            AcrylicMain = Color3.fromRGB(10, 8, 25),
            AcrylicBorder = Color3.fromRGB(60, 45, 140),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(50, 35, 120), Color3.fromRGB(8, 5, 20)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(55, 40, 125),
            ElementBorder = Color3.fromRGB(40, 30, 90),
            InElementBorder = Color3.fromRGB(70, 55, 155),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(220, 220, 255),
            SubText = Color3.fromRGB(170, 170, 210),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.5,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 15, 60)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 120, 240)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 60))
                })
            },
            StrokeShine = getgenv().ShineEnabled,
            StrokeDark = Color3.fromRGB(60, 45, 140),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 60, 170)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 60))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 45, 140)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 120, 240)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 45, 140))
                })
            }
        },
        ["Royal Blue"] = {
            Accent = Color3.fromRGB(15, 82, 186),
            AcrylicMain = Color3.fromRGB(10, 25, 50),
            AcrylicBorder = Color3.fromRGB(10, 65, 150),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(12, 70, 160), Color3.fromRGB(8, 20, 45)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(9, 58, 135),
            ElementBorder = Color3.fromRGB(6, 40, 95),
            InElementBorder = Color3.fromRGB(11, 70, 160),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(220, 235, 255),
            SubText = Color3.fromRGB(170, 190, 220),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = {
                Speed = 0.5,
                RotationSpeed = 25,
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 40, 85)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 120, 230)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 40, 85))
                })
            },
            StrokeDark = Color3.fromRGB(10, 65, 150),
            ButtonGradient = {
                Background = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 75, 170)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 40, 85))
                }),
                Stroke = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 65, 150)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 120, 230)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 65, 150))
                })
            }
        },
        ["Galaxy Purple"] = {
            Accent = Color3.fromRGB(160, 60, 220),
            AcrylicMain = Color3.fromRGB(12, 5, 25),
            AcrylicBorder = Color3.fromRGB(120, 40, 185),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(110, 35, 175), Color3.fromRGB(8, 3, 20)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(112, 40, 170),
            ElementBorder = Color3.fromRGB(75, 25, 115),
            InElementBorder = Color3.fromRGB(130, 50, 195),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(242, 232, 255),
            SubText = Color3.fromRGB(200, 178, 228),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = { Speed = 0.5, RotationSpeed = 25, ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(48, 18, 85)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(195, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 18, 85)) }) },
            StrokeDark = Color3.fromRGB(125, 45, 190),
            ButtonGradient = { Background = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 50, 195)), ColorSequenceKeypoint.new(1, Color3.fromRGB(48, 18, 85)) }), Stroke = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 45, 190)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(195, 100, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 45, 190)) }) }
        },
        ["Cosmic Violet"] = {
            Accent = Color3.fromRGB(80, 60, 140),
            AcrylicMain = Color3.fromRGB(12, 10, 22),
            AcrylicBorder = Color3.fromRGB(50, 35, 110),
            AcrylicGradient = ColorSequence.new(Color3.fromRGB(45, 30, 100), Color3.fromRGB(8, 6, 16)),
            AcrylicNoise = 0.9,
            Element = Color3.fromRGB(50, 34, 104),
            ElementBorder = Color3.fromRGB(34, 23, 70),
            InElementBorder = Color3.fromRGB(60, 42, 120),
            ElementTransparency = 0.87,
            Text = Color3.fromRGB(230, 225, 245),
            SubText = Color3.fromRGB(185, 175, 210),
            ShineEnabled = getgenv().ShineEnabled,
            Shine = { Speed = 0.5, RotationSpeed = 25, ColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 25, 65)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(115, 90, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 65)) }) },
            StrokeDark = Color3.fromRGB(55, 38, 115),
            ButtonGradient = { Background = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 42, 120)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 25, 65)) }), Stroke = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 38, 115)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(115, 90, 175)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 38, 115)) }) }
        }
    }

    local notifyGui = playerGui:FindFirstChild("FluentNotifyFailsafe")
    if not notifyGui then
        notifyGui = Instance.new("ScreenGui")
        notifyGui.Name = "FluentNotifyFailsafe"
        notifyGui.ResetOnSpawn = false
        notifyGui.DisplayOrder = 9999
        notifyGui.Parent = playerGui
    end

    local holder = notifyGui:FindFirstChild("NotificationHolder")
    if not holder then
        holder = Instance.new("Frame")
        holder.Name = "NotificationHolder"
        holder.Position = UDim2.new(1, -30, 1, -30)
        holder.Size = UDim2.new(0, 310, 1, -30)
        holder.AnchorPoint = Vector2.new(1, 1)
        holder.BackgroundTransparency = 1
        holder.Parent = notifyGui

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        uiListLayout.Padding = UDim.new(0, 20)
        uiListLayout.Parent = holder
    end

    local cardHolder = Instance.new("Frame")
    cardHolder.Name = "Holder"
    cardHolder.BackgroundTransparency = 1
    cardHolder.Size = UDim2.new(1, 0, 0, 200)
    cardHolder.Parent = holder

    local rootCard = Instance.new("Frame")
    rootCard.Name = "Root"
    rootCard.BackgroundTransparency = 1
    rootCard.Size = UDim2.new(1, 0, 1, 0)
    rootCard.Position = UDim2.new(1, 60, 0, 0)
    rootCard.Parent = cardHolder

    local background = Instance.new("Frame")
    background.Name = "AcrylicPaint"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
    background.BackgroundTransparency = 0.10
    background.Parent = rootCard

    local currentTheme = themePresets[activeTheme]

    local rawColor = currentTheme and currentTheme.AcrylicGradient

    local finalGradientColor
    if rawColor and typeof(rawColor) == "ColorSequence" then
        finalGradientColor = rawColor
    elseif rawColor and typeof(rawColor) == "Color3" then
        finalGradientColor = ColorSequence.new(rawColor, rawColor)
    else
        finalGradientColor = ColorSequence.new(Color3.fromRGB(20, 20, 20)) -- Fallback if Theme are not in Fluent
    end

    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = finalGradientColor
    uiGradient.Rotation = 90
    uiGradient.Parent = background

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = background

    local rawStrokeColor = currentTheme and currentTheme.StrokeDark

    local finalStrokeColor
    if rawStrokeColor and typeof(rawStrokeColor) == "Color3" then
        finalStrokeColor = rawStrokeColor
    elseif rawStrokeColor and typeof(rawStrokeColor) == "ColorSequence" then
        finalStrokeColor = rawStrokeColor.Keypoints[1].Value
    else
        finalStrokeColor = Color3.fromRGB(50, 50, 50)
    end

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 1
    uiStroke.Color = finalStrokeColor
    uiStroke.Transparency = 0.6
    uiStroke.Parent = background

    local rgbConnection = nil
    if activeTheme == "RGB" then
        local hue = 0
        rgbConnection = runService.RenderStepped:Connect(function(dt)
            hue = (hue + dt * 0.10) % 1
            local rainbowColor = Color3.fromHSV(hue, 1, 1)
            uiStroke.Color = rainbowColor
        end)
    end

    local stripe = Instance.new("Frame")
    stripe.Name = "Stripe"
    stripe.Size = UDim2.new(0, 3, 1, -16)
    stripe.Position = UDim2.new(0, 6, 0, 8)
    stripe.BackgroundColor3 = stripeColor
    stripe.BorderSizePixel = 0
    stripe.ZIndex = 10
    stripe.Parent = rootCard

    local stripeCorner = Instance.new("UICorner")
    stripeCorner.CornerRadius = UDim.new(1, 0)
    stripeCorner.Parent = stripe

    local mainTextColor = currentTheme and currentTheme.Text or Color3.fromRGB(255, 255, 255)
    local subTextColor = currentTheme and currentTheme.SubText or Color3.fromRGB(180, 180, 180)

    local textIconOffset = 14

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Position = UDim2.fromOffset(textIconOffset, 17)
    titleLabel.Size = UDim2.new(1, -18 - 12, 0, 12)
    titleLabel.Text = titleText
    titleLabel.RichText = true
    titleLabel.TextColor3 = mainTextColor
    titleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    titleLabel.TextSize = 13
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = rootCard

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "ContentLabel"
    contentLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    contentLabel.Text = contentText
    contentLabel.TextColor3 = mainTextColor
    contentLabel.TextSize = 14
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.AutomaticSize = Enum.AutomaticSize.Y
    contentLabel.Size = UDim2.new(1, 0, 0, 14)
    contentLabel.BackgroundTransparency = 1
    contentLabel.TextWrapped = true
    contentLabel.Parent = rootCard

    local subContentLabel = Instance.new("TextLabel")
    subContentLabel.Name = "SubContentLabel"
    subContentLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    subContentLabel.Text = subContentText
    subContentLabel.RichText = true
    subContentLabel.TextColor3 = subTextColor
    subContentLabel.TextSize = 14
    subContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    subContentLabel.AutomaticSize = Enum.AutomaticSize.Y
    subContentLabel.Size = UDim2.new(1, 0, 0, 12)
    subContentLabel.BackgroundTransparency = 1
    subContentLabel.TextWrapped = true

    local labelHolder = Instance.new("Frame")
    local uiListLayoutLabels = Instance.new("UIListLayout")

    labelHolder.Name = "LabelHolder"
    labelHolder.AutomaticSize = Enum.AutomaticSize.Y
    labelHolder.BackgroundTransparency = 1
    labelHolder.Position = UDim2.fromOffset(textIconOffset, 40)
    labelHolder.Size = UDim2.new(1, -28, 0, 0)
    labelHolder.Parent = rootCard

    uiListLayoutLabels.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayoutLabels.VerticalAlignment = Enum.VerticalAlignment.Center
    uiListLayoutLabels.Padding = UDim.new(0, 3)
    uiListLayoutLabels.Parent = labelHolder

    contentLabel.Parent = labelHolder

    if subContentText ~= "" then
        subContentLabel.Parent = labelHolder
    end

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Text = ""
    closeButton.Position = UDim2.new(1, -14, 0, 13)
    closeButton.Size = UDim2.fromOffset(20, 20)
    closeButton.AnchorPoint = Vector2.new(1, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = rootCard

    local closeIcon = Instance.new("ImageLabel")
    closeIcon.Name = "Icon"
    closeIcon.Image = "rbxassetid://9886659671"
    closeIcon.Size = UDim2.fromOffset(16, 16)
    closeIcon.Position = UDim2.fromScale(0.5, 0.5)
    closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    closeIcon.BackgroundTransparency = 1
    closeIcon.ImageColor3 = mainTextColor
    closeIcon.Parent = closeButton

    local copyBtn = Instance.new("TextButton")
    copyBtn.Name = "NotifyCopyButton"
    copyBtn.Text = ""
    copyBtn.Position = UDim2.new(1, -38, 0, 13)
    copyBtn.Size = UDim2.fromOffset(20, 20)
    copyBtn.AnchorPoint = Vector2.new(1, 0)
    copyBtn.BackgroundTransparency = 1
    copyBtn.Parent = rootCard 

    local copyIcon = Instance.new("ImageLabel")
    copyIcon.Name = "Icon"
    copyIcon.Image = "rbxassetid://10709798574"
    copyIcon.Size = UDim2.fromOffset(14, 14)
    copyIcon.Position = UDim2.fromScale(0.5, 0.5)
    copyIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    copyIcon.BackgroundTransparency = 1
    copyIcon.ImageColor3 = mainTextColor
    copyIcon.Parent = copyBtn

    copyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            local txt = tostring(config.Content or "")
            if tostring(config.SubContent or "") ~= "" then
                txt = txt .. "\n" .. tostring(config.SubContent)
                toclipboard(txt)
            end
        end)
    end)

    local function updateSize()
        local labelHeight = labelHolder.AbsoluteSize.Y
        cardHolder.Size = UDim2.new(1, 0, 0, 58 + labelHeight)
    end
    labelHolder:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
    updateSize()

    local tweenInfoIn = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tweenInfoOut = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

    local function open()
        tweenService:Create(rootCard, tweenInfoIn, {Position = UDim2.new(0, 0, 0, 0)}):Play()
    end

    local closed = false
    local function close()
        if closed then return end
        closed = true

        if rgbConnection then
            rgbConnection:Disconnect()
            rgbConnection = nil
        end
        
        local slideOut = tweenService:Create(rootCard, tweenInfoOut, {Position = UDim2.new(1, 60, 0, 0)})
        slideOut:Play()
        slideOut.Completed:Connect(function()
            local collapse = tweenService:Create(cardHolder, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)})
            collapse:Play()
            collapse.Completed:Connect(function()
                cardHolder:Destroy()
            end)
        end)
    end

    closeButton.MouseButton1Click:Connect(close)
    if duration then
        task.delay(duration, close)
    end

    open()
end

return FluentModify
