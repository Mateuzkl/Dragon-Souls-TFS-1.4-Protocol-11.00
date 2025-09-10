local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'uh dec'}, 2273, 1750, 10, 'uh dec')
shopModule:addBuyableItem({'lmm dec'}, 2287, 400, 50, 'lmm dec')
shopModule:addBuyableItem({'hmm dec'}, 2311, 1200, 50, 'hmm dec')
shopModule:addBuyableItem({'gfb dec'}, 2304, 1800, 20, 'gfb dec')
shopModule:addBuyableItem({'explosion dec'}, 2313, 2500, 30, 'explosion dec')
shopModule:addBuyableItem({'sd dec'}, 2268, 3500, 10, 'sd dec')

shopModule:addBuyableItem({'blank rune'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'uh'}, 2273, 175, 1, 'uh')
shopModule:addBuyableItem({'lmm'}, 2287, 40, 10, 'lmm')
shopModule:addBuyableItem({'hmm'}, 2311, 120, 5, 'hmm')
shopModule:addBuyableItem({'gfb'}, 2304, 180, 3, 'gfb')
shopModule:addBuyableItem({'explosion'}, 2313, 250, 3, 'explosion')
shopModule:addBuyableItem({'sd'}, 2268, 350, 3, 'sd')

npcHandler:addModule(FocusModule:new())
