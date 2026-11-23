
-- =====================================================
-- 📜 ARQUIVO: Abas/Aba01_Central.lua
-- =====================================================
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

_G.Omega5D = _G.Omega5D or {Estados = {}, ModulosPorAba = {[1]={}}}
_G.Omega5D.Estados.AntiAFK = false
_G.Omega5D.Estados.ZoomInfinito = false

-- 1. Anti-AFK Quântico (Nunca cair por inatividade)
_G.Omega5D:RegistrarModulo(1, "🛡️ Sistema Anti-AFK 5D", "Impede que o Roblox desconecte você após 20 minutos parado.", "OFF", function(badge)
	_G.Omega5D.Estados.AntiAFK = not _G.Omega5D.Estados.AntiAFK
	badge.Text = _G.Omega5D.Estados.AntiAFK and "PROTEGIDO" or "OFF"
end)

player.Idled:Connect(function()
	if _G.Omega5D.Estados.AntiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

-- 2. Câmera Ultra Wide (FOV 110°)
_G.Omega5D:RegistrarModulo(1, "🔭 Câmera Ultra Wide (110°)", "Aumenta o campo de visão para enxergar tudo ao seu redor.", "FOV 70", function(badge)
	camera.FieldOfView = (camera.FieldOfView < 100) and 110 or 70
	badge.Text = "FOV " .. math.floor(camera.FieldOfView)
end)

-- 3. Zoom Infinito de Câmera
_G.Omega5D:RegistrarModulo(1, "🔓 Zoom Infinito de Câmera", "Destrava o limite da câmera para ver o mapa inteiro de cima.", "NORMAL", function(badge)
	_G.Omega5D.Estados.ZoomInfinito = not _G.Omega5D.Estados.ZoomInfinito
	player.CameraMaxZoomDistance = _G.Omega5D.Estados.ZoomInfinito and 9999 or 128
	badge.Text = _G.Omega5D.Estados.ZoomInfinito and "INFINITO" or "NORMAL"
end)

-- 4. Respawn Instantâneo (Sem perder o lugar!)
_G.Omega5D:RegistrarModulo(1, "📍 Respawn na Mesma Posição", "Recarrega seu personagem e volta exatamente para onde você estava.", "REFRESH", function(badge)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local savedCFrame = player.Character.HumanoidRootPart.CFrame
		badge.Text = "AGUARDE..."
		player.Character:BreakJoints()
		local newChar = player.CharacterAdded:Wait()
		local newHrp = newChar:WaitForChild("HumanoidRootPart", 5)
		task.wait(0.15)
		if newHrp then
			newHrp.CFrame = savedCFrame
		end
		badge.Text = "PRONTO!"
	end
end)

-- 5. Rejoin (Reconectar no Mesmo Servidor)
_G.Omega5D:RegistrarModulo(1, "🔄 Reconectar (Rejoin Server)", "Reloga rapidamente neste mesmo servidor do Brookhaven.", "REJOIN", function(badge)
	badge.Text = "ENTRANDO..."
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- 6. Server Hop (Pular para outro Servidor)
_G.Omega5D:RegistrarModulo(1, "🌐 Trocar de Servidor (Server Hop)", "Encontra outro servidor público de Brookhaven e teleporta você.", "HOP", function(badge)
	badge.Text = "BUSCANDO..."
	task.spawn(function()
		local success, result = pcall(function()
			return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
		end)
		if success and result and result.data then
			for _, srv in ipairs(result.data) do
				if type(srv) == "table" and srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
					badge.Text = "TELEPORTANDO!"
					TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id, player)
					return
				end
			end
		end
		badge.Text = "TENTE NOVAMENTE"
	end)
end)