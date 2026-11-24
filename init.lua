-- =========================================================================
-- ARQUIVO: init.lua (HUB 5D ORIGINAL COMPLETO + 40 SCRIPTS DA INTERNET)
-- REPOSITÓRIO: https://github.com/recex/BrookhavenHub
-- =========================================================================

pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/recex/BrookhavenHub/main/Core/Intro3D.lua", true))()
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

if camera:FindFirstChild("Omega5DWorkspace") then camera.Omega5DWorkspace:Destroy() end
if player.PlayerGui:FindFirstChild("Omega5DGUI") then player.PlayerGui.Omega5DGUI:Destroy() end

local wsFolder = Instance.new("Folder", camera); wsFolder.Name = "Omega5DWorkspace"
local guiFolder = Instance.new("Folder", player.PlayerGui); guiFolder.Name = "Omega5DGUI"

-- Função compactadora para deixar o código curto mantendo 100% do visual original
local function new(class, parent, props)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    inst.Parent = parent
    return inst
end

-- =========================================================================
-- LISTA EXATA DOS 40 SCRIPTS DA INTERNET ({Título, Descrição, Tag, URL})
-- =========================================================================
local ModulosPorAba = {
    [1] = { -- ABA 1: BROOKHAVEN HUBS (01 a 06)
        {"#01 Sander X Hub", "Hub completo de Brookhaven com troll, casas e carros.", "HUB VIP", "https://raw.githubusercontent.com/kigredns/SanderXV4.2.2/refs/heads/main/NormalSS.lua"},
        {"#02 Redz Hub Brookhaven", "O famoso Redz Hub otimizado para Brookhaven RP.", "POPULAR", "https://raw.githubusercontent.com/REDzHUB/REDzHUB/main/REDzHUB"},
        {"#03 Ice Hub Brookhaven", "Script clássico com dezenas de funções exclusivas.", "CLÁSSICO", "https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"},
        {"#04 Rael Hub Brookhaven", "Hub brasileiro super completo para Brookhaven.", "BR HUB", "https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt"},
        {"#05 JulHub Brookhaven", "Painel leve e rápido com funções de RP e avatar.", "LEVE", "https://raw.githubusercontent.com/JulHubz/JulHub/main/JulHub"},
        {"#06 Imperial Hub", "Hub avançado com automações e teleportes.", "IMPERIAL", "https://raw.githubusercontent.com/Trev0rZ/LoaderM/main/ImperialHub-Working.lua"}
    },
    [2] = { -- ABA 2: ADMINS FE (07 a 12)
        {"#07 Infinite Yield FE", "O maior script de comandos Admin FE do Roblox.", "TOP ADMIN", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
        {"#08 Nameless Admin", "Admin FE moderno com centenas de comandos visuais.", "ADMIN FE", "https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"},
        {"#09 Fates Admin", "Barra de comandos estilosa com funções de física.", "FATES", "https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"},
        {"#10 CMD-X Admin", "Painel de comando profissional com +400 funções.", "CMD-X", "https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"},
        {"#11 Reviz Admin V2", "Comandos clássicos FE para controle de personagem.", "REVIZ", "https://pastebin.com/raw/Caniwq2N"},
        {"#12 Orca Admin Hub", "Interface moderna estilo barra superior com admin.", "ORCA UI", "https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"}
    },
    [3] = { -- ABA 3: TROLL & FLING (13 a 18)
        {"#13 GhostHub Troll", "Dezenas de ferramentas raras de trollagem FE.", "GHOST", "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"},
        {"#14 System Broken FE", "Animações quebradas, ragdoll e fling para trollar.", "BROKEN", "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"},
        {"#15 Touch Fling GUI", "Arremesse qualquer jogador apenas encostando nele.", "FLING", "https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"},
        {"#16 Yeet Troll GUI", "Jogue jogadores longe com rotação de alta velocidade.", "YEET", "https://pastebin.com/raw/saMtSz2A"},
        {"#17 FE Telekinesis", "Controle objetos soltos do mapa com telecinese.", "PODER", "https://pastebin.com/raw/db9C3B8M"},
        {"#18 FE Invisible Troll", "Fique invisível para surpreender outros jogadores.", "INVISÍVEL", "https://pastebin.com/raw/3Rnd9rHf"}
    },
    [4] = { -- ABA 4: VOAR & CARROS (19 a 24)
        {"#19 Fly GUI V3", "O famoso menu de voo compatível com Mobile e PC.", "FLY V3", "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"},
        {"#20 Vehicle Fly GUI", "Saia voando pelo céu com qualquer carro do jogo.", "CAR FLY", "https://pastebin.com/raw/MHE1cbWF"},
        {"#21 Car Speed Universal", "Aumenta drasticamente o torque e velocidade dos carros.", "TURBO", "https://pastebin.com/raw/S9D5Qx4d"},
        {"#22 Walk On Walls FE", "Ande pelas paredes e tetos dos prédios de Brookhaven.", "GRAVIDADE", "https://pastebin.com/raw/zXk4Rq2r"},
        {"#23 Click Teleport Tool", "Gera um item no inventário para teleportar onde clicar.", "TP TOOL", "https://pastebin.com/raw/GuBiX19e"},
        {"#24 Noclip & Speed GUI", "Painel rápido para atravessar paredes e correr.", "NOCLIP", "https://pastebin.com/raw/B5xRxTnk"}
    },
    [5] = { -- ABA 5: AVATAR & EMOTES (25 a 30)
        {"#25 Free Emotes GUI", "Desbloqueia todos os emotes pagos do catálogo grátis.", "EMOTES", "https://raw.githubusercontent.com/XNEOFF/FEmotesGui/main/FEmotesGui.lua"},
        {"#26 Animation Changer", "Troque o pacote de corrida (Zombie, Ninja, Toy, etc.).", "ANIMAÇÃO", "https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui"},
        {"#27 Headless & Korblox", "Aplica o visual sem cabeça e perna Korblox no avatar.", "VIP SKIN", "https://pastebin.com/raw/H5yx10Jq"},
        {"#28 FE Ball Roll", "Transforma seu personagem em uma esfera rolante.", "BOLA FE", "https://pastebin.com/raw/cK8W2Y9a"},
        {"#29 FE Snake Avatar", "Movimentação estilo serpente pelo chão do mapa.", "SNAKE", "https://pastebin.com/raw/RmD3qN7v"},
        {"#30 R15 Emotes Hub", "Menu completo de danças sincronizadas para R15.", "DANÇAS", "https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"}
    },
    [6] = { -- ABA 6: ESP & RADAR (31 a 35)
        {"#31 Unnamed ESP", "ESP completo com caixas, distância, vida e tracers.", "PRO ESP", "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"},
        {"#32 Owl Hub ESP", "Visualizador limpo de jogadores através das paredes.", "OWL ESP", "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"},
        {"#33 Player Radar 2D", "Mini-mapa 2D na tela mostrando a posição de todos.", "RADAR", "https://pastebin.com/raw/7yK8vL2p"},
        {"#34 Hitbox Expander", "Aumenta a área de colisão de outros jogadores.", "HITBOX", "https://pastebin.com/raw/5bX9mN3k"},
        {"#35 Spectate GUI", "Assista à câmera de qualquer jogador do servidor.", "ESPIAR", "https://pastebin.com/raw/3vR8pL1n"}
    },
    [7] = { -- ABA 7: SHADERS & FPS (36 a 40)
        {"#36 PShade RTX Shaders", "Gráficos ultra realistas com reflexos e sombras RTX.", "RTX ON", "https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua"},
        {"#37 BShaders Lite", "Iluminação bonita e leve que não pesa no celular.", "SHADERS", "https://pastebin.com/raw/Unb1cW8k"},
        {"#38 FPS Booster Ultra", "Remove texturas pesadas para rodar liso a +120 FPS.", "+FPS", "https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"},
        {"#39 Dex Explorer V3", "Explore todas as pastas e objetos internos do jogo.", "DEX V3", "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"},
        {"#40 Mobile Keyboard GUI", "Teclado virtual na tela para usar atalhos de PC.", "TECLADO", "https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"}
    }
}

-- =========================================================================
-- 1. HIPERCUBO 4D/5D (TESSERACT) + PLATAFORMA HOLOGRÁFICA NO CHÃO
-- =========================================================================
local tesseractCenter = new("Part", wsFolder, {Name="Tesseract5DCore", Size=Vector3.new(0.2,0.2,0.2), Transparency=1, Anchored=true, CanCollide=false, CanQuery=false})
local vertices4D, attachments4D, tesseractBeams = {}, {}, {}

for x = -1, 1, 2 do for y = -1, 1, 2 do for z = -1, 1, 2 do for w = -1, 1, 2 do
    table.insert(vertices4D, {x=x, y=y, z=z, w=w})
    table.insert(attachments4D, new("Attachment", tesseractCenter))
end end end end

for i = 1, 16 do
    for j = i + 1, 16 do
        local v1, v2 = vertices4D[i], vertices4D[j]
        if math.abs(v1.x-v2.x)+math.abs(v1.y-v2.y)+math.abs(v1.z-v2.z)+math.abs(v1.w-v2.w) == 2 then
            table.insert(tesseractBeams, new("Beam", tesseractCenter, {
                Attachment0=attachments4D[i], Attachment1=attachments4D[j], Width0=0.045, Width1=0.045,
                LightEmission=1, FaceCamera=true, Transparency=NumberSequence.new(0.15),
                Color=ColorSequence.new(Color3.fromRGB(0,255,255), Color3.fromRGB(180,0,255))
            }))
        end
    end
end

local floorPlatform = new("Part", wsFolder, {Shape=Enum.PartType.Cylinder, Size=Vector3.new(0.08,9,9), Color=Color3.fromRGB(0,255,255), Material=Enum.Material.ForceField, Transparency=0.35, Anchored=true, CanCollide=false, CanQuery=false})
local floorRing = new("SelectionBox", floorPlatform, {Adornee=floorPlatform, Color3=Color3.fromRGB(170,0,255), LineThickness=0.03})

-- =========================================================================
-- 2. CONSTRUTOR DAS 7 TELAS HOLOGRÁFICAS 5D + CAMADAS POP-OUT
-- =========================================================================
local screens5D, allGradients = {}, {}
local currentThemeColor, secondaryThemeColor = Color3.fromRGB(0,255,255), Color3.fromRGB(170,0,255)

local function create5DScreen(id, size3D, canvasRes, baseOffset, baseAngles, popDepth)
    local part = new("Part", wsFolder, {Name="Screen5D_"..id, Size=size3D, Color=Color3.fromRGB(8,12,22), Material=Enum.Material.Glass, Transparency=0.18, Anchored=true, CanCollide=false, CanTouch=false, CanQuery=true, CastShadow=false})
    local box = new("SelectionBox", part, {Adornee=part, Color3=currentThemeColor, LineThickness=0.02, Transparency=0.25})
    local popPart = new("Part", wsFolder, {Size=size3D-Vector3.new(0.25,0.25,0), Transparency=1, Anchored=true, CanCollide=false, CanQuery=false})
    local popBox = new("SelectionBox", popPart, {Adornee=popPart, Color3=secondaryThemeColor, LineThickness=0.012, Transparency=0.55})
    local topBar = new("Part", wsFolder, {Size=Vector3.new(size3D.X*0.85,0.06,0.06), Color=currentThemeColor, Material=Enum.Material.Neon, Anchored=true, CanCollide=false, CanQuery=false})

    local tBeam = new("Beam", topBar, {Attachment0=new("Attachment", tesseractCenter), Attachment1=new("Attachment", topBar), Width0=0.03, Width1=0.08, LightEmission=1, FaceCamera=true, Color=ColorSequence.new(secondaryThemeColor, currentThemeColor), Transparency=NumberSequence.new(0.45)})
    local sGui = new("SurfaceGui", guiFolder, {Adornee=part, Face=Enum.NormalId.Back, AlwaysOnTop=true, LightInfluence=0, SizingMode=Enum.SurfaceGuiSizingMode.FixedSize, CanvasSize=canvasRes, ZIndexBehavior=Enum.ZIndexBehavior.Sibling})
    local mainFrame = new("Frame", sGui, {Size=UDim2.new(1,-12,1,-12), Position=UDim2.new(0,6,0,6), BackgroundColor3=Color3.fromRGB(7,10,18), BackgroundTransparency=0.14, BorderSizePixel=0})
    new("UICorner", mainFrame, {CornerRadius=UDim.new(0,14)})

    local stroke = new("UIStroke", mainFrame, {Thickness=2.5, Color=Color3.new(1,1,1)})
    local grad = new("UIGradient", stroke, {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,currentThemeColor), ColorSequenceKeypoint.new(0.5,secondaryThemeColor), ColorSequenceKeypoint.new(1,currentThemeColor)})})
    table.insert(allGradients, grad)

    screens5D[id] = {Id=id, Part=part, PopPart=popPart, TopBar=topBar, Gui=sGui, Frame=mainFrame, Outline=box, PopOutline=popBox, TesseractBeam=tBeam, BaseSize=size3D, BaseOffset=baseOffset, BaseAngles=baseAngles, PopDepth=popDepth, PulseZ=0}
    return screens5D[id]
