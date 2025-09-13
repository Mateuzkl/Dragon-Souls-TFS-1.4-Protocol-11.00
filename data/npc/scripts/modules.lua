-- Converted Jiddo's NpcSystem v3.0x for TFS 1.x
-- Original by Jiddo, converted for modern TFS 1.x

if(Modules == nil) then
    
    FOCUS_GREETWORDS = {'hi', 'hello'}
    FOCUS_FAREWELLWORDS = {'bye', 'farewell', 'cya'}
    
    SHOP_YESWORD = {'yes'}
    SHOP_NOWORD = {'no'}
    
    PATTERN_COUNT = '%d+'
    
    SHOPMODULE_SELL_ITEM = 1
    SHOPMODULE_BUY_ITEM = 2
    
    Modules = {
        parseableModules = {}
    }
    
    StdModule = {}
    
    function StdModule.say(cid, message, keywords, parameters, node)
        local npcHandler = parameters.npcHandler
        if(npcHandler == nil) then
            error('StdModule.say called without any npcHandler instance.')
        end
        if(cid ~= npcHandler.focus and (parameters.onlyFocus == nil or parameters.onlyFocus == true)) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local parseInfo = {
            [TAG_PLAYERNAME] = player:getName(),
        }
        msgout = npcHandler:parseMessage(parameters.text or parameters.message, parseInfo)
        npcHandler:say(msgout)
        if(parameters.reset == true) then
            npcHandler:resetNpc()
        elseif(parameters.moveup ~= nil and type(parameters.moveup) == 'number') then
            npcHandler.keywordHandler:moveUp(parameters.moveup)
        end
        return true
    end
    
    function StdModule.promotePlayer(cid, message, keywords, parameters, node)
        local npcHandler = parameters.npcHandler
        if(npcHandler == nil) then
            error('StdModule.promotePlayer called without any npcHandler instance.')
        end
        if(cid ~= npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local vocation = player:getVocation()
        local promotedVocation = vocation:getPromotion()
        
        if not promotedVocation then
            npcHandler:say('You are already promoted!')
        elseif player:getLevel() < parameters.level then
            npcHandler:say('I am sorry, but I can only promote you once you have reached level ' .. parameters.level .. '.')
        elseif not player:removeTotalMoney(parameters.cost) then
            npcHandler:say('You do not have enough money!')
        else
            player:setVocation(promotedVocation)
            npcHandler:say(parameters.text)
        end
        
        npcHandler:resetNpc()
        return true
    end

    function StdModule.TempleChange(cid, message, keywords, parameters, node)
        local npcHandler = parameters.npcHandler
        if(npcHandler == nil) then
            error('StdModule.TempleChange called without any npcHandler instance.')
        end
        if(cid ~= npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        if(player:isPremium() or parameters.premium == false) then
            if(parameters.level ~= nil and player:getLevel() < parameters.level) then
                npcHandler:say('You must reach level ' .. parameters.level .. ' before I can change it.')
            elseif not player:removeTotalMoney(parameters.cost) then
                npcHandler:say('You do not have enough money!')
            else
                player:setTown(Town(parameters.townid))
                player:teleportTo(parameters.pos)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        else
            npcHandler:say('I can only allow premium players to change temple to here.')
        end
        
        npcHandler:resetNpc()
        return true
    end
    
    function StdModule.travel(cid, message, keywords, parameters, node)
        local npcHandler = parameters.npcHandler
        if(npcHandler == nil) then
            error('StdModule.travel called without any npcHandler instance.')
        end
        if(cid ~= npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        if(player:isPremium() or parameters.premium == false) then
            if(parameters.level ~= nil and player:getLevel() < parameters.level) then
                npcHandler:say('You must reach level ' .. parameters.level .. ' before I can let you go there.')
            elseif not player:removeTotalMoney(parameters.cost) then
                npcHandler:say('You do not have enough money!')
            else
                player:teleportTo(parameters.destination)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        else
            npcHandler:say('I can only allow premium players to travel with me.')
        end
        
        npcHandler:resetNpc()
        return true
    end
    
    FocusModule = {
        npcHandler = nil
    }
    
    function FocusModule:new()
        local obj = {}
        setmetatable(obj, self)
        self.__index = self
        return obj
    end
    
    function FocusModule:init(handler)
        self.npcHandler = handler
        for i, word in pairs(FOCUS_GREETWORDS) do
            local obj = {}
            table.insert(obj, word)
            obj.callback = FOCUS_GREETWORDS.callback or FocusModule.messageMatcher
            handler.keywordHandler:addKeyword(obj, FocusModule.onGreet, {module = self})
        end
        
        for i, word in pairs(FOCUS_FAREWELLWORDS) do
            local obj = {}
            table.insert(obj, word)
            obj.callback = FOCUS_FAREWELLWORDS.callback or FocusModule.messageMatcher
            handler.keywordHandler:addKeyword(obj, FocusModule.onFarewell, {module = self})
        end
        
        return true
    end
    
    function FocusModule.onGreet(cid, message, keywords, parameters)
        parameters.module.npcHandler:onGreet(cid)
        return true
    end
    
    function FocusModule.onFarewell(cid, message, keywords, parameters)
        if(parameters.module.npcHandler.focus == cid) then
            parameters.module.npcHandler:onFarewell()
            return true
        else
            return false
        end
    end
    
    function FocusModule.messageMatcher(keywords, message)
        for i, word in pairs(keywords) do
            if(type(word) == 'string') then
                if string.find(message, word) and not string.find(message, '[%w+]' .. word) and not string.find(message, word .. '[%w+]') then
                    return true
                end
            end
        end
        return false
    end
    
    KeywordModule = {
        npcHandler = nil
    }
    Modules.parseableModules['module_keywords'] = KeywordModule
    
    function KeywordModule:new()
        local obj = {}
        setmetatable(obj, self)
        self.__index = self
        return obj
    end
    
    function KeywordModule:init(handler)
        self.npcHandler = handler
        return true
    end
    
    function KeywordModule:parseParameters()
        local ret = NpcSystem.getParameter('keywords')
        if(ret ~= nil) then
            self:parseKeywords(ret)
        end
    end
    
    function KeywordModule:parseKeywords(data)
        local n = 1
        for keys in string.gmatch(data, '[^;]+') do
            local i = 1
            local keywords = {}
            
            for temp in string.gmatch(keys, '[^,]+') do
                table.insert(keywords, temp)
                i = i+1
            end
            
            if(i ~= 1) then
                local reply = NpcSystem.getParameter('keyword_reply' .. n)
                if(reply ~= nil) then
                    self:addKeyword(keywords, reply)
                else
                    print('[Warning] NpcSystem:', 'Parameter \'' .. 'keyword_reply' .. n .. '\' missing. Skipping...')
                end
            else
                print('[Warning] NpcSystem:', 'No keywords found for keyword set #' .. n .. '. Skipping...')
            end
            n = n+1
        end
    end
    
    function KeywordModule:addKeyword(keywords, reply)
        self.npcHandler.keywordHandler:addKeyword(keywords, StdModule.say, {npcHandler = self.npcHandler, onlyFocus = true, text = reply, reset = true})
    end
    
    TravelModule = {
        npcHandler = nil,
        destinations = nil,
        yesNode = nil,
        noNode = nil,
    }
    Modules.parseableModules['module_travel'] = TravelModule
    
    function TravelModule:new()
        local obj = {}
        setmetatable(obj, self)
        self.__index = self
        return obj
    end
    
    function TravelModule:init(handler)
        self.npcHandler = handler
        self.yesNode = KeywordNode:new(SHOP_YESWORD, TravelModule.onConfirm, {module = self})
        self.noNode = KeywordNode:new(SHOP_NOWORD, TravelModule.onDecline, {module = self})
        self.destinations = {}
        return true
    end
    
    function TravelModule:parseParameters()
        local ret = NpcSystem.getParameter('travel_destinations')
        if(ret ~= nil) then
            self:parseDestinations(ret)
            
            self.npcHandler.keywordHandler:addKeyword({'destination'}, TravelModule.listDestinations, {module = self})
            self.npcHandler.keywordHandler:addKeyword({'where'}, TravelModule.listDestinations, {module = self})
            self.npcHandler.keywordHandler:addKeyword({'travel'}, TravelModule.listDestinations, {module = self})
        end
    end
    
    function TravelModule:parseDestinations(data)
        for destination in string.gmatch(data, '[^;]+') do
            local i = 1
            local name, x, y, z, cost = nil, nil, nil, nil, nil
            local premium = false
            
            for temp in string.gmatch(destination, '[^,]+') do
                if(i == 1) then name = temp
                elseif(i == 2) then x = tonumber(temp)
                elseif(i == 3) then y = tonumber(temp)
                elseif(i == 4) then z = tonumber(temp)
                elseif(i == 5) then cost = tonumber(temp)
                elseif(i == 6) then premium = temp == 'true'
                else print('[Warning] NpcSystem:', 'Unknown parameter found in travel destination parameter.', temp, destination)
                end
                i = i+1
            end
            
            if(name ~= nil and x ~= nil and y ~= nil and z ~= nil and cost ~= nil) then
                self:addDestination(name, {x=x, y=y, z=z}, cost, premium)
            else
                print('[Warning] NpcSystem:', 'Parameter(s) missing for travel destination:', name, x, y, z, cost, premium)
            end
        end
    end
    
    function TravelModule:addDestination(name, position, price, premium)
        table.insert(self.destinations, name)
        
        local parameters = {
            cost = price,
            destination = position,
            premium = premium,
            module = self
        }
        local keywords = {name}
        local keywords2 = {'bring me to ' .. name}
        
        local node = self.npcHandler.keywordHandler:addKeyword(keywords, TravelModule.travel, parameters)
        self.npcHandler.keywordHandler:addKeyword(keywords2, TravelModule.bringMeTo, parameters)
        node:addChildKeywordNode(self.yesNode)
        node:addChildKeywordNode(self.noNode)
    end
    
    function TravelModule.travel(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local cost = parameters.cost
        module.npcHandler:say('Do you want to travel to ' .. keywords[1] .. ' for ' .. cost .. ' gold coins?')
        return true
    end
    
    function TravelModule.onConfirm(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local npcHandler = module.npcHandler
        local parentParameters = node:getParent():getParameters()
        local cost = parentParameters.cost
        local destination = parentParameters.destination
        local premium = parentParameters.premium
        
        if(player:isPremium() or premium ~= true) then
            if not player:removeTotalMoney(cost) then
                npcHandler:say('You do not have enough money!')
            else
                npcHandler:say('It was a pleasure doing business with you.', false)
                npcHandler:releaseFocus()
                player:teleportTo(destination)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        else
            npcHandler:say('I can only allow premium players to travel there.')
        end
        
        npcHandler:resetNpc()
        return true
    end
    
    function TravelModule.onDecline(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local parentParameters = node:getParent():getParameters()
        local parseInfo = {
            [TAG_PLAYERNAME] = player:getName(),
        }
        local msg = module.npcHandler:parseMessage(module.npcHandler:getMessage(MESSAGE_DECLINE), parseInfo)
        module.npcHandler:say(msg)
        module.npcHandler:resetNpc()
        return true
    end
    
    function TravelModule.bringMeTo(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid == module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local cost = parameters.cost
        local destination = parameters.destination
        local premium = parameters.premium
        
        if(player:isPremium() or premium ~= true) then
            if player:removeTotalMoney(cost) then
                player:teleportTo(destination)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
            end
        end
        
        return true
    end
    
    function TravelModule.listDestinations(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local msg = 'I can bring you to '
        local maxn = #module.destinations
        for i, destination in pairs(module.destinations) do
            msg = msg .. destination
            if(i == maxn-1) then
                msg = msg .. ' and '
            elseif(i == maxn) then
                msg = msg .. '.'
            else
                msg = msg .. ', '
            end
        end
        
        module.npcHandler:say(msg)
        module.npcHandler:resetNpc()
        return true
    end
    
    ShopModule = {
        yesNode = nil,
        noNode = nil,
        npcHandler = nil,
        noText = '',
        maxCount = 500,
        amount = 0
    }
    Modules.parseableModules['module_shop'] = ShopModule
    
    function ShopModule:new()
        local obj = {}
        setmetatable(obj, self)
        self.__index = self
        return obj
    end
    
    function ShopModule:parseParameters()
        local ret = NpcSystem.getParameter('shop_sellable')
        if(ret ~= nil) then
            self:parseSellable(ret)
        end
        
        ret = NpcSystem.getParameter('shop_buyable')
        if(ret ~= nil) then
            self:parseBuyable(ret)
        end
    end
    
    function ShopModule:parseBuyable(data)
        for item in string.gmatch(data, '[^;]+') do
            local i = 1
            local name, itemid, cost, charges = nil, nil, nil, nil
            
            for temp in string.gmatch(item, '[^,]+') do
                if(i == 1) then name = temp
                elseif(i == 2) then itemid = tonumber(temp)
                elseif(i == 3) then cost = tonumber(temp)
                elseif(i == 4) then charges = tonumber(temp)
                else print('[Warning] NpcSystem:', 'Unknown parameter found in buyable items parameter.', temp, item)
                end
                i = i+1
            end
            
            if(name ~= nil and itemid ~= nil and cost ~= nil) then
                local itemType = ItemType(itemid)
                if((itemType:isRune() or itemType:isFluidContainer()) and charges == nil) then
                    print('[Warning] NpcSystem:', 'Charges missing for parameter item:' , item)
                else
                    local names = {name}
                    self:addBuyableItem(names, itemid, cost, charges)
                end
            else
                print('[Warning] NpcSystem:', 'Parameter(s) missing for item:', name, itemid, cost)
            end
        end
    end
    
    function ShopModule:parseSellable(data)
        for item in string.gmatch(data, '[^;]+') do
            local i = 1
            local name, itemid, cost = nil, nil, nil
            
            for temp in string.gmatch(item, '[^,]+') do
                if(i == 1) then name = temp
                elseif(i == 2) then itemid = tonumber(temp)
                elseif(i == 3) then cost = tonumber(temp)
                else print('[Warning] NpcSystem:', 'Unknown parameter found in sellable items parameter.', temp, item)
                end
                i = i+1
            end
            
            if(name ~= nil and itemid ~= nil and cost ~= nil) then
                local names = {name}
                self:addSellableItem(names, itemid, cost)
            else
                print('[Warning] NpcSystem:', 'Parameter(s) missing for item:', name, itemid, cost)
            end
        end
    end
    
    function ShopModule:init(handler)
        self.npcHandler = handler
        self.yesNode = KeywordNode:new(SHOP_YESWORD, ShopModule.onConfirm, {module = self})
        self.noNode = KeywordNode:new(SHOP_NOWORD, ShopModule.onDecline, {module = self})
        self.noText = handler:getMessage(MESSAGE_DECLINE)
        return true
    end
    
    function ShopModule:reset()
        self.amount = 0
    end
    
    function ShopModule:getCount(message)
        local ret = 1
        local b, e = string.find(message, PATTERN_COUNT)
        if b ~= nil and e ~= nil then
            ret = tonumber(string.sub(message, b, e))
        end
        if(ret <= 0) then
            ret = 1
        elseif(ret > self.maxCount) then
            ret = self.maxCount
        end
        return ret
    end
    
    function ShopModule:addBuyableItem(names, itemid, cost, charges, realname)
        for i, name in pairs(names) do
            local parameters = {
                itemid = itemid,
                cost = cost,
                eventType = SHOPMODULE_BUY_ITEM,
                module = self
            }
            if(realname ~= nil) then
                parameters.realname = realname
            end
            local itemType = ItemType(itemid)
            if(itemType:isRune() or itemType:isFluidContainer()) then
                parameters.charges = charges
            end
            local keywords = {name}
            local node = self.npcHandler.keywordHandler:addKeyword(keywords, ShopModule.tradeItem, parameters)
            node:addChildKeywordNode(self.yesNode)
            node:addChildKeywordNode(self.noNode)
        end
    end
    
    function ShopModule:addSellableItem(names, itemid, cost, realname)
        for i, name in pairs(names) do
            local parameters = {
                itemid = itemid,
                cost = cost,
                eventType = SHOPMODULE_SELL_ITEM,
                module = self
            }
            if(realname ~= nil) then
                parameters.realname = realname
            end
            local keywords = {'sell', name}
            local node = self.npcHandler.keywordHandler:addKeyword(keywords, ShopModule.tradeItem, parameters)
            node:addChildKeywordNode(self.yesNode)
            node:addChildKeywordNode(self.noNode)
        end
    end
    
    function ShopModule:callbackOnModuleReset()
        self:reset()
        return true
    end
    
    function ShopModule.tradeItem(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local count = module:getCount(message)
        module.amount = count
        local tmpName = nil
        if(parameters.eventType == SHOPMODULE_SELL_ITEM) then
            tmpName = node:getKeywords()[2]
        elseif(parameters.eventType == SHOPMODULE_BUY_ITEM) then
            tmpName = node:getKeywords()[1]
        end
        local parseInfo = {
            [TAG_PLAYERNAME] = player:getName(),
            [TAG_ITEMCOUNT] = module.amount,
            [TAG_TOTALCOST] = parameters.cost*module.amount,
            [TAG_ITEMNAME] = parameters.realname or tmpName
        }
        
        if(parameters.eventType == SHOPMODULE_SELL_ITEM) then
            local msg = module.npcHandler:getMessage(MESSAGE_SELL)
            msg = module.npcHandler:parseMessage(msg, parseInfo)
            module.npcHandler:say(msg)
        elseif(parameters.eventType == SHOPMODULE_BUY_ITEM) then
            local msg = module.npcHandler:getMessage(MESSAGE_BUY)
            msg = module.npcHandler:parseMessage(msg, parseInfo)
            module.npcHandler:say(msg)
        end
        
        return true
    end
    
    function ShopModule.onConfirm(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local parentParameters = node:getParent():getParameters()
        local parseInfo = {
            [TAG_PLAYERNAME] = player:getName(),
            [TAG_ITEMCOUNT] = module.amount,
            [TAG_TOTALCOST] = parentParameters.cost*module.amount,
            [TAG_ITEMNAME] = parentParameters.realname or node:getParent():getKeywords()[1]
        }
        
        if(parentParameters.eventType == SHOPMODULE_SELL_ITEM) then
            if player:removeItem(parentParameters.itemid, module.amount, -1, true) then
                player:addMoney(parentParameters.cost * module.amount)
                local msg = module.npcHandler:getMessage(MESSAGE_ONSELL)
                msg = module.npcHandler:parseMessage(msg, parseInfo)
                module.npcHandler:say(msg)
            else
                local msg = module.npcHandler:getMessage(MESSAGE_NOTHAVEITEM)
                msg = module.npcHandler:parseMessage(msg, parseInfo)
                module.npcHandler:say(msg)
            end
        elseif(parentParameters.eventType == SHOPMODULE_BUY_ITEM) then
            if not player:removeTotalMoney(parentParameters.cost * module.amount) then
                local msg = module.npcHandler:getMessage(MESSAGE_NEEDMOREMONEY)
                msg = module.npcHandler:parseMessage(msg, parseInfo)
                module.npcHandler:say(msg)
            else
                for i = 1, module.amount do
                    player:addItem(parentParameters.itemid, 1)
                end
                local msg = module.npcHandler:getMessage(MESSAGE_ONBUY)
                msg = module.npcHandler:parseMessage(msg, parseInfo)
                module.npcHandler:say(msg)
            end
        end
        
        module.npcHandler:resetNpc()
        return true
    end
    
    function ShopModule.onDecline(cid, message, keywords, parameters, node)
        local module = parameters.module
        if(cid ~= module.npcHandler.focus) then
            return false
        end
        
        local player = Player(cid)
        if not player then
            return false
        end
        
        local parentParameters = node:getParent():getParameters()
        local parseInfo = {
            [TAG_PLAYERNAME] = player:getName(),
            [TAG_ITEMCOUNT] = module.amount,
            [TAG_TOTALCOST] = parentParameters.cost*module.amount,
            [TAG_ITEMNAME] = parentParameters.realname or node:getParent():getKeywords()[1]
        }
        local msg = module.npcHandler:parseMessage(module.noText, parseInfo)
        module.npcHandler:say(msg)
        module.npcHandler:resetNpc()
        return true
    end
end
