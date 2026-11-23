-- =========================================================================
-- ARQUIVO: Core/Intro3D.lua
-- REPOSITÓRIO: https://github.com/recex/BrookhavenHub
-- DESCRIÇÃO: Animação de Carregamento 3D/5D (100% Nítida / Sem Blur)
-- =========================================================================

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera

-- Limpa qualquer intro antiga caso o script seja executado novamente
if camera:FindFirstChild("Ultra3DIntro") then
    camera.Ultra3DIntro:Destroy()
end

-- Pasta para organizar os objetos 3D dentro da câmera
local introFolder = Instance.new("Folder")
introFolder.Name = "Ultra3DIntro"
introFolder.Parent = camera

-- Função auxiliar para criar peças 3D sem colisão e sem bloquear o mouse
local function create3DPart(name, shape, size, color, material, transparency)
    local part = Instance.new("Part")
    part.Name = name
    part.Shape = shape
    part.Size = size
    part.Color = color
    part.Material = material
    part.Transparency = transparency
    part.Anchored = true
    part.CanCollide = false
    part.CanTouch = false
    part.CanQuery = false
    part.CastShadow = false
    part.Parent = introFolder
    return part
end

-- ==========================================
-- 1. NÚCLEO DE ENERGIA E ESCUDO HOLOGRÁFICO
-- ==========================================
local core = create3DPart(
    "EnergyCore",
    Enum.PartType.Ball,
    Vector3.new(0.1, 0.1, 0.1),
    Color3.fromRGB(0, 255, 255),
    Enum.Material.Neon,
    0
)

local shield = create3DPart(
    "ForceFieldShield",
    Enum.PartType.Ball,
    Vector3.new(0.1, 0.1, 0.1),
    Color3.fromRGB(0, 120, 255),
    Enum.Material.ForceField,
    0.2
)

local outerCube = create3DPart(
    "OuterCube",
    Enum.PartType.Block,
    Vector3.new(0.1, 0.1, 0.1),
    Color3.fromRGB(170, 0, 255),
    Enum.Material.Glass,
    1
)

local cubeWireframe = Instance.new("SelectionBox")
cubeWireframe.Color3 = Color3.fromRGB(0, 255, 255)
cubeWireframe.LineThickness = 0.03
cubeWireframe.SurfaceColor3 = Color3.fromRGB(170, 0, 255)
cubeWireframe.SurfaceTransparency = 0.85
cubeWireframe.Adornee = outerCube
cubeWireframe.Parent = outerCube

-- Luz suave no núcleo 3D
local light = Instance.new("PointLight")
light.Color = Color3.fromRGB(0, 255, 255)
light.Range = 20
light.Brightness = 3
light.Parent = core

-- Partículas de energia saindo do núcleo
local particles = Instance.new("ParticleEmitter")
particles.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})
particles.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.25),
    NumberSequenceKeypoint.new(1, 0)
})
particles.Texture = "rbxassetid://243098098"
particles.Lifetime = NumberRange.new(0.5, 1.2)
particles.Rate = 65
particles.Speed = NumberRange.new(3, 7)
particles.SpreadAngle = Vector2.new(360, 360)
particles.LightEmission = 1
particles.Parent = core

-- ==========================================
-- 2. ESFERAS ORBITAIS COM RASTRO (TRAILS)
-- ==========================================
local function createOrbitingOrb(color)
    local orb = create3DPart(
        "Orb",
        Enum.PartType.Ball,
        Vector3.new(0.35, 0.35, 0.35),
        color,
        Enum.Material.Neon,
        0
    )

    local att0 = Instance.new("Attachment", orb)
    att0.Position = Vector3.new(0, 0.18, 0)
    local att1 = Instance.new("Attachment", orb)
    att1.Position = Vector3.new(0, -0.18, 0)

    local trail = Instance.new("Trail")
    trail.Attachment0 = att0
    trail.Attachment1 = att1
    trail.Color = ColorSequence.new(color, Color3.fromRGB(255, 255, 255))
    trail.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    trail.Lifetime = 0.35
    trail.LightEmission = 1
    trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    trail.Parent = orb

    return orb
end

local orb1 = createOrbitingOrb(Color3.fromRGB(0, 255, 255))
local orb2 = createOrbitingOrb(Color3.fromRGB(255, 0, 128))
local orb3 = createOrbitingOrb(Color3.fromRGB(170, 0, 255))
local orb4 = createOrbitingOrb(Color3.fromRGB(0, 255, 150))

