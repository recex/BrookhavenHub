-- =====================================================
-- 📜 ARQUIVO: Abas/Aba07_MundoClima.lua
-- =====================================================
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

_G.Omega5D = _G.Omega5D or {Estados = {}, ModulosPorAba = {[7]={}}}
_G.Omega5D.Estados.FullBright = false

-- Salva os valores originais do jogo
local origAmbient = Lighting.Ambient
local origBrightness = Lighting.Brightness
local origClock = Lighting.ClockTime
local origShadows = Lighting.GlobalShadows

-- 1. Visão Noturna FullBright (Sem Escuridão)
_G.Omega5D:RegistrarModulo(7, "💡 Visão FullBright (Sem Escuro)", "Ilumina 100% dos locais escuros, túneis e passagens secretas.", "OFF", function(badge)
	_G.Omega5D.Estados.FullBright = not _G.Omega5D.Estados.FullBright
	if _G.Omega5D.Estados.FullBright then
		Lighting.Ambient = Color3.fromRGB(255, 255, 255)
		Lighting.Brightness = 3
		Lighting.GlobalShadows = false
		badge.Text = "LIGADO"
	else
		Lighting.Ambient = origAmbient
		Lighting.Brightness = origBrightness
		Lighting.GlobalShadows = origShadows
		badge.Text = "OFF"
	end
end)

-- 2. Atmosfera Noite Cyberpunk 5D
_G.Omega5D:RegistrarModulo(7, "🌆 Clima Noite Cyberpunk 5D", "Aplica iluminação noturna neon futurista em toda a cidade.", "CLIMA", function(badge)
	Lighting.ClockTime = 0
	Lighting.Ambient = Color3.fromRGB(35, 60, 110)
	Lighting.OutdoorAmbient = Color3.fromRGB(0, 180, 255)
	Lighting.Brightness = 2.2
	badge.Text = "CYBERPUNK"
end)

-- 3. Pôr do Sol Dourado (Golden Hour)
_G.Omega5D:RegistrarModulo(7, "🌅 Pôr do Sol Cinematográfico", "Deixa o céu do Brookhaven com iluminação dourada de filme.", "CLIMA", function(badge)
	Lighting.ClockTime = 17.6
	Lighting.Ambient = Color3.fromRGB(160, 110, 80)
	Lighting.Brightness = 2.5
	badge.Text = "GOLDEN"
end)

-- 4. Meio-Dia Radiante
_G.Omega5D:RegistrarModulo(7, "☀️ Meio-Dia Solar Limpo", "Deixa o mapa totalmente claro ao meio-dia.", "CLIMA", function(badge)
	Lighting.ClockTime = 14
	Lighting.Ambient = origAmbient
	Lighting.Brightness = 2
	badge.Text = "DIA 14H"
end)

-- 5. Otimizador Quântico de FPS (Remove Lag)
_G.Omega5D:RegistrarModulo(7, "🚀 Boost de FPS (Modo Anti-Lag)", "Otimiza sombras e materiais do mapa para máxima performance.", "FPS BOOST", function(badge)
	Lighting.GlobalShadows = false
	for _, v in pairs(Workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CastShadow = false
		elseif v:IsA("ParticleEmitter") or v:IsA("Smoke") or v:IsA("Fire") then
			v.Enabled = false
		end
	end
	badge.Text = "OTIMIZADO!"
end)

-- 6. Restaurar Mapa Original
_G.Omega5D:RegistrarModulo(7, "🔄 Restaurar Gráficos Originais", "Volta a iluminação, sombras e horário para o padrão do jogo.", "RESET", function(badge)
	_G.Omega5D.Estados.FullBright = false
	Lighting.Ambient = origAmbient
	Lighting.Brightness = origBrightness
	Lighting.ClockTime = origClock
	Lighting.GlobalShadows = origShadows
	badge.Text = "ORIGINAL"
end)
