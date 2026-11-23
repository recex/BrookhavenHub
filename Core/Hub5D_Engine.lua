-- =====================================================
-- 📜 ARQUIVO: Core/Hub5D_Engine.lua
-- 🔗 Repositório: https://github.com/recex/BrookhavenHub
-- =====================================================
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

if camera:FindFirstChild("Omega5DWorkspace") then camera.Omega5DWorkspace:Destroy() end
if playerGui:FindFirstChild("Omega5DGUI") then playerGui.Omega5DGUI:Destroy() end

local folder5D = Instance.new("Folder", camera)
folder5D.Name = "Omega5DWorkspace"

local guiFolder = Instance.new("Folder", playerGui)
guiFolder.Name = "Omega5DGUI"

local currentTheme = Color3.fromRGB(0, 245, 255)
local themeObjects = {}
local animatedGradients = {}
local allScreens = {}
local allBeams = {}

local isMinimized = false
local openAlpha = 0
local targetAlpha = 1
local parallaxEnabled = true
local zoomOffset = 0
local tabSession = 0

local function registerTheme(obj, prop)
	table.insert(themeObjects, {Obj = obj, Prop = prop})
end

local function playSound(id, pitch, vol)
	local s = Instance.new("Sound", Workspace)
	s.SoundId = "rbxassetid://" .. tostring(id)
	s.Volume = vol or 1.3
	s.PlaybackSpeed = pitch or 1
	s:Play()
	game:GetService("Debris"):AddItem(s, 2)
end

local function addAnimatedBorder(frame, thickness)
	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = thickness or 2.2
	stroke.Color = Color3.fromRGB(255, 255, 255)

	local grad = Instance.new("UIGradient", stroke)
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, currentTheme),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 18, 35)),
		ColorSequenceKeypoint.new(1, currentTheme)
	})
	table.insert(animatedGradients, grad)
	return stroke, grad
end

playSound(9114224721, 1.05, 2)

-- 1. HIPERCUBO TESSERACT 4D/5D
local tesseractAnchor = Instance.new("Part", folder5D)
tesseractAnchor.Name = "Tesseract5DCore"
tesseractAnchor.Shape = Enum.PartType.Ball
tesseractAnchor.Material = Enum.Material.Neon
tesseractAnchor.Color = currentTheme
tesseractAnchor.Size = Vector3.new(0.45, 0.45, 0.45)
tesseractAnchor.Anchored = true
tesseractAnchor.CanCollide = false
tesseractAnchor.CanQuery = false
registerTheme(tesseractAnchor, "Color")

local coreCenterAtt = Instance.new("Attachment", tesseractAnchor)

local vertices4D = {}
local vertexAttachments = {}
for x = -1, 1, 2 do
	for y = -1, 1, 2 do
		for z = -1, 1, 2 do
			for w = -1, 1, 2 do
				table.insert(vertices4D, {x = x, y = y, z = z, w = w})
				local att = Instance.new("Attachment", tesseractAnchor)
				table.insert(vertexAttachments, att)
			end
		end
	end
end

for i = 1, 16 do
	for j = i + 1, 16 do
		local v1, v2 = vertices4D[i], vertices4D[j]
		local diff = math.abs(v1.x - v2.x) + math.abs(v1.y - v2.y) + math.abs(v1.z - v2.z) + math.abs(v1.w - v2.w)
		if diff == 2 then
			local beam = Instance.new("Beam", tesseractAnchor)
			beam.Attachment0 = vertexAttachments[i]
			beam.Attachment1 = vertexAttachments[j]
			beam.Color = ColorSequence.new(currentTheme)
			beam.LightEmission = 1
			beam.Transparency = NumberSequence.new(0.15)
			beam.Width0 = 0.055
			beam.Width1 = 0.055
			beam.FaceCamera = true
			table.insert(allBeams, beam)
			registerTheme(beam, "BeamColor")
		end
	end
end

-- 2. PLATAFORMA HOLOGRÁFICA 5D NOS PÉS
local floorPlatform = Instance.new("Part", folder5D)
floorPlatform.Name = "HoloFloor5D"
floorPlatform.Material = Enum.Material.ForceField
floorPlatform.Color = currentTheme
floorPlatform.Size = Vector3.new(0.1, 7.5, 7.5)
floorPlatform.Shape = Enum.PartType.Cylinder
floorPlatform.Anchored = true
floorPlatform.CanCollide = false
floorPlatform.CanQuery = false
registerTheme(floorPlatform, "Color")

local floorRing = Instance.new("Part", folder5D)
floorRing.Size = Vector3.new(5.2, 0.1, 5.2)
floorRing.Transparency = 1
floorRing.Anchored = true
floorRing.CanCollide = false
floorRing.CanQuery = false
local floorBox = Instance.new("SelectionBox", floorRing)
floorBox.Adornee = floorRing
floorBox.Color3 = currentTheme
floorBox.LineThickness = 0.04
registerTheme(floorBox, "Color3")

