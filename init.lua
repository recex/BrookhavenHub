-- =========================================================================
-- BROOKHAVEN 5D HUB - COMPACT EDITION (60 SCRIPTS DA INTERNET)
-- GITHUB: https://github.com/recex/BrookhavenHub
-- =========================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- =========================================================================
-- LISTA EXATA DOS 60 SCRIPTS DA INTERNET (DIVIDIDOS NAS 7 ABAS)
-- =========================================================================
local AbasNomes = {
    "01 // BROOKHAVEN HUBS", "02 // ADMINS FE", "03 // TROLL & FLING",
    "04 // VOAR & CARROS", "05 // AVATAR & EMOTES", "06 // ESP & RADAR", "07 // SHADERS & FPS"
}

local ScriptsInternet = {
    -- ABA 1: BROOKHAVEN HUBS (01 a 10)
    [1] = {
        {"#01 Sander X Hub", "https://raw.githubusercontent.com/kigredns/SanderXV4.2.2/refs/heads/main/NormalSS.lua"},
        {"#02 Redz Hub Brookhaven", "https://raw.githubusercontent.com/REDzHUB/REDzHUB/main/REDzHUB"},
        {"#03 Ice Hub Brookhaven", "https://raw.githubusercontent.com/IceMael7/NewIceHub/main/Brookhaven"},
        {"#04 Rael Hub Brookhaven", "https://raw.githubusercontent.com/Laelmano24/Rael-Hub/main/main.txt"},
        {"#05 JulHub Brookhaven", "https://raw.githubusercontent.com/JulHubz/JulHub/main/JulHub"},
        {"#06 Imperial Hub", "https://raw.githubusercontent.com/Trev0rZ/LoaderM/main/ImperialHub-Working.lua"},
        {"#07 Mango Hub", "https://raw.githubusercontent.com/rogelioajax/lua/main/MangoHub"},
        {"#08 Sky Hub Brookhaven", "https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/SkyHub.txt"},
        {"#09 AstroX Brookhaven", "https://raw.githubusercontent.com/AstroXTeam/AstroX-Hub-Neta/main/AstroX"},
        {"#10 Rosh Hub Brookhaven", "https://raw.githubusercontent.com/RoshHub/RoshHub/main/Loader.lua"}
    },
    -- ABA 2: ADMINS FE (11 a 20)
    [2] = {
        {"#11 Infinite Yield FE", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
        {"#12 Nameless Admin", "https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"},
        {"#13 Fates Admin", "https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"},
        {"#14 CMD-X Admin", "https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"},
        {"#15 Reviz Admin V2", "https://pastebin.com/raw/Caniwq2N"},
        {"#16 Shattervast Admin", "https://pastebin.com/raw/iL4NRDux"},
        {"#17 QuirkyCMD Admin", "https://gist.github.com/someunknowndude/38cecea5be9d75cb743eac8b1eaf6758/raw"},
        {"#18 Orca Admin Hub", "https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"},
        {"#19 Leg Admin V2", "https://raw.githubusercontent.com/leg1337/legadmv2/main/legadminv2.lua"},
        {"#20 Proton Admin FE", "https://pastebin.com/raw/1p6G6b2n"}
    },
    -- ABA 3: TROLL & FLING (21 a 30)
    [3] = {
        {"#21 GhostHub Troll", "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub"},
        {"#22 System Broken FE", "https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script"},
        {"#23 Touch Fling GUI", "https://raw.githubusercontent.com/0Ben1/fe./main/Fling%20GUI"},
        {"#24 Yeet Troll GUI", "https://pastebin.com/raw/saMtSz2A"},
        {"#25 FE Telekinesis", "https://pastebin.com/raw/db9C3B8M"},
        {"#26 FE Invisible Troll", "https://pastebin.com/raw/3Rnd9rHf"},
        {"#27 FE Fake Lag Troll", "https://pastebin.com/raw/VM3b0Thg"},
        {"#28 FE Flip & Parkour", "https://pastebin.com/raw/7wDcPtLk"},
        {"#29 FE Chat Bypass", "https://raw.githubusercontent.com/AnnaBypasser/AnnaBypasser/main/AnnaBypasser.lua"},
        {"#30 Universal Fling All", "https://pastebin.com/raw/zqyDSUWX"}
    },
    -- ABA 4: VOAR & CARROS (31 a 40)
    [4] = {
        {"#31 Fly GUI V3", "https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"},
        {"#32 Vehicle Fly GUI", "https://pastebin.com/raw/MHE1cbWF"},
        {"#33 Car Speed Universal", "https://pastebin.com/raw/S9D5Qx4d"},
        {"#34 Walk On Walls FE", "https://pastebin.com/raw/zXk4Rq2r"},
        {"#35 Spider-Man Swing", "https://pastebin.com/raw/2X0h5h5C"},
        {"#36 Click Teleport Tool", "https://pastebin.com/raw/GuBiX19e"},
        {"#37 Noclip GUI Mobile", "https://pastebin.com/raw/B5xRxTnk"},
        {"#38 Speed & Jump GUI", "https://pastebin.com/raw/mC9sJ8kX"},
        {"#39 CFrame Fly Bypass", "https://pastebin.com/raw/YSL3xKYU"},
        {"#40 Infinite Jump GUI", "https://pastebin.com/raw/V5PQy3y0"}
    },
    -- ABA 5: AVATAR & EMOTES (41 a 48)
    [5] = {
        {"#41 Free Emotes GUI", "https://raw.githubusercontent.com/XNEOFF/FEmotesGui/main/FEmotesGui.lua"},
        {"#42 Animation Changer", "https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui"},
        {"#43 Headless & Korblox", "https://pastebin.com/raw/H5yx10Jq"},
        {"#44 FE Ball Roll", "https://pastebin.com/raw/cK8W2Y9a"},
        {"#45 FE Snake Avatar", "https://pastebin.com/raw/RmD3qN7v"},
        {"#46 FE Small Avatar", "https://pastebin.com/raw/p6F9L2xM"},
        {"#47 FE Hat Orbit", "https://pastebin.com/raw/4B2vX9nQ"},
        {"#48 R15 Emotes Hub", "https://raw.githubusercontent.com/Gi7331/scripts/main/Emote.lua"}
    },
    -- ABA 6: ESP & RADAR (49 a 54)
    [6] = {
        {"#49 Unnamed ESP", "https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"},
        {"#50 Owl Hub ESP", "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"},
        {"#51 Player Radar 2D", "https://pastebin.com/raw/7yK8vL2p"},
        {"#52 Hitbox Expander", "https://pastebin.com/raw/5bX9mN3k"},
        {"#53 Spectate GUI", "https://pastebin.com/raw/3vR8pL1n"},
        {"#54 Camlock Universal", "https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"}
    },
    -- ABA 7: SHADERS & FPS (55 a 60)
    [7] = {
        {"#55 PShade RTX Shaders", "https://raw.githubusercontent.com/randomstring0/pshade-ultimate/refs/heads/main/src/cd.lua"},
        {"#56 BShaders Lite", "https://pastebin.com/raw/Unb1cW8k"},
        {"#57 FPS Booster Ultra", "https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"},
        {"#58 Dex Explorer V3", "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"},
        {"#59 SimpleSpy V3", "https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"},
        {"#60 Mobile Keyboard GUI", "https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"}
    }
}

-- =========================================================================
-- PASSO 1: INTRO 3D COMPACTA (ZERO BLUR)
-- =========================================================================
local function makePart(parent, shape, size, color, mat, trans, query)
    local p = Instance.new("Part", parent)
    p.Shape, p.Size, p.Color, p.Material, p.Transparency = shape, size, color, mat, trans
    p.Anchored, p.CanCollide, p.CanTouch, p.CanQuery, p.CastShadow = true, false, false, query or false, false
    return p
end

local introFolder = Instance.new("Folder", camera)
local core = makePart(introFolder, Enum.PartType.Ball, Vector3.new(2,2,2), Color3.fromRGB(0,255,255), Enum.Material.Neon, 0)
local cube = makePart(introFolder, Enum.PartType.Block, Vector3.new(3.5,3.5,3.5), Color3.fromRGB(170,0,255), Enum.Material.ForceField, 0.3)
local bb = Instance.new("BillboardGui", core)
bb.Size, bb.StudsOffset, bb.AlwaysOnTop = UDim2.new(14,0,4,0), Vector3.new(0,-3.5,0), true
local txt = Instance.new("TextLabel", bb)
txt.Size, txt.BackgroundTransparency, txt.Font, txt.TextScaled, txt.TextColor3 = UDim2.new(1,0,1,0), 1, Enum.Font.GothamBlack, true, Color3.new(1,1,1)

local introCon = RunService.RenderStepped:Connect(function()
    local t = tick() * 4
    local pos = camera.CFrame.Position + camera.CFrame.LookVector * 10
    core.CFrame = CFrame.new(pos)
    cube.CFrame = CFrame.new(pos) * CFrame.Angles(t, t*0.7, t*0.4)
end)

for i = 1, 100, 4 do
    txt.Text = "CARREGANDO 60 SCRIPTS 5D... " .. i .. "%"
    task.wait(0.02)
end
introCon:Disconnect()
introFolder:Destroy()

-- =========================================================================
-- PASSO 2: HUB 5D (7 TELAS + 7 ABAS + BOLINHA ARRASTÁVEL)
-- =========================================================================
if camera:FindFirstChild("Hub5D") then camera.Hub5D:Destroy() end
if player.PlayerGui:FindFirstChild("Gui5D") then player.PlayerGui.Gui5D:Destroy() end

local wsFolder = Instance.new("Folder", camera); wsFolder.Name = "Hub5D"
local uiFolder = Instance.new("Folder", player.PlayerGui); uiFolder.Name = "Gui5D"

local tesseract = makePart(wsFolder, Enum.PartType.Block, Vector3.new(0.8,0.8,0.8), Color3.fromRGB(0,255,255), Enum.Material.Neon, 0.1)
local floorPart = makePart(wsFolder, Enum.PartType.Cylinder, Vector3.new(0.1,9,9), Color3.fromRGB(0,255,255), Enum.Material.ForceField, 0.4)

-- Configuração das 7 Telas 5D: {PosOffset, AngOffset, Size3D, CanvasSize}
local cfgs = {
    {Vector3.new(0, 0, 0),      CFrame.Angles(0, 0, 0),               Vector3.new(7.2, 4.4, 0.05), Vector2.new(720, 440)}, -- 1: Central (60 Scripts)
    {Vector3.new(0, 2.8, 0.3),  CFrame.Angles(math.rad(15), 0, 0),    Vector3.new(7.2, 0.8, 0.05), Vector2.new(720, 80)},  -- 2: Topo
    {Vector3.new(-5.1, 0.8, 1), CFrame.Angles(0, math.rad(25), 0),    Vector3.new(2.8, 3.0, 0.05), Vector2.new(280, 300)}, -- 3: Esq Sup (7 Abas)
    {Vector3.new(-5.1,-1.5, 1), CFrame.Angles(0, math.rad(25), 0),    Vector3.new(2.8, 1.2, 0.05), Vector2.new(280, 120)}, -- 4: Esq Inf (Perfil)
    {Vector3.new(5.1, 0.8, 1),  CFrame.Angles(0, math.rad(-25), 0),   Vector3.new(2.8, 2.1, 0.05), Vector2.new(280, 210)}, -- 5: Dir Sup (Status)
    {Vector3.new(5.1,-1.3, 1),  CFrame.Angles(0, math.rad(-25), 0),   Vector3.new(2.8, 1.8, 0.05), Vector2.new(280, 180)}, -- 6: Dir Inf (Logs)
    {Vector3.new(0,-2.8, 0.3),  CFrame.Angles(math.rad(-15), 0, 0),   Vector3.new(7.2, 0.8, 0.05), Vector2.new(720, 80)}   -- 7: Base (Dock)
}

local screens = {}
for i, c in ipairs(cfgs) do
    local p = makePart(wsFolder, Enum.PartType.Block, c[3], Color3.fromRGB(10,14,24), Enum.Material.Glass, 0.15, true)
    local sg = Instance.new("SurfaceGui", uiFolder)
    sg.Adornee, sg.Face, sg.AlwaysOnTop, sg.CanvasSize = p, Enum.NormalId.Back, true, c[4]
    local fr = Instance.new("Frame", sg)
    fr.Size, fr.BackgroundColor3, fr.BackgroundTransparency = UDim2.new(1,0,1,0), Color3.fromRGB(8,10,18), 0.15
    Instance.new("UICorner", fr).CornerRadius = UDim.new(0, 10)
    local st = Instance.new("UIStroke", fr); st.Color, st.Thickness = Color3.fromRGB(0,255,255), 2
    screens[i] = {Part = p, Gui = sg, Frame = fr, Offset = c[1], Ang = c[2], Size = c[3], Pulse = 0}
end

local function quickLabel(parent, text, size, pos, color)
    local l = Instance.new("TextLabel", parent)
    l.Size, l.Position, l.BackgroundTransparency, l.Text, l.TextColor3 = size, pos, 1, text, color or Color3.new(1,1,1)
    l.Font, l.TextSize = Enum.Font.GothamBold, 14
    return l
end

-- TELA 2 (TOPO), TELA 4 (PERFIL), TELA 5 (STATUS), TELA 6 (LOGS), TELA 7 (BASE)
quickLabel(screens[2].Frame, "🌌 RECEX // BROOKHAVEN 5D HUB (60 SCRIPTS DA INTERNET)", UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Color3.fromRGB(0,255,255))
quickLabel(screens[4].Frame, "👤 JOGADOR: " .. player.Name .. "\n⚡ TOTAL: 60 SCRIPTS", UDim2.new(1,0,1,0), UDim2.new(0,0,0,0))
local fpsLbl = quickLabel(screens[5].Frame, "FPS: 60\nPING: OK\n60 SCRIPTS PRONTOS", UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Color3.fromRGB(0,255,160))
local logLbl = quickLabel(screens[6].Frame, "💻 LOGS 5D:\n> Sistema iniciado!", UDim2.new(0.9,0,0.9,0), UDim2.new(0.05,0,0.05,0))
logLbl.TextYAlignment = Enum.TextYAlignment.Top

local distCam = 8.2
local btnZoomIn = Instance.new("TextButton", screens[7].Frame)
btnZoomIn.Size, btnZoomIn.Position, btnZoomIn.Text = UDim2.new(0.45,0,0.7,0), UDim2.new(0.03,0,0.15,0), "➕ APROXIMAR TELAS 5D"
btnZoomIn.BackgroundColor3, btnZoomIn.TextColor3, btnZoomIn.Font, btnZoomIn.TextSize = Color3.fromRGB(16,24,40), Color3.new(1,1,1), Enum.Font.GothamBold, 13
Instance.new("UICorner", btnZoomIn)
btnZoomIn.MouseButton1Click:Connect(function() distCam = math.max(5.5, distCam - 0.8) end)

local btnZoomOut = Instance.new("TextButton", screens[7].Frame)
btnZoomOut.Size, btnZoomOut.Position, btnZoomOut.Text = UDim2.new(0.45,0,0.7,0), UDim2.new(0.52,0,0.15,0), "➖ AFASTAR TELAS 5D"
btnZoomOut.BackgroundColor3, btnZoomOut.TextColor3, btnZoomOut.Font, btnZoomOut.TextSize = Color3.fromRGB(16,24,40), Color3.new(1,1,1), Enum.Font.GothamBold, 13
Instance.new("UICorner", btnZoomOut)
btnZoomOut.MouseButton1Click:Connect(function() distCam = math.min(12, distCam + 0.8) end)

-- TELA 1 (CENTRAL): GRADE DOS 60 SCRIPTS
local titleAba = quickLabel(screens[1].Frame, AbasNomes[1], UDim2.new(1,0,0,35), UDim2.new(0,0,0,4), Color3.fromRGB(0,255,255))
local scroll = Instance.new("ScrollingFrame", screens[1].Frame)
scroll.Size, scroll.Position, scroll.BackgroundTransparency, scroll.ScrollBarThickness = UDim2.new(0.96,0,0.86,0), UDim2.new(0.02,0,0.11,0), 1, 5
local grid = Instance.new("UIGridLayout", scroll)
grid.CellSize, grid.CellPadding = UDim2.new(0.48,0,0,58), UDim2.new(0.02,0,0,8)

local function carregarAba(idx)
    titleAba.Text = AbasNomes[idx]
    for _, v in ipairs(scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for i, s in ipairs(screens) do s.Pulse = 0.8 end

    for _, item in ipairs(ScriptsInternet[idx]) do
        local card = Instance.new("TextButton", scroll)
        card.BackgroundColor3, card.Text = Color3.fromRGB(16, 22, 36), item[1] .. "\n[EXECUTAR LOADSTRING]"
        card.TextColor3, card.Font, card.TextSize = Color3.new(1,1,1), Enum.Font.GothamBold, 13
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
        local st = Instance.new("UIStroke", card); st.Color = Color3.fromRGB(0, 180, 255)

        card.MouseButton1Click:Connect(function()
            logLbl.Text = "💻 LOGS 5D:\n> Executando:\n" .. item[1]
            card.BackgroundColor3 = Color3.fromRGB(0, 140, 100)
            task.spawn(function()
                pcall(function() loadstring(game:HttpGet(item[2], true))() end)
            end)
            task.wait(0.3)
            card.BackgroundColor3 = Color3.fromRGB(16, 22, 36)
        end)
    end
    scroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#ScriptsInternet[idx] / 2) * 68)
end

-- TELA 3 (ESQUERDA): BOTÕES DAS 7 ABAS
local listLayout = Instance.new("UIListLayout", screens[3].Frame)
listLayout.Padding, listLayout.HorizontalAlignment = UDim.new(0, 5), Enum.HorizontalAlignment.Center
for i = 1, 7 do
    local b = Instance.new("TextButton", screens[3].Frame)
    b.Size, b.BackgroundColor3, b.Text = UDim2.new(0.92,0,0,36), Color3.fromRGB(18,24,40), AbasNomes[i]
    b.TextColor3, b.Font, b.TextSize = Color3.new(1,1,1), Enum.Font.GothamBold, 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() carregarAba(i) end)
end
carregarAba(1)

-- BOLINHA FLUTUANTE ARRASTÁVEL (MINIMIZAR / ABRIR)
local orbGui = Instance.new("ScreenGui", uiFolder); orbGui.ResetOnSpawn = false
local orbBtn = Instance.new("TextButton", orbGui)
orbBtn.Size, orbBtn.Position = UDim2.new(0, 64, 0, 64), UDim2.new(0.05, 0, 0.45, 0)
orbBtn.BackgroundColor3, orbBtn.Text, orbBtn.TextColor3 = Color3.fromRGB(10, 15, 28), "5D\n60", Color3.fromRGB(0, 255, 255)
orbBtn.Font, orbBtn.TextSize = Enum.Font.GothamBlack, 15
Instance.new("UICorner", orbBtn).CornerRadius = UDim.new(1, 0)
local orbStroke = Instance.new("UIStroke", orbBtn); orbStroke.Color, orbStroke.Thickness = Color3.fromRGB(0, 255, 255), 2.5

local isOpen, openAlpha, dragging, dragStart, startPos, moved = true, 1, false, nil, nil, 0
orbBtn.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos, moved = true, inp.Position, orbBtn.Position, 0
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - dragStart
        moved = d.Magnitude
        orbBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        if dragging and moved < 10 then isOpen = not isOpen end
        dragging = false
    end
end)

