local config = {
minlevel = 150, --- level inical para resetar
price = 10000, --- preço inicial para resetar
newlevel = 20, --- level após reset
priceByReset = 0, --- preço acrescentado por reset
percent = 100, ---- porcentagem da vida/mana que você terá ao resetar (em relação à sua antiga vida total)
maxresets = 50,
levelbyreset = 0 --- quanto de level vai precisar a mais no próximo reset
}
--- end config

function getResets(uid)
resets = getPlayerStorageValue(uid, 378378)
  if resets < 0 then
            resets = 0
          end
return resets
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                  npcHandler:onThink()                  end
 
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


 function addReset(cid)
	if(npcHandler:isFocused(cid)) then
		npcHandler:releaseFocus(cid)
	end		
	talkState[talkUser] = 0
	resets = getResets(cid)
	setPlayerStorageValue(cid, 378378, resets+1) 
	doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
	local hp = getCreatureMaxHealth(cid)
	local resethp = hp*(config.percent/100)
	setCreatureMaxHealth(cid, resethp)
	local differencehp = (hp - resethp)
	doCreatureAddHealth(cid, -differencehp)
	local mana = getCreatureMaxMana(cid)
	local resetmana = mana*(config.percent/100)
	setCreatureMaxMana(cid, resetmana)
	local differencemana = (mana - resetmana)
	doCreatureAddMana(cid, -differencemana)
    doRemoveCreature(cid)		
	local description = resets+1
    db.executeQuery("UPDATE `players` SET `description` = ' [Reset: "..description.."]' WHERE `players`.`id`= ".. playerid .."")
	db.executeQuery("UPDATE `players` SET `level`="..config.newlevel..",`experience`= 0 WHERE `players`.`id`= ".. playerid .."")
    return true
end


local newPrice = config.price + (getResets(cid) * config.priceByReset)
local newminlevel = config.minlevel + (getResets(cid) * config.levelbyreset)

if msgcontains(msg, 'reset') then
	if getResets(cid) < config.maxresets then
		selfSay('You want to reset your character? It will cost '..newPrice..' gp\'s!', cid)
		talkState[talkUser] = 1
	else
		selfSay('You already reached the maximum reset level!', cid)
	end
elseif(msgcontains(msg, 'yes') and talkState[talkUser] == 1) then
	if getPlayerMoney(cid) < newPrice then
		selfSay('Its necessary to have at least '..newPrice..' gp\'s for reseting!', cid)
	elseif getPlayerLevel(cid) < newminlevel then
		selfSay('The minimum level for reseting is '..newminlevel..'!', cid)
	else
		doPlayerRemoveMoney(cid,newPrice)
		playerid = getPlayerGUID(cid)
		addEvent(function()
			if isPlayer(cid) then
				addReset(cid)
			end
		end, 3000)
		local number = getResets(cid)+1
		local msg ="---[Reset: "..number.."]-- You have reseted!  You'll be disconnected in 3 seconds."
		doPlayerPopupFYI(cid, msg) 
		talkState[talkUser] = 0
		npcHandler:releaseFocus(cid)
	end
talkState[talkUser] = 0
elseif(msgcontains(msg, 'no')) and isInArray({1}, talkState[talkUser]) == TRUE then
	talkState[talkUser] = 0
	npcHandler:releaseFocus(cid)
	selfSay('Ok.', cid)
elseif msgcontains(msg, 'quantity') then
	selfSay('You have a total of '..getResets(cid)..' reset(s).', cid)
	talkState[talkUser] = 0
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())