end

local s1_Center    = create5DScreen(1, Vector3.new(7.4,4.6,0.06),  Vector2.new(920,580), Vector3.new(0,0.05,0),        CFrame.Angles(0,0,0),             0.28)
local s2_Top       = create5DScreen(2, Vector3.new(7.4,0.95,0.06), Vector2.new(920,120), Vector3.new(0,3.05,0.35),     CFrame.Angles(math.rad(16),0,0),  0.20)
local s3_LeftNav   = create5DScreen(3, Vector3.new(3.1,3.3,0.06),  Vector2.new(390,420), Vector3.new(-5.35,0.7,1.15),  CFrame.Angles(0,math.rad(26),0),  0.24)
local s4_LeftProf  = create5DScreen(4, Vector3.new(3.1,1.15,0.06), Vector2.new(390,145), Vector3.new(-5.35,-1.65,1.15),CFrame.Angles(0,math.rad(26),0),  0.24)
local s5_RightStat = create5DScreen(5, Vector3.new(3.1,2.2,0.06),  Vector2.new(390,280), Vector3.new(5.35,1.25,1.15),  CFrame.Angles(0,math.rad(-26),0), 0.24)
local s6_RightLogs = create5DScreen(6, Vector3.new(3.1,2.25,0.06), Vector2.new(390,285), Vector3.new(5.35,-1.1,1.15),  CFrame.Angles(0,math.rad(-26),0), 0.24)
local s7_Bottom    = create5DScreen(7, Vector3.new(7.4,0.85,0.06), Vector2.new(920,110), Vector3.new(0,-2.95,0.4),     CFrame.Angles(math.rad(-18),0,0), 0.20)

