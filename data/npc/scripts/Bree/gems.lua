local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'black pearl'},			2144, 280,		'black pearl')
shopModule:addSellableItem({'small amethyst'},			2150, 200,		'small amethyst')
shopModule:addSellableItem({'small diamond'},			2145, 300,		'small diamond')
shopModule:addSellableItem({'small emerald'},			2149, 250,		'small emerald')
shopModule:addSellableItem({'small sapphire'},			2146, 250,		'small sapphire')
shopModule:addSellableItem({'small ruby'},			2147, 250,		'small ruby')
shopModule:addSellableItem({'white pearl'},			2143, 160,		'white pearl')

npcHandler:addModule(FocusModule:new())