-- LOOP DE ANIMAÇÃO 5D CONTÍNUA
local smoothCF = camera.CFrame
RunService.RenderStepped:Connect(function(dt)
    local t = tick()
    fpsLbl.Text = string.format("FPS: %d\nPING: OK\n60 SCRIPTS ONLINE", math.floor(1/dt))
    openAlpha = openAlpha + ((isOpen and 1 or 0) - openAlpha) * math.min(dt * 10, 1)
    smoothCF = smoothCF:Lerp(camera.CFrame, math.min(dt * 9, 1))

    local rootCF = smoothCF * CFrame.new(0, 0, -distCam)
    tesseract.CFrame = rootCF * CFrame.new(0, 3.6, 0) * CFrame.Angles(t*1.5, t*1.2, t)

    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        floorPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position - Vector3.new(0, 2.9, 0)) * CFrame.Angles(0, t, math.rad(90))
    end

    local vis = openAlpha > 0.05
    for i, s in ipairs(screens) do
        s.Gui.Enabled = vis
        s.Part.CanQuery = openAlpha > 0.8
        s.Part.Transparency = 1 - (0.85 * openAlpha)
        s.Pulse = s.Pulse + (0 - s.Pulse) * math.min(dt * 8, 1)
        s.Part.Size = s.Size * math.max(openAlpha, 0.01)
        local target = rootCF * CFrame.new(s.Offset + Vector3.new(0, math.sin(t*2.5 + i)*0.07, -s.Pulse)) * s.Ang
        s.Part.CFrame = tesseract.CFrame:Lerp(target, openAlpha)
    end
end)