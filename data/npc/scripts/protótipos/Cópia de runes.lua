local internalCustomerQueue = {}
local keywordHandler = KeywordHandler:new({root = {}})
local npcHandler = ShopNpcHandler:new({})
local customerQueue = CustomerQueue:new({customers = internalCustomerQueue, handler = npcHandler})
npcHandler:init(customerQueue, keywordHandler)


-- OTServ event handling functions start
function onThingMove(creature, thing, oldpos, oldstackpos)     npcHandler:onThingMove(creature, thing, oldpos, oldstackpos) end
function onCreatureAppear(creature)                             npcHandler:onCreatureAppear(creature) end
function onCreatureDisappear(id)                                 npcHandler:onCreatureDisappear(id) end
function onCreatureTurn(creature)                                 npcHandler:onCreatureTurn(creature) end
function onCreatureSay(cid, type, msg)                         npcHandler:onCreatureSay(cid, type, msg) end
function onCreatureChangeOutfit(creature)                         npcHandler:onCreatureChangeOutfit(creature) end
function onThink()                                             npcHandler:onThink() end
-- OTServ event handling functions end

-- Keyword handling functions start
function tradeItem(cid, message, keywords, parameters)     return npcHandler:defaultTradeHandler(cid, message, keywords, parameters) end
function sayMessage(cid, message, keywords, parameters)     return npcHandler:defaultMessageHandler(cid, message, keywords, parameters) end


-- greet diferente
function greet(cid, message, keywords, parameters)
    if npcHandler.focus == cid then
        selfSay('I am already talking to you.')
        npcHandler.talkStart = os.clock()
    elseif npcHandler.focus > 0 or not(npcHandler.queue:isEmpty()) then
        selfSay('Please, ' .. creatureGetName(cid) .. '. I will talk to you in one minute!.')
        if(not npcHandler.queue:isInQueue(cid)) then
            npcHandler.queue:pushBack(cid)
        end
    elseif(npcHandler.focus == 0) and (npcHandler.queue:isEmpty()) then
        selfSay(' Hello ' .. creatureGetName(cid) .. '! Welcome to my rune shop!')
        npcHandler.focus = cid
        voc = 0
        npcHandler.talkStart = os.clock()
    end
    
    return true
end









function ShopNpcHandler:defaultConfirmHandler(cid, message, keywords, parameters)
    if self.focus ~= cid then
        return false
    end
    if(keywords[1] == 'yes') then
        if(self.talkState == TALKSTATE_SELL_ITEM) then
            self.talkState = TALKSTATE_NONE
            local ret = doPlayerSellItem(self.focus, self.itemid, self.stackable, self.count, self.cost)
            if(ret == LUA_NO_ERROR) then
                selfSay('Thank you.')
            else
                selfSay('You do not have that item.')
            end
        elseif(self.talkState == TALKSTATE_BUY_ITEM) then
            self.talkState = TALKSTATE_NONE
            local ret = 0
            if(self.charges == nil or self.charges <= 1) then
                ret = doPlayerBuyItem(self.focus, self.itemid, self.stackable, self.count, self.cost)
            else
                ret = doPlayerBuyRune(self.focus, self.itemid, self.count, self.charges, self.cost)
            end
            if(ret == LUA_NO_ERROR) then
       if(npcHandler.actionid >= 100) then
			action = doPlayerSellItem(self.focus, self.itemid, self.stackable, self.count, self.cost)
			doSetItemActionId(action, 1000)
			if(ret == LUA_NO_ERROR) then
				selfSay('Here you go.')
			end
		else
			selfSay('Here you go.')
		end
            else
                selfSay('You do not have enough money.')
            end
        end
    elseif(keywords[1] == 'no') then
        if(self.talkState == TALKSTATE_SELL_ITEM) then
            selfSay('I wouldnt sell that either.')
              self.talkState = TALKSTATE_NONE
          elseif(self.talkState == TALKSTATE_BUY_ITEM) then
              selfSay('Too expensive you think?')
              self.talkState = TALKSTATE_NONE
          end
    end
    
    return true
end












function confirmAction(cid, message, keywords, parameters)
    if npcHandler.focus ~= cid then
        return false
    end
    if(keywords[1] == 'yes') then
        if(npcHandler.talkState == TALKSTATE_SELL_ITEM) then
            npcHandler.talkState = TALKSTATE_NONE
            local ret = doPlayerSellItem(npcHandler.focus, npcHandler.itemid, npcHandler.stackable, npcHandler.count, npcHandler.cost)
            if(ret == LUA_NO_ERROR) then
		selfSay('Thank you.')
            else
                selfSay('You do not have that item.')
            end
        elseif(npcHandler.talkState == TALKSTATE_BUY_ITEM) then
            npcHandler.talkState = TALKSTATE_NONE
            local ret = 0
            if(npcHandler.charges == nil or npcHandler.charges <= 1) then
                ret = doPlayerBuyItem(npcHandler.focus, npcHandler.itemid, npcHandler.stackable, npcHandler.count, npcHandler.cost)
            else
                ret = doPlayerBuyRune(npcHandler.focus, npcHandler.itemid, npcHandler.count, npcHandler.charges, npcHandler.cost)
            end
            if(ret == LUA_NO_ERROR) then
                if(npcHandler.itemid == 1988) then
			ret = doPlayerBuyItem(npcHandler.focus, 2311, false, 5, 0)

			if(ret == LUA_NO_ERROR) then
				selfSay('Here you go.')
			end
		else
			selfSay('Here you go.')
		end
            else
                selfSay('You do not have enough money.')
            end
        end
    elseif(keywords[1] == 'no') then
        if(npcHandler.talkState == TALKSTATE_SELL_ITEM) then
            selfSay('I wouldnt sell that either.')
              npcHandler.talkState = TALKSTATE_NONE
          elseif(npcHandler.talkState == TALKSTATE_BUY_ITEM) then
              selfSay('Too expensive you think?')
              npcHandler.talkState = TALKSTATE_NONE
          end
    end
    
    return true
