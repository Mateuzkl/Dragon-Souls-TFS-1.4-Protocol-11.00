local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. I am Rashid, a traveling merchant. I buy rare and valuable items! Just ask me for a {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|. Come back when you have more items to sell!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")

npcHandler:addModule(FocusModule:new())