-- 3. GERADOR DAS 7 TELAS 5D
local function create5DScreen(id, targetSize, cframeOffset, resScale)
	local part = Instance.new("Part", folder5D)
	part.Name = "Screen5D_" .. id
	part.Size = targetSize
	part.Transparency = 0.82
	part.Material = Enum.Material.Glass
	part.Color = Color3.fromRGB(6, 10, 20)
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = true

	local box = Instance.new("SelectionBox", part)
	box.Adornee = part
	box.Color3 = currentTheme
	box.LineThickness = 0.025
	box.SurfaceTransparency = 0.93
	box.SurfaceColor3 = currentTheme
	registerTheme(box, "Color3")
	registerTheme(box, "SurfaceColor3")

	local popOutFrame = Instance.new("Part", folder5D)
	popOutFrame.Size = Vector3.new(targetSize.X * 0.96, targetSize.Y * 0.96, 0.02)
	popOutFrame.Transparency = 1
	popOutFrame.Anchored = true
	popOutFrame.CanCollide = false
	popOutFrame.CanQuery = false

	local popBox = Instance.new("SelectionBox", popOutFrame)
	popBox.Adornee = popOutFrame
	popBox.Color3 = currentTheme
	popBox.LineThickness = 0.015
	popBox.Transparency = 0.35
	registerTheme(popBox, "Color3")

	local neonBar = Instance.new("Part", folder5D)
	neonBar.Size = Vector3.new(targetSize.X, 0.1, 0.1)
	neonBar.Material = Enum.Material.Neon
	neonBar.Color = currentTheme
	neonBar.Anchored = true
	neonBar.CanCollide = false
	neonBar.CanQuery = false
	registerTheme(neonBar, "Color")

	local screenAtt = Instance.new("Attachment", neonBar)
	local beam = Instance.new("Beam", tesseractAnchor)
	beam.Attachment0 = coreCenterAtt
	beam.Attachment1 = screenAtt
	beam.Color = ColorSequence.new(currentTheme)
	beam.LightEmission = 1
	beam.Transparency = NumberSequence.new(0.2, 0.85)
	beam.Width0 = 0.12
	beam.Width1 = 0.03
	beam.FaceCamera = true
	table.insert(allBeams, beam)
	registerTheme(beam, "BeamColor")

	local sGui = Instance.new("SurfaceGui", guiFolder)
	sGui.Name = "GUI_5D_" .. id
	sGui.Adornee = part
	sGui.Face = Enum.NormalId.Back
	sGui.AlwaysOnTop = true
	sGui.LightInfluence = 0
	sGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
	local scale = resScale or 115
	sGui.CanvasSize = Vector2.new(math.floor(targetSize.X * scale), math.floor(targetSize.Y * scale))

	local bg = Instance.new("Frame", sGui)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(8, 12, 22)
	bg.BackgroundTransparency = 0.08
	Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 14)

	addAnimatedBorder(bg, 2.5)

	local screenData = {
		Id = id, Part = part, Box = box, PopPart = popOutFrame, PopBox = popBox,
		Bar = neonBar, Gui = sGui, Bg = bg, TargetSize = targetSize, Offset = cframeOffset, PulseZ = 0
	}
	table.insert(allScreens, screenData)
	return bg, sGui, screenData
end

local bgCenter = create5DScreen(1, Vector3.new(7.4, 4.6, 0.08), CFrame.new(0, 0, 0), 125)
local bgTop = create5DScreen(2, Vector3.new(7.4, 0.95, 0.08), CFrame.new(0, 3.05, 0.25) * CFrame.Angles(math.rad(16), 0, 0), 120)
local bgLeftTabs = create5DScreen(3, Vector3.new(3.1, 3.3, 0.08), CFrame.new(-5.45, 0.65, 0.95) * CFrame.Angles(0, math.rad(26), 0), 120)
local bgLeftBio = create5DScreen(4, Vector3.new(3.1, 1.15, 0.08), CFrame.new(-5.45, -1.75, 0.95) * CFrame.Angles(0, math.rad(26), 0), 120)
local bgRightStats = create5DScreen(5, Vector3.new(3.1, 2.2, 0.08), CFrame.new(5.45, 1.2, 0.95) * CFrame.Angles(0, math.rad(-26), 0), 120)
local bgRightLogs = create5DScreen(6, Vector3.new(3.1, 2.25, 0.08), CFrame.new(5.45, -1.2, 0.95) * CFrame.Angles(0, math.rad(-26), 0), 120)
local bgBottomDock = create5DScreen(7, Vector3.new(7.4, 0.85, 0.08), CFrame.new(0, -2.95, 0.35) * CFrame.Angles(math.rad(-18), 0, 0), 120)

