-- =====================================================
-- 📜 ARQUIVO: Abas/Aba05_CasasLotes.lua
-- =====================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

_G.Omega5D = _G.Omega5D or {Estados = {}, ModulosPorAba = {[5]={}}}
_G.Omega5D.Estados.XRay = false
local savedPartsTransparency = {}
local savedWaypointCFrame = nil

local function teleportarPara(cframeDestino)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		player.Character:PivotTo(cframeDestino)
	end
end

-- 1. Visão Raio-X (Ver dentro das casas e prédios)
_G.Omega5D:RegistrarModulo(5, "👁️ Visão Raio-X (X-Ray 5D)", "Deixa as paredes do mapa translúcidas para enxergar o interior.", "OFF", function(badge)
	_G.Omega5D.Estados.XRay = not _G.Omega5D.Estados.XRay
	badge.Text = _G.Omega5D.Estados.XRay and "RAIO-X ON" or "OFF"

	if _G.Omega5D.Estados.XRay then
		for _, obj in pairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj:IsDescendantOf(player.Character) and obj.Transparency < 0.5 then
				savedPartsTransparency[obj] = obj.Transparency
				obj.Transparency = 0.65
			end
		end
	else
		for obj, oldTrans in pairs(savedPartsTransparency) do
			if obj and obj.Parent then
				obj.Transparency = oldTrans
			end
		end
		savedPartsTransparency = {}
	end
end)

-- 2. Salvar Posição da Casa / Esconderijo
_G.Omega5D:RegistrarModulo(5, "📌 Salvar Posição Atual (Home)", "Marca a coordenada exata de onde você está agora.", "SALVAR", function(badge)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		savedWaypointCFrame = player.Character.HumanoidRootPart.CFrame
		badge.Text = "SALVO!"
	end
end)

-- 3. Ir para Posição Salva
_G.Omega5D:RegistrarModulo(5, "🚀 Ir para Posição Salva", "Teleporta você instantaneamente para a coordenada que você salvou.", "IR HOME", function(badge)
	if savedWaypointCFrame then
		teleportarPara(savedWaypointCFrame)
		badge.Text = "TELEPORTADO"
	else
		badge.Text = "SALVE ANTES!"
	end
end)

-- 4. Teleportes Rápidos para Locais do Brookhaven
local locaisBrookhaven = {
	{"🏛️ Praça Central (Spawn)", "Teleporta para o centro da cidade do Brookhaven.", CFrame.new(-26, 4, 18)},
	{"🏦 Cofre do Banco", "Teleporta direto para a área do Banco da cidade.", CFrame.new(-6, 4, 240)},
	{"🚓 Delegacia de Polícia", "Teleporta para a central policial e celas.", CFrame.new(-120, 4, 25)},
	{"🏥 Hospital Central", "Teleporta para a recepção do Hospital do Brookhaven.", CFrame.new(-305, 4, 30)},
	{"🏫 Escola do Brookhaven", "Teleporta para a entrada da Escola.", CFrame.new(-310, 4, 215)},
	{"✈️ Aeroporto Internacional", "Teleporta direto para a pista do Aeroporto.", CFrame.new(315, 4, 40)},
	{"⛰️ Topo da Montanha", "Teleporta para a vista mais alta do mapa.", CFrame.new(-550, 145, -420)}
}

for _, loc in ipairs(locaisBrookhaven) do
	_G.Omega5D:RegistrarModulo(5, loc[1], loc[2], "TELEPORTE", function(badge)
		teleportarPara(loc[3])
		badge.Text = "CHEGOU!"
	end)
end
