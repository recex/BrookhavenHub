-- =====================================================
-- 📜 ARQUIVO: init.lua (Coloque na raiz do seu GitHub)
-- =====================================================
local GITHUB_RAW = "https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPO/main/"

-- Ponte Global que conecta todos os arquivos do GitHub nas 7 Telas 5D
_G.Omega5D = _G.Omega5D or {
	Versao = "5D Supreme GitHub Edition",
	Estados = {},
	ModulosPorAba = {[1]={}, [2]={}, [3]={}, [4]={}, [5]={}, [6]={}, [7]={}}
}

-- Função usada pelos arquivos da pasta /Abas/ para adicionar botões no Hub 5D
function _G.Omega5D:RegistrarModulo(abaNumero, titulo, descricao, tagInicial, callback)
	table.insert(self.ModulosPorAba[abaNumero], {
		Titulo = titulo,
		Descricao = descricao,
		Tag = tagInicial,
		Callback = callback
	})
end

-- Função segura para baixar e rodar cada arquivo do seu GitHub
local function carregarDoGitHub(caminhoArquivo)
	local url = GITHUB_RAW .. caminhoArquivo
	local sucesso, resultado = pcall(function()
		return game:HttpGet(url, true)
	end)

	if sucesso and resultado then
		local func, erroCompilacao = loadstring(resultado)
		if func then
			func()
			print("✅ [GitHub 5D] Carregado: " .. caminhoArquivo)
		else
			warn("❌ [Erro de Sintaxe] em " .. caminhoArquivo .. ": " .. tostring(erroCompilacao))
		end
	else
		warn("❌ [Falha de Download] Não foi possível baixar: " .. url)
	end
end

-- 1º Passo: Roda a Animação de Carregamento 3D
carregarDoGitHub("Core/Intro3D.lua")

-- 2º Passo: Abre o Holograma 5D de 7 Telas + Bolinha Deslizável
carregarDoGitHub("Core/Hub5D_Engine.lua")

-- 3º Passo: Carrega todas as 7 Abas da pasta /Abas/
local arquivosDasAbas = {
	"Abas/Aba01_Central.lua",
	"Abas/Aba02_Personagem.lua",
	"Abas/Aba03_AvatarVIP.lua",
	"Abas/Aba04_Veiculos.lua",
	"Abas/Aba05_CasasLotes.lua",
	"Abas/Aba06_JogadoresRadar.lua",
	"Abas/Aba07_MundoClima.lua"
}

for _, arquivo in ipairs(arquivosDasAbas) do
	carregarDoGitHub(arquivo)
end

print("🌌 [OMEGA 5D] Todos os módulos do GitHub foram sincronizados!")