local function txt(parent, text, size, pos, font, color, tSize, alignX)
    return new("TextLabel", parent, {Size=size, Position=pos, BackgroundTransparency=1, Text=text, Font=font or Enum.Font.GothamBold, TextColor3=color or Color3.new(1,1,1), TextSize=tSize or 16, TextXAlignment=alignX or Enum.TextXAlignment.Left})
end

-- =========================================================================
-- 3. CONTEÚDO DAS TELAS LATERAIS, TOPO E DOCK (TELAS 2, 4, 5, 6, 7)
-- =========================================================================
-- Tela 6: Terminal Logs
txt(s6_RightLogs.Frame, "TERMINAL LOGS", UDim2.new(1,-24,0,28), UDim2.new(0,14,0,8), Enum.Font.GothamBlack, currentThemeColor, 15)
local logsContainer = new("Frame", s6_RightLogs.Frame, {Size=UDim2.new(1,-24,1,-44), Position=UDim2.new(0,12,0,38), BackgroundColor3=Color3.fromRGB(4,7,14), BorderSizePixel=0})
new("UICorner", logsContainer, {CornerRadius=UDim.new(0,8)})
new("UIListLayout", logsContainer, {Padding=UDim.new(0,4), VerticalAlignment=Enum.VerticalAlignment.Bottom})