local function trigger5DShockwave()
	camera.FieldOfView = 74
	TweenService:Create(camera, TweenInfo.new(0.45, Enum.EasingStyle.Back), {FieldOfView = 70}):Play()
	task.spawn(function()
		for _, sc in ipairs(allScreens) do
			sc.PulseZ = 0.75
			task.wait(0.03)
		end
	end)
end

-- 4. TELA 6: TERMINAL QUÂNTICO
local logTitle = Instance.new("TextLabel", bgRightLogs)
logTitle.Size = UDim2.new(1, -20, 0, 32)
logTitle.Position = UDim2.new(0, 12, 0, 6)
logTitle.BackgroundTransparency = 1
logTitle.Text = "🌌 TERMINAL // RECEX HUB"
logTitle.TextColor3 = currentTheme
logTitle.Font = Enum.Font.Michroma
logTitle.TextSize = 14
logTitle.TextXAlignment = Enum.TextXAlignment.Left
registerTheme(logTitle, "TextColor3")

local logContainer = Instance.new("Frame", bgRightLogs)
logContainer.Size = UDim2.new(1, -24, 1, -46)
logContainer.Position = UDim2.new(0, 12, 0, 38)
logContainer.BackgroundColor3 = Color3.fromRGB(5, 7, 14)
Instance.new("UICorner", logContainer).CornerRadius = UDim.new(0, 8)

local logList = Instance.new("UIListLayout", logContainer)
logList.Padding = UDim.new(0, 4)
logList.VerticalAlignment = Enum.VerticalAlignment.Bottom

local logLines = {}
local function addSystemLog(msg)
	local lbl = Instance.new("TextLabel", logContainer)
	lbl.Size = UDim2.new(1, -12, 0, 20)
	lbl.BackgroundTransparency = 1
	lbl.Text = " > [" .. os.date("%H:%M:%S") .. "] " .. msg
	lbl.TextColor3 = Color3.fromRGB(165, 255, 210)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = 13
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextTruncate = Enum.TextTruncate.AtEnd
	table.insert(logLines, lbl)
	if #logLines > 9 then
		logLines[1]:Destroy()
		table.remove(logLines, 1)
	end
end

addSystemLog("GitHub recex/BrookhavenHub Conectado.")
addSystemLog("7 Abas 5D Sincronizadas.")

-- 5. TELA 2: TOPO & TEMAS
local brandTitle = Instance.new("TextLabel", bgTop)
brandTitle.Size = UDim2.new(0, 280, 1, 0)
brandTitle.Position = UDim2.new(0, 18, 0, 0)
brandTitle.BackgroundTransparency = 1
brandTitle.Text = "🌌 RECEX // BROOKHAVEN 5D"
brandTitle.TextColor3 = currentTheme
brandTitle.Font = Enum.Font.Michroma
brandTitle.TextSize = 17
brandTitle.TextXAlignment = Enum.TextXAlignment.Left
registerTheme(brandTitle, "TextColor3")

local urlBar = Instance.new("Frame", bgTop)
urlBar.Size = UDim2.new(0, 340, 0, 36)
urlBar.Position = UDim2.new(0, 295, 0.5, -18)
urlBar.BackgroundColor3 = Color3.fromRGB(5, 7, 14)
Instance.new("UICorner", urlBar).CornerRadius = UDim.new(0, 8)

local urlLabel = Instance.new("TextLabel", urlBar)
urlLabel.Size = UDim2.new(1, -16, 1, 0)
urlLabel.Position = UDim2.new(0, 10, 0, 0)
urlLabel.BackgroundTransparency = 1
urlLabel.Text = "🔒 github.com/recex/BrookhavenHub"
urlLabel.TextColor3 = Color3.fromRGB(200, 235, 255)
urlLabel.Font = Enum.Font.Code
urlLabel.TextSize = 14
urlLabel.TextXAlignment = Enum.TextXAlignment.Left

local function setTheme5D(newCol, themeName)
	currentTheme = newCol
	playSound(9114224354, 1.5, 1.8)
	trigger5DShockwave()
	addSystemLog("Tema 5D: " .. themeName)
	for _, grad in ipairs(animatedGradients) do
		grad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, newCol),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 18, 35)),
			ColorSequenceKeypoint.new(1, newCol)
		})
	end
	for _, item in ipairs(themeObjects) do
		if item.Prop == "BeamColor" then
			item.Obj.Color = ColorSequence.new(newCol)
		else
			TweenService:Create(item.Obj, TweenInfo.new(0.35), {[item.Prop] = newCol}):Play()
		end
	end
end

