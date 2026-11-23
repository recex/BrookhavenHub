
-- =====================================================
-- 📜 ARQUIVO: Abas/Aba02_Personagem.lua
-- =====================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

_G.Omega5D = _G.Omega5D or {Estados = {}, ModulosPorAba = {[2]={}}}
_G.Omega5D.Estados.Speed = false
_G.Omega5D.Estados.SuperJump = false
_G.Omega5D.Estados.InfJump = false
_G.Omega5D.Estados.Noclip = false
_G.Omega5D.Estados.Fly5D = false
_G.Omega5D.Estados.AntiFling = false
_G.Omega5D.Estados.AntiSit = false
_G.Omega5D.Estados.LowGravity = false

-- 1. Velocidade Supersônica
_G.Omega5D:RegistrarModulo(2, "⚡ Velocidade Flash (Mach 5)", "Corre em altíssima velocidade sem o jogo resetar seus passos.", "OFF", function(badge)
	_G.Omega5D.Estados.Speed = not _G.Omega5D.Estados.Speed
	badge.Text = _G.Omega5D.Estados.Speed and "ON (95)" or "OFF"
	if not _G.Omega5D.Estados.Speed and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = 16
	end
end)

-- 2. Super Pulo Quântico
_G.Omega5D:RegistrarModulo(2, "🦘 Super Pulo Quântico", "Pula no telhado de qualquer casa ou prédio do Brookhaven.", "OFF", function(badge)
	_G.Omega5D.Estados.SuperJump = not _G.Omega5D.Estados.SuperJump
	badge.Text = _G.Omega5D.Estados.SuperJump and "ON (135)" or "OFF"
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.UseJumpPower = true
		player.Character.Humanoid.JumpPower = _G.Omega5D.Estados.SuperJump and 135 or 50
	end
end)

-- 3. Pulo Infinito no Ar
_G.Omega5D:RegistrarModulo(2, "☁️ Pulo Infinito no Ar", "Pule várias vezes seguidas no ar para subir até as nuvens.", "OFF", function(badge)
	_G.Omega5D.Estados.InfJump = not _G.Omega5D.Estados.InfJump
	badge.Text = _G.Omega5D.Estados.InfJump and "ATIVO" or "OFF"
end)

-- 4. Noclip 5D (Atravessar Paredes e Portas)
_G.Omega5D:RegistrarModulo(2, "👻 Noclip 5D (Atravessar Tudo)", "Atravessa paredes, cofres e qualquer casa trancada.", "OFF", function(badge)
	_G.Omega5D.Estados.Noclip = not _G.Omega5D.Estados.Noclip
	badge.Text = _G.Omega5D.Estados.Noclip and "ATRAVESSANDO" or "OFF"
end)

-- 5. Voo 5D (Modo Superman)
_G.Omega5D:RegistrarModulo(2, "✈️ Voo 5D (Modo Superman)", "Voe livremente pelo mapa na direção em que a câmera olha.", "OFF", function(badge)
	_G.Omega5D.Estados.Fly5D = not _G.Omega5D.Estados.Fly5D
	badge.Text = _G.Omega5D.Estados.Fly5D and "VOANDO" or "OFF"
	if not _G.Omega5D.Estados.Fly5D and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.PlatformStand = false
	end
end)

-- 6. Escudo Anti-Fling
_G.Omega5D:RegistrarModulo(2, "🛡️ Escudo Anti-Fling", "Impede que outros jogadores te joguem para fora do mapa.", "OFF", function(badge)
	_G.Omega5D.Estados.AntiFling = not _G.Omega5D.Estados.AntiFling
	badge.Text = _G.Omega5D.Estados.AntiFling and "PROTEGIDO" or "OFF"
end)

-- 7. Anti-Sentar (Anti-Sofá)
_G.Omega5D:RegistrarModulo(2, "🚫 Anti-Sentar (Anti-Sofá)", "Impede que te peguem com sofá, maca ou carrinho.", "OFF", function(badge)
	_G.Omega5D.Estados.AntiSit = not _G.Omega5D.Estados.AntiSit
	badge.Text = _G.Omega5D.Estados.AntiSit and "BLOQUEADO" or "OFF"
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, not _G.Omega5D.Estados.AntiSit)
	end
end)

-- 8. Gravidade Lunar
_G.Omega5D:RegistrarModulo(2, "🪐 Gravidade Zero (Lunar)", "Diminui a gravidade do mundo para flutuar pelo mapa.", "OFF", function(badge)
	_G.Omega5D.Estados.LowGravity = not _G.Omega5D.Estados.LowGravity
	Workspace.Gravity = _G.Omega5D.Estados.LowGravity and 38 or 196.2
	badge.Text = _G.Omega5D.Estados.LowGravity and "LUNAR" or "NORMAL"
end)

-- Loops de Física da Aba 02
UserInputService.JumpRequest:Connect(function()
	if _G.Omega5D.Estados.InfJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

RunService.Stepped:Connect(function()
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")

	if hum then
		if _G.Omega5D.Estados.Speed then hum.WalkSpeed = 95 end
		if _G.Omega5D.Estados.SuperJump then
			hum.UseJumpPower = true
			hum.JumpPower = 135
		end
		if _G.Omega5D.Estados.AntiSit and hum.Sit then hum.Sit = false end
	end

	if _G.Omega5D.Estados.Noclip then
		for _, part in pairs(char:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = false end
		end
	end

	if _G.Omega5D.Estados.AntiFling and hrp then
		if hrp.AssemblyAngularVelocity.Magnitude > 50 or hrp.AssemblyLinearVelocity.Magnitude > 150 then
			hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		end
	end

	if _G.Omega5D.Estados.Fly5D and hrp and hum then
		hum.PlatformStand = true
		if hum.MoveDirection.Magnitude > 0 then
			hrp.AssemblyLinearVelocity = camera.CFrame.LookVector * 85
			hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + camera.CFrame.LookVector)
		else
			hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		end
	end
end)