local logEntries = {}
local function addSystemLog(msg, color)
    local item = txt(logsContainer, string.format("[%s] %s", os.date("%H:%M:%S"), msg), UDim2.new(1,-10,0,20), UDim2.new(0,6,0,0), Enum.Font.Code, color or Color3.fromRGB(190,230,255), 13)
    item.TextTruncate = Enum.TextTruncate.AtEnd
    table.insert(logEntries, item)
    if #logEntries > 9 then table.remove(logEntries, 1):Destroy() end
end
addSystemLog("Hub 5D iniciado (40 Scripts prontos!)", Color3.fromRGB(0,255,160))

-- Tela 2: Topo + 5 Temas
txt(s2_Top.Frame, " RECEX UNIVERSAL SCRIPT", UDim2.new(0,290,0,36), UDim2.new(0,20,0,12), Enum.Font.GothamBlack, currentThemeColor, 21)
txt(s2_Top.Frame, "7 TELAS HOLOGRÁFICAS • 40 SCRIPTS DA INTERNET", UDim2.new(0,340,0,20), UDim2.new(0,20,0,48), Enum.Font.Code, Color3.fromRGB(160,190,230), 13)
local urlBar = new("Frame", s2_Top.Frame, {Size=UDim2.new(0,330,0,36), Position=UDim2.new(0,315,0,20), BackgroundColor3=Color3.fromRGB(14,20,34)})
new("UICorner", urlBar, {CornerRadius=UDim.new(0,10)})
txt(urlBar, "https://discord.gg/MhFrf7z5D", UDim2.new(1,-16,1,0), UDim2.new(0,10,0,0), Enum.Font.Code, Color3.fromRGB(0,255,170), 13)

local themes = {
    {"Ciano", Color3.fromRGB(0,255,255), Color3.fromRGB(170,0,255)},
    {"Rubi",  Color3.fromRGB(255,30,90), Color3.fromRGB(255,150,0)},
    {"Roxo",  Color3.fromRGB(190,60,255),Color3.fromRGB(0,220,255)},
    {"Ouro",  Color3.fromRGB(255,215,0), Color3.fromRGB(255,80,0)},
    {"Matrix",Color3.fromRGB(0,255,110), Color3.fromRGB(0,140,255)}
}
for idx, th in ipairs(themes) do
    local tBtn = new("TextButton", s2_Top.Frame, {Size=UDim2.new(0,42,0,42), Position=UDim2.new(1,-245+(idx-1)*46,0,17), BackgroundColor3=th[2], Text=""})
    new("UICorner", tBtn, {CornerRadius=UDim.new(1,0)})
    new("UIStroke", tBtn, {Color=Color3.new(1,1,1), Thickness=2})
    tBtn.MouseButton1Click:Connect(function()
        currentThemeColor, secondaryThemeColor = th[2], th[3]
        floorPlatform.Color, floorRing.Color3 = th[2], th[3]
        for _, b in ipairs(tesseractBeams) do b.Color = ColorSequence.new(th[2], th[3]) end
        for _, s in pairs(screens5D) do s.Outline.Color3, s.PopOutline.Color3, s.TopBar.Color, s.TesseractBeam.Color, s.PulseZ = th[2], th[3], th[2], ColorSequence.new(th[3], th[2]), 0.65 end
        for _, g in ipairs(allGradients) do g.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,th[2]), ColorSequenceKeypoint.new(0.5,th[3]), ColorSequenceKeypoint.new(1,th[2])}) end
        addSystemLog("Tema alterado para: " .. th[1], th[2])
    end)
end

-- Tela 4: Perfil com Avatar
local avatarRing = new("Frame", s4_LeftProf.Frame, {Size=UDim2.new(0,82,0,82), Position=UDim2.new(0,16,0.5,-41), BackgroundColor3=Color3.fromRGB(14,20,32)})
new("UICorner", avatarRing, {CornerRadius=UDim.new(1,0)})
table.insert(allGradients, new("UIGradient", new("UIStroke", avatarRing, {Thickness=3, Color=Color3.new(1,1,1)}), {Color=ColorSequence.new(currentThemeColor, secondaryThemeColor)}))
local avatarImg = new("ImageLabel", avatarRing, {Size=UDim2.new(1,-8,1,-8), Position=UDim2.new(0,4,0,4), BackgroundTransparency=1})
new("UICorner", avatarImg, {CornerRadius=UDim.new(1,0)})
task.spawn(function() pcall(function() avatarImg.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150) end) end)
txt(s4_LeftProf.Frame, player.DisplayName, UDim2.new(1,-115,0,26), UDim2.new(0,110,0,18), Enum.Font.GothamBlack, Color3.new(1,1,1), 18)
txt(s4_LeftProf.Frame, "@"..player.Name, UDim2.new(1,-115,0,20), UDim2.new(0,110,0,44), Enum.Font.Code, currentThemeColor, 14)
txt(s4_LeftProf.Frame, "⚡ 40 SCRIPTS DESTRAVADOS", UDim2.new(1,-115,0,20), UDim2.new(0,110,0,68), Enum.Font.GothamBold, Color3.fromRGB(0,255,160), 12)

