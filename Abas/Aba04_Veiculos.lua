
-- =====================================================
-- 📜 ARQUIVO: Abas/Aba04_Veiculos.lua
-- =====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

_G.Omega5D.Estados.CarTurbo = false
_G.Omega5D.Estados.CarRGB = false
_G.Omega5D.Estados.CarFly = false

-- Função inteligente que encontra o veículo atual que você está sentado
local function obterMeuVeiculo()
	local char = player.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum and hum.SeatPart then
		local seat = hum.SeatPart
		local model = seat:FindFirstAncestorOfClass("Model")
		return seat, model
	end
	return nil, nil
end

-- 1. Turbo Propulsor Quântico
_G.Omega5D:RegistrarModulo(4, "🏎️ Turbo Propulsor (Nitro 5D)", "Acelera o veículo atual muito além do limite do Brookhaven.", "OFF", function(badge)
	_G.Omega5D.Estados.CarTurbo = not _G.Omega5D.Estados.CarTurbo
	badge.Text = _G.Omega5D.Estados.CarTurbo and "NITRO ON" or "OFF"
end)

-- 2. Carro Neon RGB
_G.Omega5D:RegistrarModulo(4, "🌈 Pintura Veicular Neon RGB", "Deixa a lataria do seu carro brilhando em todas as cores.", "OFF", function(badge)
	_G.Omega5D.Estados.CarRGB = not _G.Omega5D.Estados.CarRGB
	badge.Text = _G.Omega5D.Estados.CarRGB and "RGB ATIVO" or "OFF"
end)

-- 3. Voo Veicular (Fly Car 5D)
_G.Omega5D:RegistrarModulo(4, "✈️ Carro Voador (Fly Car 5D)", "Faz seu carro ou moto voar pelo céu na direção da câmera.", "OFF", function(badge)
	_G.Omega5D.Estados.CarFly = not _G.Omega5D.Estados.CarFly
	badge.Text = _G.Omega5D.Estados.CarFly and "VOANDO" or "OFF"
end)

-- 4. Pulo Hidráulico (Saltar Trânsito)
_G.Omega5D:RegistrarModulo(4, "🦘 Suspensão Hidráulica (Pular)", "Dá um impulso vertical no veículo para pular cercas e carros.", "JUMP", function(badge)
	local seat = obterMeuVeiculo()
	if seat then
		seat.AssemblyLinearVelocity = seat.AssemblyLinearVelocity + Vector3.new(0, 85, 0)
		badge.Text = "PULOU!"
	else
		badge.Text = "SENTE NO CARRO"
	end
end)

-- 5. Flip 360° / Desvirar Veículo
_G.Omega5D:RegistrarModulo(4, "🔄 Desvirar Veículo Capotado", "Corrige a rotação do seu carro na hora se ele capotar.", "FIX", function(badge)
	local seat, model = obterMeuVeiculo()
	if seat and model then
		local pos = seat.Position
		model:PivotTo(CFrame.new(pos + Vector3.new(0, 4, 0)))
		badge.Text = "DESVIRADO"
	else
		badge.Text = "SENTE NO CARRO"
	end
end)

-- Loop Físico de Veículos
local t = 0
RunService.RenderStepped:Connect(function(dt)
	t = t + dt
	local seat, carModel = obterMeuVeiculo()
	if not seat then return end

	-- Nitro Turbo
	if _G.Omega5D.Estados.CarTurbo then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.MoveDirection.Magnitude > 0 then
			seat.AssemblyLinearVelocity = seat.CFrame.LookVector * 145 + Vector3.new(0, seat.AssemblyLinearVelocity.Y, 0)
		end
	end

	-- Voo Veicular
	if _G.Omega5D.Estados.CarFly then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.MoveDirection.Magnitude > 0 then
			seat.AssemblyLinearVelocity = camera.CFrame.LookVector * 120
			seat.CFrame = CFrame.new(seat.Position, seat.Position + camera.CFrame.LookVector)
		else
			seat.AssemblyLinearVelocity = Vector3.new(0, 2, 0)
		end
	end

	-- Carro RGB
	if _G.Omega5D.Estados.CarRGB and carModel then
		local rgb = Color3.fromHSV((t * 0.4) % 1, 0.85, 1)
		for _, part in pairs(carModel:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Color = rgb
			end
		end
	end
end)