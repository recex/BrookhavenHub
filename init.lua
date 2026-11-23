-- =====================================================
-- 📜 ARQUIVO: init.lua
-- 🔗 Repositório: https://github.com/recex/BrookhavenHub
-- =====================================================
local GITHUB_RAW = "https://raw.githubusercontent.com/recex/BrookhavenHub/main/"

-- Inicializa a Ponte Global 5D
_G.Omega5D = {
	Autor = "recex",
	Versao = "5D Supreme GitHub Edition",
	Estados = {},
	ModulosPorAba = {[1]={}, [2]={}, [3]={}, [4]={}, [5]={}, [6]={}, [7]={}}
}

-- Função que registra os módulos de cada arquivo da pasta /Abas/
function _G.Omega5D:RegistrarModulo(abaNumero, titulo, descricao, tagInicial, callback)
	if not self.ModulosPorAba[abaNumero] then
		self.ModulosPorAba[abaNumero] = {}
	end
	table.insert(self.ModulosPorAba[abaNumero], {
		Titulo = titulo,
		Descricao = descricao,
		Tag = tagInicial,
		Callback = callback
	})
end

-- Função que baixa e executa cada arquivo do seu GitHub
local function carregarArquivo(caminho)
	local url = GITHUB_RAW .. caminho
	local ok, conteudo = pcall(function()
		return game:HttpGet(url, true)
	end)

	if ok and conteudo then
		local fn, err = loadstring(conteudo)
		if fn then
			local execOk, execErr = pcall(fn)
			if execOk then
				print("✅ [BrookhavenHub 5D] Carregado: " .. caminho)
			else
				warn("⚠️ [Erro ao Executar] " .. caminho .. ": " .. tostring(execErr))
			end
		else
			warn("❌ [Erro de Sintaxe] " .. caminho .. ": " .. tostring(err))
		end
	else
		warn("❌ [Não Encontrado no GitHub] Verifique se criou o arquivo: " .. caminho)
	end
end

-- 1º: Executa a Animação de Carregamento 3D
carregarArquivo("Core/Intro3D.lua")

-- 2º: Carrega todas as 7 Abas na memória primeiro
local listaAbas = {
	"Abas/Aba01_Central.lua",
	"Abas/Aba02_Personagem.lua",
	"Abas/Aba03_AvatarVIP.lua",
	"Abas/Aba04_Veiculos.lua",
	"Abas/Aba05_CasasLotes.lua",
	"Abas/Aba06_JogadoresRadar.lua",
	"Abas/Aba07_MundoClima.lua"
}

for _, abaPath in ipairs(listaAbas) do
	carregarArquivo(abaPath)
end

-- 3º: Abre a Estação Holográfica 5D de 7 Telas já com todas as Abas prontas!
carregarArquivo("Core/Hub5D_Engine.lua")

print("🌌 [recex/BrookhavenHub] Estação 5D totalmente carregada!")