-- Tela 5: Telemetria + Equalizador de 15 Barras
txt(s5_RightStat.Frame, "📊 TELEMETRIA & ESPECTRO ", UDim2.new(1,-24,0,28), UDim2.new(0,14,0,10), Enum.Font.GothamBlack, currentThemeColor, 15)
local fpsLabel  = txt(s5_RightStat.Frame, "FPS: 60", UDim2.new(0.5,-14,0,24), UDim2.new(0,14,0,42), Enum.Font.Code, Color3.fromRGB(0,255,160), 15)
local pingLabel = txt(s5_RightStat.Frame, "PING: -- ms", UDim2.new(0.5,-14,0,24), UDim2.new(0.5,0,0,42), Enum.Font.Code, Color3.fromRGB(255,210,60), 15)
local plrsLabel = txt(s5_RightStat.Frame, "JOGADORES NO SERVIDOR: "..#Players:GetPlayers(), UDim2.new(1,-28,0,22), UDim2.new(0,14,0,68), Enum.Font.GothamBold, Color3.fromRGB(200,220,255), 13)
local eqContainer = new("Frame", s5_RightStat.Frame, {Size=UDim2.new(1,-28,0,130), Position=UDim2.new(0,14,0,102), BackgroundColor3=Color3.fromRGB(5,8,16)})
new("UICorner", eqContainer, {CornerRadius=UDim.new(0,10)})
local eqBars = {}
for i = 1, 15 do
    local bar = new("Frame", eqContainer, {Size=UDim2.new(1/18,0,0.3,0), Position=UDim2.new((i-0.5)/15.5,0,0.92,0), AnchorPoint=Vector2.new(0,1), BackgroundColor3=currentThemeColor, BorderSizePixel=0})
    new("UICorner", bar, {CornerRadius=UDim.new(0,4)})
    table.insert(eqBars, bar)
end

-- Tela 7: Dock Inferior
local hubDist, inertiaEnabled = 8.4, true
local function createDockBtn(text, posS, sizeS, cb)
    local b = new("TextButton", s7_Bottom.Frame, {Size=UDim2.new(sizeS,-14,0,52), Position=UDim2.new(posS,10,0.5,-26), BackgroundColor3=Color3.fromRGB(15,22,38), Text=text, Font=Enum.Font.GothamBlack, TextColor3=Color3.new(1,1,1), TextSize=14})
    new("UICorner", b, {CornerRadius=UDim.new(0,10)})
    new("UIStroke", b, {Color=currentThemeColor, Thickness=1.5})
    b.MouseButton1Click:Connect(function() cb(b) end)
end
createDockBtn("➕ APROXIMAR", 0.00, 0.24, function() hubDist = math.max(5.5, hubDist - 0.8) end)
createDockBtn("➖ AFASTAR",   0.25, 0.24, function() hubDist = math.min(12.5, hubDist + 0.8) end)
createDockBtn("INÉRCIA: ON", 0.50, 0.25, function(b) inertiaEnabled = not inertiaEnabled; b.Text = inertiaEnabled and "INÉRCIA: ON" or "INÉRCIA: FIXA" end)
createDockBtn("TESSERACT", 0.75, 0.25, function() for _, s in pairs(screens5D) do s.PulseZ = 1.15 end end)

-- =========================================================================
-- 4. TELA 1 (GRADE CENTRAL DOS 40 SCRIPTS) + TELA 3 (7 ABAS)
-- =========================================================================
local centerTabTitle = txt(s1_Center.Frame, "01 // BROOKHAVEN HUBS", UDim2.new(0.55,0,0,34), UDim2.new(0,22,0,14), Enum.Font.GothamBlack, currentThemeColor, 22)
local centerTabSub   = txt(s1_Center.Frame, "Principais Hubs completos de Brookhaven", UDim2.new(0.55,0,0,20), UDim2.new(0,22,0,46), Enum.Font.Gotham, Color3.fromRGB(165,190,225), 13)

local searchBox = new("TextBox", s1_Center.Frame, {Size=UDim2.new(0,310,0,38), Position=UDim2.new(1,-332,0,18), BackgroundColor3=Color3.fromRGB(14,20,34), PlaceholderText="🔍 Pesquisar entre os 40 scripts...", PlaceholderColor3=Color3.fromRGB(120,145,180), Text="", Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1), TextSize=14, ClearTextOnFocus=false})
new("UICorner", searchBox, {CornerRadius=UDim.new(0,10)})
new("UIStroke", searchBox, {Color=Color3.fromRGB(0,180,255), Thickness=1.5})

