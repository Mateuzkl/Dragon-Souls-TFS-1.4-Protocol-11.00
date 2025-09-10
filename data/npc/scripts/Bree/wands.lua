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

shopModule:addBuyableItem({'wand of vortex'}, 2190, 500, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath'}, 2191, 1000, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of plague'}, 2188, 2000, 'wand of plague')
shopModule:addBuyableItem({'wand of cosmic energy'}, 2189, 2500, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno'}, 2187, 5000, 'wand of inferno')

shopModule:addBuyableItem({'snakebite rod'}, 2182, 500, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod'}, 2186, 1000, 'moonlight rod')
shopModule:addBuyableItem({'quagmire rod'}, 2181, 2000, 'quagmire rod')
shopModule:addBuyableItem({'volcanic rod'}, 2185, 2500, 'volcanic rod')
shopModule:addBuyableItem({'tempest rod'}, 2183, 5000, 'tempest rod')

npcHandler:addModule(FocusModule:new())