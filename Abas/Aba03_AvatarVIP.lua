-- =====================================================
-- 📜 ARQUIVO: Abas/Aba03_AvatarVIP.lua
-- =====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

_G.Omega5D.Estados.AvatarRGB = false
_G.Omega5D.Estados.Orbes5D = false
_G.Omega5D.Estados.GhostMode = false

-- 1. Corpo Neon RGB
_G.Omega5D:RegistrarModulo(3, "🌈 Corpo Neon RGB 5D", "Transforma seu personagem em energia Neon que muda de cor.", "OFF", function(badge)
	_G.Omega5D.Estados.AvatarRGB = not _G.Omega5D.Estados.AvatarRGB
	badge.Text = _G.Omega5D.Estados.AvatarRGB and "RGB ATIVO" or "OFF"

	if not _G.Omega5D.Estados.AvatarRGB and player.Character then
		for _, p in pairs(player.Character:GetDescendants()) do
			if p:IsA("BasePart") then p.Material = Enum.Material.Plastic end
		end
	end
end)

-- 2. Orbes Planetários 5D Orbitando o Personagem
_G.Omega5D:RegistrarModulo(3, "🪐 Orbes Quânticos Orbitais", "Cria 3 esferas de plasma com rastro girando ao redor do seu corpo.", "OFF", function(badge)
	_G.Omega5D.Estados.Orbes5D = not _G.Omega5D.Estados.Orbes5D
	badge.Text = _G.Omega5D.Estados.Orbes5D and "ORBITANDO" or "OFF"

	local char = player.Character
	if not char then return end
	if char:FindFirstChild("OmegaOrbsFolder") then char.OmegaOrbsFolder:Destroy() end

	if _G.Omega5D.Estados.Orbes5D then
		local folder = Instance.new("Folder", char)
		folder.Name = "OmegaOrbsFolder"
		local colors = {Color3.fromRGB(0, 245, 255), Color3.fromRGB(255, 0, 128), Color3.fromRGB(170, 0, 255)}

		for i = 1, 3 do
			local orb = Instance.new("Part", folder)
			orb.Name = "Orb_" .. i
			orb.Shape = Enum.PartType.Ball
			orb.Material = Enum.Material.Neon
			orb.Color = colors[i]
			orb.Size = Vector3.new(0.65, 0.65, 0.65)
			orb.Anchored = true
			orb.CanCollide = false
			orb.CanQuery = false

			local a0 = Instance.new("Attachment", orb)
			a0.Position = Vector3.new(0, 0.25, 0)
			local a1 = Instance.new("Attachment", orb)
			a1.Position = Vector3.new(0, -0.25, 0)

			local tr = Instance.new("Trail", orb)
			tr.Attachment0 = a0
			tr.Attachment1 = a1
			tr.Color = ColorSequence.new(colors[i], Color3.fromRGB(255, 255, 255))
			tr.Lifetime = 0.4
			tr.LightEmission = 1
			tr.WidthScale = NumberSequence.new(1, 0)
		end
	end
end)

-- 3. Headless Visual (Ficar Sem Cabeça)
_G.Omega5D:RegistrarModulo(3, "🎃 Headless Visual (Sem Cabeça)", "Deixa a cabeça do seu personagem invisível estilo item raro.", "OFF", function(badge)
	local char = player.Character
	if char and char:FindFirstChild("Head") then
		local head = char.Head
		local isHidden = (head.Transparency < 0.9)
		head.Transparency = isHidden and 1 or 0
		if head:FindFirstChild("face") then
			head.face.Transparency = isHidden and 1 or 0
		end
		badge.Text = isHidden and "ATIVADO" or "NORMAL"
	end
end)

-- 4. Rastro Supersônico Neon
_G.Omega5D:RegistrarModulo(3, "✨ Rastro de Luz (Speed Trail)", "Adiciona fitas luminosas de alta velocidade no seu personagem.", "OFF", function(badge)
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if hrp:FindFirstChild("OmegaSpeedTrail") then
		hrp.OmegaSpeedTrail:Destroy()
		badge.Text = "OFF"
	else
		local a0 = Instance.new("Attachment", hrp)
		a0.Position = Vector3.new(0, 2.2, 0)
		local a1 = Instance.new("Attachment", hrp)
		a1.Position = Vector3.new(0, -2.2, 0)

		local trail = Instance.new("Trail", hrp)
		trail.Name = "OmegaSpeedTrail"
		trail.Attachment0 = a0
		trail.Attachment1 = a1
		trail.Color = ColorSequence.new(Color3.fromRGB(0, 245, 255), Color3.fromRGB(170, 0, 255))
		trail.Lifetime = 0.65
		trail.LightEmission = 1
		trail.WidthScale = NumberSequence.new(1, 0)
		badge.Text = "EQUIPADO"
	end
end)

-- 5. Camuflagem Fantasma (Ghost Mode)
_G.Omega5D:RegistrarModulo(3, "👻 Camuflagem Óptica (Fantasma)", "Deixa seu personagem inteiro com efeito holográfico translúcido.", "OFF", function(badge)
	_G.Omega5D.Estados.GhostMode = not _G.Omega5D.Estados.GhostMode
	badge.Text = _G.Omega5D.Estados.GhostMode and "FANTASMA" or "VISÍVEL"
	if player.Character then
		for _, p in pairs(player.Character:GetDescendants()) do
			if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
				p.Transparency = _G.Omega5D.Estados.GhostMode and 0.65 or 0
			end
		end
	end
end)

-- 6. Clone Holográfico 5D (Cria uma estátua de energia sua no mapa!)
_G.Omega5D:RegistrarModulo(3, "👥 Criar Clone Holográfico 5D", "Deixa uma projeção 3D de energia na sua posição atual.", "CLONE", function(badge)
	local char = player.Character
	if not char then return end
	char.Archivable = true
	local clone = char:Clone()
	clone.Name = "HoloClone5D"
	for _, v in pairs(clone:GetDescendants()) do
		if v:IsA("LuaSourceContainer") or v:IsA("Humanoid") then
			v:Destroy()
		elseif v:IsA("BasePart") then
			v.Anchored = true
			v.CanCollide = false
			v.Material = Enum.Material.ForceField
			v.Color = Color3.fromRGB(0, 245, 255)
		end
	end
	clone.Parent = workspace
	game:GetService("Debris"):AddItem(clone, 15)
	badge.Text = "CRIADO (15s)"
end)

-- Loop de Animação da Aba 03
local t = 0
RunService.RenderStepped:Connect(function(dt)
	t = t + dt
	local char = player.Character
	if not char then return end

	if _G.Omega5D.Estados.AvatarRGB then
		local rgb = Color3.fromHSV((t * 0.35) % 1, 0.85, 1)
		for _, p in pairs(char:GetChildren()) do
			if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
				p.Material = Enum.Material.Neon
				p.Color = rgb
			end
		end
	end

	if _G.Omega5D.Estados.Orbes5D and char:FindFirstChild("OmegaOrbsFolder") and char:FindFirstChild("HumanoidRootPart") then
		local rootCF = char.HumanoidRootPart.CFrame
		for i, orb in ipairs(char.OmegaOrbsFolder:GetChildren()) do
			local angle = (t * 3.5) + (i * (math.pi * 2 / 3))
			local yOff = math.sin(t * 4 + i) * 1.6
			orb.CFrame = rootCF * CFrame.new(math.cos(angle) * 3.8, yOff, math.sin(angle) * 3.8)
		end
	end
end)