local cardsScroll = new("ScrollingFrame", s1_Center.Frame, {Size=UDim2.new(1,-36,1,-86), Position=UDim2.new(0,18,0,74), BackgroundTransparency=1, ScrollBarThickness=6, ScrollBarImageColor3=currentThemeColor, BorderSizePixel=0})
new("UIGridLayout", cardsScroll, {CellSize=UDim2.new(0,276,0,134), CellPadding=UDim2.new(0,14,0,14), SortOrder=Enum.SortOrder.LayoutOrder})

local tabsConfig = {
    {1, "🏠", "01. Brookhaven Hubs", "Os 6 maiores Hubs de Brookhaven da internet (#01 a #06)"},
    {2, "⚡", "02. Admins FE",       "Os 6 melhores scripts de comando Admin FE (#07 a #12)"},
    {3, "🎭", "03. Troll & Fling",   "Scripts de Fling, Telecinese e Trollagem FE (#13 a #18)"},
    {4, "🚗", "04. Voar & Carros",   "Fly GUI V3, Car Fly, Turbo e Mobilidade (#19 a #24)"},
    {5, "👑", "05. Avatar & Emotes", "Emotes grátis, Animações, Korblox e Headless (#25 a #30)"},
    {6, "🎯", "06. ESP & Radar",     "ESP completo, Radar 2D, Hitbox e Spectate (#31 a #35)"},
    {7, "🌤️", "07. Shaders & FPS",   "PShade RTX, BShaders, FPS Boost e Dex V3 (#36 a #40)"}
}

local currentTabId, navButtons = 1, {}

local function renderTabCards(tabId, filterText)
    currentTabId = tabId
    local tInfo = tabsConfig[tabId]
    centerTabTitle.Text, centerTabSub.Text = string.upper(tInfo[2].." "..tInfo[3]), tInfo[4]
    for _, c in ipairs(cardsScroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end

    local query, shownCount = string.lower(filterText or ""), 0
    for idx, mod in ipairs(ModulosPorAba[tabId] or {}) do
        if query == "" or string.find(string.lower(mod[1]), query, 1, true) or string.find(string.lower(mod[2]), query, 1, true) then
            shownCount = shownCount + 1
            local card = new("Frame", cardsScroll, {LayoutOrder=idx, BackgroundColor3=Color3.fromRGB(13,19,32), BackgroundTransparency=1})
            new("UICorner", card, {CornerRadius=UDim.new(0,12)})
            local cStroke = new("UIStroke", card, {Color=Color3.fromRGB(35,60,95), Thickness=1.5})

            local badge = new("Frame", card, {Size=UDim2.new(0,92,0,22), Position=UDim2.new(1,-102,0,10), BackgroundColor3=Color3.fromRGB(20,32,54)})
            new("UICorner", badge, {CornerRadius=UDim.new(1,0)})
            local badgeLbl = txt(badge, mod[3], UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Enum.Font.Code, currentThemeColor, 11, Enum.TextXAlignment.Center)

            txt(card, mod[1], UDim2.new(1,-116,0,26), UDim2.new(0,14,0,10), Enum.Font.GothamBlack, Color3.new(1,1,1), 15)
            local descLbl = txt(card, mod[2], UDim2.new(1,-28,0,38), UDim2.new(0,14,0,38), Enum.Font.Gotham, Color3.fromRGB(165,185,215), 12)
            descLbl.TextWrapped, descLbl.TextYAlignment = true, Enum.TextYAlignment.Top

            local actBtn = new("TextButton", card, {Size=UDim2.new(1,-28,0,34), Position=UDim2.new(0,14,1,-44), BackgroundColor3=Color3.fromRGB(20,30,52), Text="⚡ EXECUTAR SCRIPT", Font=Enum.Font.GothamBlack, TextColor3=Color3.new(1,1,1), TextSize=13})
            new("UICorner", actBtn, {CornerRadius=UDim.new(0,8)})

            actBtn.MouseEnter:Connect(function() TweenService:Create(cStroke, TweenInfo.new(0.2), {Color=currentThemeColor, Thickness=2.2}):Play() end)
            actBtn.MouseLeave:Connect(function() TweenService:Create(cStroke, TweenInfo.new(0.2), {Color=Color3.fromRGB(35,60,95), Thickness=1.5}):Play() end)
            actBtn.MouseButton1Click:Connect(function()
                s1_Center.PulseZ, actBtn.Text, actBtn.BackgroundColor3, badgeLbl.Text = 0.35, "🚀 CARREGANDO...", Color3.fromRGB(0,160,120), "ATIVO"
                addSystemLog("Executando " .. mod[1], currentThemeColor)
                task.spawn(function()
                    local ok = pcall(function() loadstring(game:HttpGet(mod[4], true))() end)
                    actBtn.Text = ok and "✅ EXECUTADO!" or "⚠️ ERRO NO LINK"
                    task.wait(1.2)
                    actBtn.Text, actBtn.BackgroundColor3 = "⚡ EXECUTAR SCRIPT", Color3.fromRGB(20,30,52)
                end)
            end)

            task.delay(shownCount * 0.03, function()
                if card and card.Parent then TweenService:Create(card, TweenInfo.new(0.25), {BackgroundTransparency=0.08}):Play() end
            end)
        end
    end
    cardsScroll.CanvasSize = UDim2.new(0, 0, 0, math.max(math.ceil(shownCount / 3) * 150 + 20, 300))
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function() renderTabCards(currentTabId, searchBox.Text) end)