local themes = {
	{Col = Color3.fromRGB(0, 245, 255), Name = "Ciano"},
	{Col = Color3.fromRGB(255, 25, 80), Name = "Rubi"},
	{Col = Color3.fromRGB(190, 40, 255), Name = "Roxo"},
	{Col = Color3.fromRGB(255, 200, 20), Name = "Ouro"},
	{Col = Color3.fromRGB(0, 255, 140), Name = "Matrix"}
}
for i, th in ipairs(themes) do
	local cBtn = Instance.new("TextButton", bgTop)
	cBtn.Size = UDim2.new(0, 32, 0, 32)
	cBtn.Position = UDim2.new(1, -215 + (i - 1) * 40, 0.5, -16)
	cBtn.BackgroundColor3 = th.Col
	cBtn.Text = ""
	Instance.new("UICorner", cBtn).CornerRadius = UDim.new(1, 0)
	cBtn.MouseButton1Click:Connect(function() setTheme5D(th.Col, th.Name) end)
end

-- 6. TELA 4 (PERFIL) & TELA 5 (ONDAS)
local avatarRing = Instance.new("Frame", bgLeftBio)
avatarRing.Size = UDim2.new(0, 76, 0, 76)
avatarRing.Position = UDim2.new(0, 12, 0.5, -38)
avatarRing.BackgroundTransparency = 1
Instance.new("UICorner", avatarRing).CornerRadius = UDim.new(1, 0)
addAnimatedBorder(avatarRing, 3)

local avatarImg = Instance.new("ImageLabel", avatarRing)
avatarImg.Size = UDim2.new(1, -8, 1, -8)
avatarImg.Position = UDim2.new(0, 4, 0, 4)
avatarImg.BackgroundColor3 = Color3.fromRGB(16, 22, 36)
Instance.new("UICorner", avatarImg).CornerRadius = UDim.new(1, 0)
task.spawn(function()
	avatarImg.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)

local bioText = Instance.new("TextLabel", bgLeftBio)
bioText.Size = UDim2.new(1, -100, 1, -16)
bioText.Position = UDim2.new(0, 96, 0, 8)
bioText.BackgroundTransparency = 1
bioText.Text = "USER: " .. player.DisplayName .. "\nREPO: BrookhavenHub\nDIMENSÃO: 5D SYNC"
bioText.TextColor3 = Color3.fromRGB(230, 245, 255)
bioText.Font = Enum.Font.GothamBold
bioText.TextSize = 14
bioText.TextXAlignment = Enum.TextXAlignment.Left

local statHeader = Instance.new("TextLabel", bgRightStats)
statHeader.Size = UDim2.new(1, -20, 0, 32)
statHeader.Position = UDim2.new(0, 12, 0, 6)
statHeader.BackgroundTransparency = 1
statHeader.Text = "📊 RESSONÂNCIA 5D // TELA 05"
statHeader.TextColor3 = currentTheme
statHeader.Font = Enum.Font.Michroma
statHeader.TextSize = 14
statHeader.TextXAlignment = Enum.TextXAlignment.Left
registerTheme(statHeader, "TextColor3")

local liveStatsLabel = Instance.new("TextLabel", bgRightStats)
liveStatsLabel.Size = UDim2.new(1, -24, 0, 75)
liveStatsLabel.Position = UDim2.new(0, 12, 0, 38)
liveStatsLabel.BackgroundTransparency = 1
liveStatsLabel.Text = "FPS QUÂNTICO: 60\nLATÊNCIA: 45ms\nFORÇA G: ATIVA"
liveStatsLabel.TextColor3 = Color3.fromRGB(220, 240, 255)
liveStatsLabel.Font = Enum.Font.GothamBold
liveStatsLabel.TextSize = 14
liveStatsLabel.TextXAlignment = Enum.TextXAlignment.Left

local graphContainer = Instance.new("Frame", bgRightStats)
graphContainer.Size = UDim2.new(1, -24, 0, 80)
graphContainer.Position = UDim2.new(0, 12, 1, -90)
graphContainer.BackgroundColor3 = Color3.fromRGB(5, 8, 15)
Instance.new("UICorner", graphContainer).CornerRadius = UDim.new(0, 8)

local waveBars = {}
for i = 1, 15 do
	local bar = Instance.new("Frame", graphContainer)
	bar.Size = UDim2.new(0, 15, 0.5, 0)
	bar.Position = UDim2.new(0, 8 + (i - 1) * 22, 1, -6)
	bar.AnchorPoint = Vector2.new(0, 1)
	bar.BackgroundColor3 = currentTheme
	Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)
	registerTheme(bar, "BackgroundColor3")
	table.insert(waveBars, bar)
end

