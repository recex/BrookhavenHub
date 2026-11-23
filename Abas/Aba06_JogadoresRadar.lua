-- =====================================================
-- 📜 ARQUIVO: Abas/Aba06_JogadoresRadar.lua
-- =====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

_G.Omega5D = _G.Omega5D or {Estados = {}, ModulosPorAba = {[6]={}}}
_G.Omega5D.Estados.ESP5D = false
_G.Omega5D.Estados.Tracers5D = false
_G.Omega5D.Estados.Spectating = false

local targetIndex = 1
local selectedPlayer = nil

local function getOtherPlayers()
	local list = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then table.insert(list, p) end
	end
	return list
end

-- 1. Seletor de Alvo (Muda de jogador a cada clique)
_G.Omega5D:RegistrarModulo(6, "🎯 Selecionar Alvo no Servidor", "Clique para alternar entre os jogadores online na partida.", "BUSCAR", function(badge, btn)
	local list = getOtherPlayers()
	if #list == 0 then
		badge.Text = "VAZIO"
		btn.Text = "NENHUM OUTRO JOGADOR"
		selectedPlayer = nil
		return
	end
	targetIndex = (targetIndex % #list) + 1
	selectedPlayer = list[targetIndex]
	badge.Text = "ALVO #" .. targetIndex
	btn.Text = "🎯 ALVO: " .. selectedPlayer.DisplayName
end)

-- 2. Câmera Espectador no Alvo
_G.Omega5D:RegistrarModulo(6, "🎥 Espionar Alvo (Cam View)", "Assista a tela do jogador selecionado em tempo real.", "OFF", function(badge)
	_G.Omega5D.Estados.Spectating = not _G.Omega5D.Estados.Spectating
	if _G.Omega5D.Estados.Spectating and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChildOfClass("Humanoid") then
		camera.CameraSubject = selectedPlayer.Character:FindFirstChildOfClass("Humanoid")
		badge.Text = "VENDO"
	else
		_G.Omega5D.Estados.Spectating = false
		if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
			camera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
		end
		badge.Text = "OFF"
	end
end)

-- 3. Teleporte Instantâneo até o Alvo
_G.Omega5D:RegistrarModulo(6, "📍 Teleportar até o Alvo", "Teleporta você diretamente para a posição do jogador selecionado.", "TP ALVO", function(badge)
	if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character then
		player.Character:PivotTo(selectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3.5))
		badge.Text = "CHEGOU!"
	else
		badge.Text = "SELECIONE ALVO"
	end
end)

-- 4. Radar ESP 5D Completo (Silhueta + Nome + Distância)
_G.Omega5D:RegistrarModulo(6, "📡 Radar ESP 5D (Ver Todos)", "Mostra a silhueta e a distância de todos os jogadores pelo mapa.", "OFF", function(badge)
	_G.Omega5D.Estados.ESP5D = not _G.Omega5D.Estados.ESP5D
	badge.Text = _G.Omega5D.Estados.ESP5D and "RADAR ON" or "OFF"

	if not _G.Omega5D.Estados.ESP5D then
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				if p.Character:FindFirstChild("OmegaHighlight5D") then p.Character.OmegaHighlight5D:Destroy() end
				if p.Character:FindFirstChild("OmegaTag5D") then p.Character.OmegaTag5D:Destroy() end
			end
		end
	end
end)

-- 5. Linhas Guia Laser 3D (Tracers)
_G.Omega5D:RegistrarModulo(6, "⚡ Feixes Localizadores (Tracers)", "Liga feixes de laser do seu personagem até todos os jogadores.", "OFF", function(badge)
	_G.Omega5D.Estados.Tracers5D = not _G.Omega5D.Estados.Tracers5D
	badge.Text = _G.Omega5D.Estados.Tracers5D and "LASERS ON" or "OFF"

	if not _G.Omega5D.Estados.Tracers5D and player.Character and player.Character:FindFirstChild("OmegaTracersFolder") then
		player.Character.OmegaTracersFolder:Destroy()
	end
end)

-- Loop de Atualização do Radar e Lasers
RunService.RenderStepped:Connect(function()
	local myChar = player.Character
	local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
	if not myHrp then return end

	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local targetHrp = p.Character.HumanoidRootPart
			local dist = math.floor((myHrp.Position - targetHrp.Position).Magnitude)

			-- Atualiza ESP 5D
			if _G.Omega5D.Estados.ESP5D then
				if not p.Character:FindFirstChild("OmegaHighlight5D") then
					local hl = Instance.new("Highlight", p.Character)
					hl.Name = "OmegaHighlight5D"
					hl.FillColor = Color3.fromRGB(0, 245, 255)
					hl.OutlineColor = Color3.fromRGB(255, 255, 255)
					hl.FillTransparency = 0.55
				end

				local tag = p.Character:FindFirstChild("OmegaTag5D")
				if not tag then
					tag = Instance.new("BillboardGui", p.Character)
					tag.Name = "OmegaTag5D"
					tag.Adornee = targetHrp
					tag.Size = UDim2.new(0, 180, 0, 45)
					tag.StudsOffset = Vector3.new(0, 3.5, 0)
					tag.AlwaysOnTop = true

					local txt = Instance.new("TextLabel", tag)
					txt.Name = "InfoText"
					txt.Size = UDim2.new(1, 0, 1, 0)
					txt.BackgroundTransparency = 1
					txt.TextColor3 = Color3.fromRGB(0, 245, 255)
					txt.TextStrokeTransparency = 0.2
					txt.Font = Enum.Font.GothamBold
					txt.TextSize = 13
				end
				if tag:FindFirstChild("InfoText") then
					tag.InfoText.Text = string.format("🌐 %s\n[%d m]", p.DisplayName, dist)
				end
			end
		end
	end
end)