txt(s3_LeftNav.Frame, "🧭 DIRETÓRIO (7 ABAS)", UDim2.new(1,-24,0,30), UDim2.new(0,16,0,10), Enum.Font.GothamBlack, currentThemeColor, 16)
local navContainer = new("Frame", s3_LeftNav.Frame, {Size=UDim2.new(1,-24,1,-50), Position=UDim2.new(0,12,0,42), BackgroundTransparency=1})
new("UIListLayout", navContainer, {Padding=UDim.new(0,6)})

for _, tInfo in ipairs(tabsConfig) do
    local id = tInfo[1]
    local nBtn = new("TextButton", navContainer, {Size=UDim2.new(1,0,0,44), BackgroundColor3=(id==1) and Color3.fromRGB(0,130,210) or Color3.fromRGB(15,22,36), Text="  "..tInfo[2].."  "..tInfo[3], Font=Enum.Font.GothamBold, TextColor3=Color3.new(1,1,1), TextSize=14, TextXAlignment=Enum.TextXAlignment.Left})
    new("UICorner", nBtn, {CornerRadius=UDim.new(0,10)})
    local nStroke = new("UIStroke", nBtn, {Color=(id==1) and currentThemeColor or Color3.fromRGB(35,55,85), Thickness=1.5})
    navButtons[id] = {Btn=nBtn, Stroke=nStroke}

    nBtn.MouseButton1Click:Connect(function()
        for bId, data in pairs(navButtons) do
            TweenService:Create(data.Btn, TweenInfo.new(0.25), {BackgroundColor3=(bId==id) and Color3.fromRGB(0,130,210) or Color3.fromRGB(15,22,36)}):Play()
            data.Stroke.Color = (bId==id) and currentThemeColor or Color3.fromRGB(35,55,85)
        end
        for idx, s in pairs(screens5D) do s.PulseZ = 0.55 + (idx * 0.06) end
        searchBox.Text = ""
        renderTabCards(id, "")
        addSystemLog("Aba aberta: " .. tInfo[3])
    end)
end
renderTabCards(1, "")

-- =========================================================================
-- 5. BOLINHA FLUTUANTE ARRASTÁVEL 5D (ANÉIS DUPLOS GIRATÓRIOS)
-- =========================================================================
local orbScreenGui = new("ScreenGui", guiFolder, {Name="Draggable5DOrbGui", ResetOnSpawn=false, DisplayOrder=999999})
local orbButton = new("TextButton", orbScreenGui, {Size=UDim2.new(0,70,0,70), Position=UDim2.new(0.05,0,0.45,0), BackgroundColor3=Color3.fromRGB(10,14,26), Text="", AutoButtonColor=false})
new("UICorner", orbButton, {CornerRadius=UDim.new(1,0)})
local ring1Grad = new("UIGradient", new("UIStroke", orbButton, {Thickness=3.2, Color=Color3.new(1,1,1)}), {Color=ColorSequence.new({ColorSequenceKeypoint.new(0,currentThemeColor), ColorSequenceKeypoint.new(0.5,secondaryThemeColor), ColorSequenceKeypoint.new(1,currentThemeColor)})})

local innerCircle = new("Frame", orbButton, {Size=UDim2.new(0,52,0,52), Position=UDim2.new(0.5,-26,0.5,-26), BackgroundColor3=Color3.fromRGB(16,22,40)})
new("UICorner", innerCircle, {CornerRadius=UDim.new(1,0)})
local ring2Grad = new("UIGradient", new("UIStroke", innerCircle, {Thickness=2, Color=Color3.new(1,1,1)}), {Color=ColorSequence.new(Color3.fromRGB(255,0,140), Color3.fromRGB(0,255,200))})

local orbCoreText = txt(innerCircle, "5D", UDim2.new(1,0,0.6,0), UDim2.new(0,0,0.08,0), Enum.Font.GothamBlack, currentThemeColor, 18, Enum.TextXAlignment.Center)
local orbSubText  = txt(innerCircle, "OPEN", UDim2.new(1,0,0.35,0), UDim2.new(0,0,0.58,0), Enum.Font.Code, Color3.fromRGB(190,230,255), 10, Enum.TextXAlignment.Center)

local isHubOpen, openAlpha, dragging, dragStart, startPos, movedDist = true, 1, false, nil, nil, 0
orbButton.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos, movedDist = true, inp.Position, orbButton.Position, 0
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - dragStart; movedDist = d.Magnitude
        orbButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) and dragging then
        dragging = false
        if movedDist < 10 then
            isHubOpen = not isHubOpen
            orbSubText.Text = isHubOpen and "OPEN" or "HIDE"
            orbCoreText.TextColor3 = isHubOpen and currentThemeColor or Color3.fromRGB(255,80,130)
            if isHubOpen then for _, s in pairs(screens5D) do s.PulseZ = 0.8 end end
        end
    end
end)

-- =========================================================================
-- 6. MOTOR MATEMÁTICO DE ANIMAÇÃO 5D CONTÍNUA (RENDERSTEPPED)
-- =========================================================================
local startTime, smoothCamCF, fpsAccum, fpsFrames = tick(), camera.CFrame, 0, 0