-- ==========================================
-- 3. TEXTO HOLOGRÁFICO 3D (BILLBOARD GUI)
-- ==========================================
local billboard = Instance.new("BillboardGui")
billboard.Name = "HoloText"
billboard.Adornee = core
billboard.Size = UDim2.new(16, 0, 7, 0)
billboard.StudsOffset = Vector3.new(0, -4.3, 0)
billboard.AlwaysOnTop = true
billboard.Parent = core

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.45, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BROOKHAVEN // 5D HUB"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
titleLabel.TextStrokeTransparency = 0.2
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextScaled = true
titleLabel.Parent = billboard

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0.25, 0)
statusLabel.Position = UDim2.new(0, 0, 0.45, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "INICIANDO SISTEMA..."
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
statusLabel.Font = Enum.Font.Code
statusLabel.TextScaled = true
statusLabel.Parent = billboard

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0.3, 0)
percentLabel.Position = UDim2.new(0, 0, 0.72, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextScaled = true
percentLabel.Parent = billboard

-- ==========================================
-- 4. ANIMAÇÃO DE ENTRADA E LOOP 3D
-- ==========================================
TweenService:Create(core, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = Vector3.new(2, 2, 2)
}):Play()

TweenService:Create(shield, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    Size = Vector3.new(3.2, 3.2, 3.2)
}):Play()

TweenService:Create(outerCube, TweenInfo.new(1.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = Vector3.new(3.8, 3.8, 3.8)
}):Play()

local startTime = tick()
local spinSpeed = 3
local radius = 4.2
local distanceFromCam = 11

local renderConnection
renderConnection = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - startTime
    local t = elapsed * spinSpeed

    -- Posição central sempre à frente da câmera do jogador
    local centerPos = camera.CFrame.Position + (camera.CFrame.LookVector * distanceFromCam)

    -- Efeito de pulsação (respiração) no escudo
    local pulse = math.sin(elapsed * 6) * 0.25
    shield.Size = Vector3.new(3.2 + pulse, 3.2 + pulse, 3.2 + pulse)

    core.CFrame = CFrame.new(centerPos)
    shield.CFrame = CFrame.new(centerPos) * CFrame.Angles(t * 0.5, t * 0.3, 0)
    outerCube.CFrame = CFrame.new(centerPos) * CFrame.Angles(t * 0.8, t * 0.6, t * 0.4)

    -- Órbitas matemáticas em 3D
    orb1.CFrame = CFrame.new(centerPos) * CFrame.Angles(t, t * 0.5, 0) * CFrame.new(0, 0, radius)
    orb2.CFrame = CFrame.new(centerPos) * CFrame.Angles(-t * 0.8, -t, 0) * CFrame.new(0, 0, radius)
    orb3.CFrame = CFrame.new(centerPos) * CFrame.Angles(0, t * 1.2, t * 0.7) * CFrame.new(radius, 0, 0)
    orb4.CFrame = CFrame.new(centerPos) * CFrame.Angles(t * 1.1, 0, -t * 0.9) * CFrame.new(0, radius, 0)
end)

-- ==========================================
-- 5. PROGRESSO (0% A 100%) E EXPLOSÃO FINAL
-- ==========================================
for i = 1, 100 do
    percentLabel.Text = i .. "%"
    spinSpeed = 3 + (i * 0.08)

    if i == 25 then
        statusLabel.Text = "SINCRONIZANDO REPOSITÓRIO RECEX..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        cubeWireframe.Color3 = Color3.fromRGB(255, 200, 0)
    elseif i == 55 then
        statusLabel.Text = "CARREGANDO 7 TELAS HOLOGRÁFICAS 5D..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 128)
        cubeWireframe.Color3 = Color3.fromRGB(255, 0, 128)
        core.Color = Color3.fromRGB(255, 0, 128)
    elseif i == 85 then
        statusLabel.Text = "INJETANDO MÓDULOS VIP..."
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
        cubeWireframe.Color3 = Color3.fromRGB(0, 255, 150)
        core.Color = Color3.fromRGB(0, 255, 150)
    elseif i == 100 then
        statusLabel.Text = "ACESSO 5D LIBERADO!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    -- Nos últimos 25%, puxa as esferas para dentro do núcleo para concentrar a energia
    if i > 75 then
        radius = radius - 0.14
    end

    task.wait(0.025)
end

task.wait(0.25)

-- Onda de Choque Final (Shockwave 3D) antes de abrir o Hub
local shockwave = create3DPart(
    "Shockwave",
    Enum.PartType.Ball,
    Vector3.new(1, 1, 1),
    Color3.fromRGB(0, 255, 255),
    Enum.Material.ForceField,
    0
)
shockwave.CFrame = core.CFrame

TweenService:Create(shockwave, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = Vector3.new(120, 120, 120),
    Transparency = 1
}):Play()

TweenService:Create(core, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    Size = Vector3.new(0, 0, 0),
    Transparency = 1
}):Play()

TweenService:Create(shield, TweenInfo.new(0.4), {
    Size = Vector3.new(0, 0, 0),
    Transparency = 1
}):Play()

TweenService:Create(outerCube, TweenInfo.new(0.4), {
    Size = Vector3.new(0, 0, 0)
}):Play()

cubeWireframe.Transparency = 1
billboard.Enabled = false

task.wait(0.65)

-- Desconecta o loop e limpa a intro da memória para iniciar o Hub 5D
if renderConnection then
    renderConnection:Disconnect()
end
introFolder:Destroy()