-- 7. TELA 1 & TELA 3: CONECTADAS COM AS 7 ABAS DO GITHUB
local centerHeader = Instance.new("TextLabel", bgCenter)
centerHeader.Size = UDim2.new(0.58, 0, 0, 48)
centerHeader.Position = UDim2.new(0, 20, 0, 12)
centerHeader.BackgroundTransparency = 1
centerHeader.Text = "01 // CENTRAL OMEGA"
centerHeader.TextColor3 = currentTheme
centerHeader.Font = Enum.Font.Michroma
centerHeader.TextSize = 22
centerHeader.TextXAlignment = Enum.TextXAlignment.Left
registerTheme(centerHeader, "TextColor3")

local searchBox = Instance.new("TextBox", bgCenter)
searchBox.Size = UDim2.new(0.36, 0, 0, 38)
searchBox.Position = UDim2.new(0.62, 0, 0, 16)
searchBox.BackgroundColor3 = Color3.fromRGB(14, 20, 36)
searchBox.PlaceholderText = "🔍 Buscar função no GitHub..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderColor3 = Color3.fromRGB(140, 160, 190)
searchBox.Font = Enum.Font.GothamBold
searchBox.TextSize = 14
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)
addAnimatedBorder(searchBox, 1.5)

local cardsGridScroll = Instance.new("ScrollingFrame", bgCenter)
cardsGridScroll.Size = UDim2.new(1, -36, 1, -78)
cardsGridScroll.Position = UDim2.new(0, 18, 0, 68)
cardsGridScroll.BackgroundTransparency = 1
cardsGridScroll.ScrollBarThickness = 6
cardsGridScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
cardsGridScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
registerTheme(cardsGridScroll, "ScrollBarImageColor3")

local gridLayout = Instance.new("UIGridLayout", cardsGridScroll)
gridLayout.CellSize = UDim2.new(0, 282, 0, 145)
gridLayout.CellPadding = UDim2.new(0, 14, 0, 14)

local currentCards = {}
local function create5DCard(title, desc, statusTag, onClick)
	local cellWrapper = Instance.new("Frame", cardsGridScroll)
	cellWrapper.Name = string.lower(title .. " " .. desc)
	cellWrapper.BackgroundTransparency = 1

	local card = Instance.new("Frame", cellWrapper)
	card.Size = UDim2.new(0.1, 0, 0.1, 0)
	card.Position = UDim2.new(0.5, 0, 0.9, 0)
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.BackgroundColor3 = Color3.fromRGB(14, 20, 36)
	card.Rotation = -10
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
	addAnimatedBorder(card, 1.6)

	local cTitle = Instance.new("TextLabel", card)
	cTitle.Size = UDim2.new(1, -90, 0, 28)
	cTitle.Position = UDim2.new(0, 14, 0, 10)
	cTitle.BackgroundTransparency = 1
	cTitle.Text = title
	cTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	cTitle.Font = Enum.Font.GothamBold
	cTitle.TextSize = 15
	cTitle.TextXAlignment = Enum.TextXAlignment.Left

	local badge = Instance.new("TextLabel", card)
	badge.Size = UDim2.new(0, 74, 0, 22)
	badge.Position = UDim2.new(1, -84, 0, 12)
	badge.BackgroundColor3 = Color3.fromRGB(6, 10, 18)
	badge.Text = statusTag
	badge.TextColor3 = currentTheme
	badge.Font = Enum.Font.GothamBold
	badge.TextSize = 11
	Instance.new("UICorner", badge).CornerRadius = UDim.new(1, 0)
	registerTheme(badge, "TextColor3")

	local cDesc = Instance.new("TextLabel", card)
	cDesc.Size = UDim2.new(1, -28, 0, 44)
	cDesc.Position = UDim2.new(0, 14, 0, 40)
	cDesc.BackgroundTransparency = 1
	cDesc.Text = desc
	cDesc.TextColor3 = Color3.fromRGB(165, 185, 215)
	cDesc.Font = Enum.Font.GothamMedium
	cDesc.TextSize = 13
	cDesc.TextWrapped = true
	cDesc.TextXAlignment = Enum.TextXAlignment.Left

	local btn = Instance.new("TextButton", card)
	btn.Size = UDim2.new(1, -28, 0, 36)
	btn.Position = UDim2.new(0, 14, 1, -46)
	btn.BackgroundColor3 = Color3.fromRGB(24, 34, 60)
	btn.Text = "🌌 EXECUTAR MÓDULO"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	TweenService:Create(card, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Rotation = 0
	}):Play()

	btn.MouseButton1Click:Connect(function()
		playSound(9114224354, 1.8, 1.5)
		trigger5DShockwave()
		addSystemLog("Executado: " .. title)
		if onClick then onClick(badge, btn) end
	end)

	table.insert(currentCards, cellWrapper)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local q = string.lower(searchBox.Text)
	for _, c in ipairs(currentCards) do
		if c.Parent then c.Visible = (q == "" or string.find(c.Name, q, 1, true) ~= nil) end
	end