RunService.RenderStepped:Connect(function(dt)
    local elapsed = tick() - startTime
    ring1Grad.Rotation, ring2Grad.Rotation = (elapsed * 140) % 360, -(elapsed * 200) % 360
    for idx, grad in ipairs(allGradients) do grad.Rotation = (elapsed * 85 + idx * 45) % 360 end

    fpsAccum, fpsFrames = fpsAccum + dt, fpsFrames + 1
    if fpsAccum >= 0.4 then
        fpsLabel.Text = "FPS: " .. math.clamp(math.floor(fpsFrames / fpsAccum), 1, 999)
        local okP, pingVal = pcall(function() return math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        pingLabel.Text = "PING: " .. (okP and pingVal or 45) .. " ms"
        plrsLabel.Text = "JOGADORES NO SERVIDOR: " .. #Players:GetPlayers()
        fpsAccum, fpsFrames = 0, 0
    end

    for i, bar in ipairs(eqBars) do
        local wave = (math.sin(elapsed * 7 + i * 0.65) + 1) * 0.4 + 0.12
        bar.Size, bar.BackgroundColor3 = UDim2.new(1/18, 0, wave, 0), currentThemeColor:Lerp(secondaryThemeColor, wave)
    end

    openAlpha = openAlpha + ((isHubOpen and 1 or 0) - openAlpha) * math.min(dt * 10, 1)
    smoothCamCF = inertiaEnabled and smoothCamCF:Lerp(camera.CFrame, math.min(dt * 9, 1)) or camera.CFrame
    local hubCenterCF = smoothCamCF * CFrame.new(0, 0, -hubDist)

    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp and openAlpha > 0.05 then
        floorPlatform.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 2.9, 0)) * CFrame.Angles(0, elapsed * 0.8, math.rad(90))
        floorPlatform.Transparency, floorRing.Transparency = 1 - (0.65 * openAlpha), 1 - (0.75 * openAlpha)
    else
        floorPlatform.Transparency, floorRing.Transparency = 1, 1
    end

    local tesseractCF = hubCenterCF * CFrame.new(0, 3.85, 0.2)
    tesseractCenter.CFrame = tesseractCF
    local aXW, aYW, aZW, scale4D = elapsed * 1.15, elapsed * 0.85, elapsed * 0.65, 0.65 * openAlpha

    for i, v in ipairs(vertices4D) do
        local x1, w1 = v.x*math.cos(aXW) - v.w*math.sin(aXW), v.x*math.sin(aXW) + v.w*math.cos(aXW)
        local y2, w2 = v.y*math.cos(aYW) - w1*math.sin(aYW),  v.y*math.sin(aYW) + w1*math.cos(aYW)
        local z3, w3 = v.z*math.cos(aZW) - w2*math.sin(aZW),  v.z*math.sin(aZW) + w2*math.cos(aZW)
        local wF = 1 / (2.4 - w3 * 0.6)
        attachments4D[i].Position = Vector3.new(x1*wF*scale4D, y2*wF*scale4D, z3*wF*scale4D)
    end
    for _, b in ipairs(tesseractBeams) do b.Enabled = (openAlpha > 0.04) end

    local visible = (openAlpha > 0.03)
    for id, s in pairs(screens5D) do
        s.Gui.Enabled, s.TesseractBeam.Enabled, s.Part.CanQuery = visible, visible, (openAlpha > 0.8)
        if not visible then
            s.Part.Transparency, s.TopBar.Transparency, s.Outline.Transparency, s.PopOutline.Transparency = 1, 1, 1, 1
        else
            s.Part.Transparency, s.TopBar.Transparency = 1 - (0.82 * openAlpha), 1 - (0.95 * openAlpha)
            s.Outline.Transparency, s.PopOutline.Transparency = 1 - (0.75 * openAlpha), 1 - (0.45 * openAlpha)
            s.PulseZ = s.PulseZ + (0 - s.PulseZ) * math.min(dt * 8, 1)

            local floatY = math.sin(elapsed * 2.3 + id * 0.9) * 0.07
            local tiltX, tiltY = math.cos(elapsed * 1.8 + id) * math.rad(1.4), math.sin(elapsed * 1.5 + id) * math.rad(1.4)
            local sc = math.max(openAlpha, 0.01)

            s.Part.Size, s.PopPart.Size, s.TopBar.Size = s.BaseSize * sc, (s.BaseSize - Vector3.new(0.25,0.25,0)) * sc, Vector3.new(s.BaseSize.X*0.85,0.06,0.06) * sc
            local targetCF = hubCenterCF * CFrame.new(s.BaseOffset + Vector3.new(0, floatY, -s.PulseZ)) * s.BaseAngles * CFrame.Angles(tiltX, tiltY, 0)
            s.Part.CFrame = tesseractCF:Lerp(targetCF, openAlpha)
            s.PopPart.CFrame = s.Part.CFrame * CFrame.new(0, 0, -(s.PopDepth + s.PulseZ * 0.3) * openAlpha)
            s.TopBar.CFrame = s.Part.CFrame * CFrame.new(0, (s.BaseSize.Y / 2 + 0.09) * openAlpha, 0)
        end
    end
end)