end











function farewell(cid, message, keywords, parameters)         return npcHandler:defaultFarewellHandler(cid, message, keywords, parameters) end
-- Keyword handling functions end

-- Buy item keywords
keywordHandler:addKeyword({'bp of hmm'},     tradeItem, {itemid = 1988, cost = 25, realname = "backpack of heavy magic missiles", actionid = 1000})
keywordHandler:addKeyword({'ultimate healing'},     tradeItem, {itemid = 2273, cost = 175, charges = 1, realname = "ultimate healing rune"})
keywordHandler:addKeyword({'sudden death'},     tradeItem, {itemid = 2268, cost = 325, charges = 1, realname = "sudden death rune"})
keywordHandler:addKeyword({'great fireball'},     tradeItem, {itemid = 2304, cost = 90, charges = 3, realname = "great fireball rune"})
keywordHandler:addKeyword({'explosion'},     tradeItem, {itemid = 2313, cost = 85, charges = 3, realname = "explosion rune"})
keywordHandler:addKeyword({'light wand'},     tradeItem, {itemid = 2163, cost = 500, realname = "magic light wand"})
keywordHandler:addKeyword({'lightwand'},     tradeItem, {itemid = 2163, cost = 500, realname = "magic light wand"})
keywordHandler:addKeyword({'mana fluid'},     tradeItem, {itemid = 2006, cost = 100, charges = 7})
keywordHandler:addKeyword({'manafluid'},     tradeItem, {itemid = 2006, cost = 100, charges = 7})
keywordHandler:addKeyword({'life fluid'},     tradeItem, {itemid = 2006, cost = 80, charges = 10})
keywordHandler:addKeyword({'lifefluid'},     tradeItem, {itemid = 2006, cost = 80, charges = 10})
keywordHandler:addKeyword({'life fluid'},     tradeItem, {itemid = 2006, cost = 80, charges = 10})
keywordHandler:addKeyword({'lifefluid'},     tradeItem, {itemid = 2006, cost = 80, charges = 10})
keywordHandler:addKeyword({'blank'},     tradeItem, {itemid = 2260, cost = 10, realname = "blank rune"})

keywordHandler:addKeyword({'xpl'},     tradeItem, {itemid = 2313, cost = 85, charges = 3, realname = "explosion rune"})
keywordHandler:addKeyword({'explo'},     tradeItem, {itemid = 2313, cost = 85, charges = 3, realname = "explosion rune"})
keywordHandler:addKeyword({'gfb'},     tradeItem, {itemid = 2304, cost = 90, charges = 3, realname = "great fireball rune"})
keywordHandler:addKeyword({'sd'},     tradeItem, {itemid = 2268, cost = 325, charges = 1, realname = "sudden death rune"})
keywordHandler:addKeyword({'uh'},     tradeItem, {itemid = 2273, cost = 175, charges = 1, realname = "ultimate healing rune"})
keywordHandler:addKeyword({'hmm'},     tradeItem, {itemid = 2311, cost = 25, charges = 5, realname = "heavy magic missile rune"})
keywordHandler:addKeyword({'rune'},     tradeItem, {itemid = 2260, cost = 20, realname = "blank rune"})



-- Confirm sell/buy keywords
keywordHandler:addKeyword({'yes'}, confirmAction)
keywordHandler:addKeyword({'no'}, confirmAction)

-- General message keywords
keywordHandler:addKeyword({'offer'},     sayMessage, {text = 'I offer several kinds of magical runes and other magical items.'})
keywordHandler:addKeyword({'sell'},     sayMessage, {text = 'I am not buing anything.'})
keywordHandler:addKeyword({'job'},     sayMessage, {text = 'I am the shopkeeper of this magic shop.'})
keywordHandler:addKeyword({'quest'},     sayMessage, {text = 'A quest is nothing I want to be involved in.'})
keywordHandler:addKeyword({'mission'},    sayMessage, {text = 'I cannot help you in that area, son.'})
keywordHandler:addKeyword({'buy'},        sayMessage, {text = 'I cannot sell that.'})


keywordHandler:addKeyword({'hi'}, greet, nil)
keywordHandler:addKeyword({'hello'}, greet, nil)
keywordHandler:addKeyword({'hey'}, greet, nil)
keywordHandler:addKeyword({'bye'}, farewell, nil)
keywordHandler:addKeyword({'farewell'}, farewell, nil)