end)

local tabNames = {
	{Id = "01", Name = "CENTRAL OMEGA"},
	{Id = "02", Name = "PERSONAGEM"},
	{Id = "03", Name = "AVATAR & EFEITOS"},
	{Id = "04", Name = "VEÍCULOS & TURBO"},
	{Id = "05", Name = "CASAS & LOTES"},
	{Id = "06", Name = "JOGADORES & RADAR"},
	{Id = "07", Name = "MUNDO & CLIMA"}
}

local tabsHeader = Instance.new("TextLabel", bgLeftTabs)
tabsHeader.Size = UDim2.new(1, -20, 0, 34)
tabsHeader.Position = UDim2.new(0, 12, 0, 6)
tabsHeader.BackgroundTransparency = 1
tabsHeader.Text = "🗂️ 7 ABAS // TELA 03"
tabsHeader.TextColor3 = currentTheme
tabsHeader.Font = Enum.Font.Michroma
tabsHeader.TextSize = 14
tabsHeader.TextXAlignment = Enum.TextXAlignment.Left
registerTheme(tabsHeader, "TextColor3")

local tabsListFrame = Instance.new("Frame", bgLeftTabs)
tabsListFrame.Size = UDim2.new(1, -20, 1, -48)
tabsListFrame.Position = UDim2.new(0, 10, 0, 42)
tabsListFrame.BackgroundTransparency = 1
local tListLayout = Instance.new("UIListLayout", tabsListFrame)
tListLayout.Padding = UDim.new(0, 6)

local tabButtons = {}
local function openTab5D(tabIndex)
	local tab = tabNames[tabIndex]
	if not tab then return end

	tabSession = tabSession + 1
	local mySession = tabSession

	playSound(9114224721, 1.65, 1.5)
	trigger5DShockwave()
	searchBox.Text = ""
	currentCards = {}

	for idx, btn in ipairs(tabButtons) do
		TweenService:Create(btn, TweenInfo.new(0.25), {
			BackgroundColor3 = (idx == tabIndex) and Color3.fromRGB(35, 55, 100) or Color3.fromRGB(14, 20, 36),
			TextColor3 = (idx == tabIndex) and currentTheme or Color3.fromRGB(255, 255, 255)
		}):Play()
	end

	for _, c in pairs(cardsGridScroll:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end

	centerHeader.Text = tab.Id .. " // " .. tab.Name
	urlLabel.Text = "🔒 github.com/recex/BrookhavenHub/Aba-" .. tab.Id
	addSystemLog("Aba " .. tab.Id .. " carregada do GitHub.")

	task.spawn(function()
		local modulosGitHub = (_G.Omega5D and _G.Omega5D.ModulosPorAba and _G.Omega5D.ModulosPorAba[tabIndex]) or {}
		for _, mod in ipairs(modulosGitHub) do
			if tabSession ~= mySession then break end
			create5DCard(mod.Titulo, mod.Descricao, mod.Tag, function(badge, btn)
				mod.Callback(badge, btn)
				mod.Tag = badge.Text
			end)
			playSound(6895079853, 1.65, 0.45)
			task.wait(0.045)
		end
	end)
end

for idx, tab in ipairs(tabNames) do
	local tBtn = Instance.new("TextButton", tabsListFrame)
	tBtn.Size = UDim2.new(1, 0, 0, 42)
	tBtn.BackgroundColor3 = Color3.fromRGB(14, 20, 36)
	tBtn.Text = "  " .. tab.Id .. " | " .. tab.Name
	tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tBtn.Font = Enum.Font.GothamBold
	tBtn.TextSize = 14
	tBtn.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
	addAnimatedBorder(tBtn, 1.2)
	tBtn.MouseButton1Click:Connect(function() openTab5D(idx) end)
	table.insert(tabButtons, tBtn)
end

-- 8. TELA 7: BASE INFERIOR DE CONTROLE
local dockLayout = Instance.new("UIListLayout", bgBottomDock)
dockLayout.FillDirection = Enum.FillDirection.Horizontal
dockLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
dockLayout.VerticalAlignment = Enum.VerticalAlignment.Center
dockLayout.Padding = UDim.new(0, 12)

local function createDockButton(text, width, callback)
	local dBtn = Instance.new("TextButton", bgBottomDock)
	dBtn.Size = UDim2.new(0, width, 0, 56)
	dBtn.BackgroundColor3 = Color3.fromRGB(16, 24, 44)
	dBtn.Text = text
	dBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	dBtn.Font = Enum.Font.GothamBold
	dBtn.TextSize = 14
	Instance.new("UICorner", dBtn).CornerRadius = UDim.new(0, 10)
	addAnimatedBorder(dBtn, 1.5)
	dBtn.MouseButton1Click:Connect(callback)
	return dBtn
end

createDockButton("➕ APROXIMAR 5D", 190, function() zoomOffset = math.clamp(zoomOffset + 0.8, -3, 2.5); trigger5DShockwave() end)
createDockButton("➖ AFASTAR 5D", 190, function() zoomOffset = math.clamp(zoomOffset - 0.8, -3, 2.5); trigger5DShockwave() end)
local lockBtn
lockBtn = createDockButton("🌌 INÉRCIA 5D: ON", 190, function()
	parallaxEnabled = not parallaxEnabled
	lockBtn.Text = parallaxEnabled and "🌌 INÉRCIA 5D: ON" or "🔒 INÉRCIA 5D: FIXA"
end)
createDockButton("💥 PULSO TESSERACT", 190, function() playSound(9114224721, 1.75, 1.7); trigger5DShockwave() end)

openTab5D(1)

-- 9. BOLINHA DESLIZÁVEL 5D
local orbScreenGui = Instance.new("ScreenGui", guiFolder)
orbScreenGui.Name = "Draggable5DOrbGui"
orbScreenGui.IgnoreGuiInset = true
orbScreenGui.ResetOnSpawn = false

local orbButton = Instance.new("TextButton", orbScreenGui)
orbButton.Size = UDim2.new(0, 70, 0, 70)
orbButton.Position = UDim2.new(0.08, 0, 0.28, 0)
orbButton.AnchorPoint = Vector2.new(0.5, 0.5)
orbButton.BackgroundColor3 = Color3.fromRGB(8, 12, 24)
orbButton.Text = "5D"
orbButton.TextColor3 = currentTheme
orbButton.Font = Enum.Font.Michroma
orbButton.TextSize = 20
orbButton.AutoButtonColor = false
Instance.new("UICorner", orbButton).CornerRadius = UDim.new(1, 0)
registerTheme(orbButton, "TextColor3")
addAnimatedBorder(orbButton, 3.5)

local outerOrbRing = Instance.new("Frame", orbButton)
outerOrbRing.Size = UDim2.new(1, 14, 1, 14)
outerOrbRing.Position = UDim2.new(0.5, 0, 0.5, 0)
outerOrbRing.AnchorPoint = Vector2.new(0.5, 0.5)
outerOrbRing.BackgroundTransparency = 1
Instance.new("UICorner", outerOrbRing).CornerRadius = UDim.new(1, 0)
addAnimatedBorder(outerOrbRing, 2)

local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
local movedDistance = 0

orbButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		movedDistance = 0
		dragStart = input.Position
		startPos = orbButton.Position
		TweenService:Create(orbButton, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 82, 0, 82)}):Play()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				TweenService:Create(orbButton, TweenInfo.new(0.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 70, 0, 70)}):Play()
				if movedDistance < 10 then
					isMinimized = not isMinimized
					targetAlpha = isMinimized and 0 or 1
					playSound(9114224721, isMinimized and 1.95 or 1.1, 2)
					trigger5DShockwave()
					orbButton.Text = isMinimized and "🌌" or "5D"
				end
			end
		end)
	end
end)

orbButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		movedDistance = delta.Magnitude
		local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		TweenService:Create(orbButton, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {Position = targetPos}):Play()
	end
end)

-- 10. MOTOR FÍSICO 5D
local t = 0
local tiltX, tiltY, rollZ = 0, 0, 0
local lastCamLook = camera.CFrame.LookVector
local frameCounter = 0
local lastClock = os.clock()

RunService.RenderStepped:Connect(function(dt)
	if not folder5D.Parent then return end
	t = t + dt
	frameCounter = frameCounter + 1

	local rotAngle = (t * 160) % 360
	for _, grad in ipairs(animatedGradients) do
		if grad.Parent then grad.Rotation = rotAngle end
	end

	for idx, bar in ipairs(waveBars) do
		local waveH = 0.18 + ((math.sin(t * 7 + idx * 0.55) + 1) / 2) * 0.75
		bar.Size = UDim2.new(0, 15, waveH, 0)
	end

	if os.clock() - lastClock >= 0.5 then
		local fps = math.floor(frameCounter / (os.clock() - lastClock))
		local ping = 45
		pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
		liveStatsLabel.Text = string.format("FPS QUÂNTICO: %d\nLATÊNCIA: %dms\nPLAYERS: %d", fps, ping, #Players:GetPlayers())
		frameCounter = 0
		lastClock = os.clock()
	end

	openAlpha = openAlpha + (targetAlpha - openAlpha) * math.clamp(dt * 10, 0, 1)
	local show5D = (openAlpha > 0.03)

	local camLook = camera.CFrame.LookVector
	local camDelta = camLook - lastCamLook
	lastCamLook = camLook

	if parallaxEnabled then
		local mPos = UserInputService:GetMouseLocation()
		local vp = camera.ViewportSize
		local nx = math.clamp(((mPos.X / vp.X) - 0.5) * 2, -1, 1)
		local ny = math.clamp(((mPos.Y / vp.Y) - 0.5) * 2, -1, 1)
		tiltX = tiltX + (((-ny * 0.08) + (camDelta.Y * 1.8)) - tiltX) * 0.12
		tiltY = tiltY + (((-nx * 0.11) - (camDelta.X * 1.8)) - tiltY) * 0.12
		rollZ = rollZ + ((-camDelta.X * 1.2) - rollZ) * 0.12
	else
		tiltX = tiltX + (0 - tiltX) * 0.15
		tiltY = tiltY + (0 - tiltY) * 0.15
		rollZ = rollZ + (0 - rollZ) * 0.15
	end

	local vp = camera.ViewportSize
	local baseDist = ((vp.X / vp.Y) < 1.5) and -10.5 or -8.6
	local floatY = math.sin(t * 2.4) * 0.1

	local stationCF = camera.CFrame * CFrame.new(0, floatY, baseDist + zoomOffset) * CFrame.Angles(tiltX, tiltY, rollZ)

	local coreCF = stationCF * CFrame.new(0, 4.15, 0.5)
	tesseractAnchor.CFrame = coreCF
	tesseractAnchor.Transparency = show5D and 0 or 1

	local angleXW, angleYW, angleZW = t * 1.6, t * 1.2, t * 0.9
	for i, v in ipairs(vertices4D) do
		local x1 = v.x * math.cos(angleXW) - v.w * math.sin(angleXW)
		local w1 = v.x * math.sin(angleXW) + v.w * math.cos(angleXW)
		local y1 = v.y * math.cos(angleYW) - w1 * math.sin(angleYW)
		local w2 = v.y * math.sin(angleYW) + w1 * math.cos(angleYW)
		local z1 = v.z * math.cos(angleZW) - w2 * math.sin(angleZW)
		local w3 = v.z * math.sin(angleZW) + w2 * math.cos(angleZW)
		local wFactor = 1 / (2.4 - w3)
		local scale = 1.35 * openAlpha
		vertexAttachments[i].Position = Vector3.new(x1 * wFactor * scale, y1 * wFactor * scale, z1 * wFactor * scale)
	end

	for _, b in ipairs(allBeams) do b.Enabled = show5D end

	if show5D and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local rootCF = player.Character.HumanoidRootPart.CFrame
		floorPlatform.CFrame = CFrame.new(rootCF.Position - Vector3.new(0, 2.9, 0)) * CFrame.Angles(0, t * 1.5, math.rad(90))
		floorRing.CFrame = CFrame.new(rootCF.Position - Vector3.new(0, 2.85, 0)) * CFrame.Angles(0, -t * 2.2, 0)
		floorPlatform.Transparency = 1 - (0.65 * openAlpha)
		floorBox.Visible = true
	else
		floorPlatform.Transparency = 1
		floorBox.Visible = false
	end

	local collapsedOffset = CFrame.new(0, 4.15, 0.5) * CFrame.Angles(math.rad(90), math.rad(180), 0)
	for _, sc in ipairs(allScreens) do
		sc.PulseZ = sc.PulseZ + (0 - sc.PulseZ) * 0.14
		local individualBob = math.sin(t * 3 + sc.Id * 0.85) * 0.045
		local fullOffset = sc.Offset * CFrame.new(0, individualBob, -sc.PulseZ)
		local currentOffset = collapsedOffset:Lerp(fullOffset, openAlpha)

		sc.Part.CFrame = stationCF * currentOffset
		sc.Part.Size = Vector3.new(0.05, 0.05, 0.05):Lerp(sc.TargetSize, openAlpha)

		local popDepth = 0.22 + math.sin(t * 4 + sc.Id) * 0.06
		sc.PopPart.CFrame = sc.Part.CFrame * CFrame.new(0, 0, -popDepth * openAlpha)
		sc.PopPart.Size = Vector3.new(sc.Part.Size.X * 0.96, sc.Part.Size.Y * 0.96, 0.02)

		sc.Bar.CFrame = sc.Part.CFrame * CFrame.new(0, (sc.Part.Size.Y / 2) + 0.08, 0)
		sc.Bar.Size = Vector3.new(sc.Part.Size.X, 0.1 * openAlpha, 0.1 * openAlpha)

		sc.Gui.Enabled = (openAlpha > 0.15)
		sc.Box.Visible = show5D
		sc.PopBox.Visible = show5D
		sc.Part.CanQuery = (openAlpha > 0.8)
		sc.Part.Transparency = show5D and (1 - (0.18 * openAlpha)) or 1
		sc.Bar.Transparency = show5D and 0 or 1
	end
end)
