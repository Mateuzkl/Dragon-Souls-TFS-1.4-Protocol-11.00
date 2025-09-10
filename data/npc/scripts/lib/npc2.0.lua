TALKSTATE_NONE = 0
TALKSTATE_SELL_ITEM = 1
TALKSTATE_BUY_ITEM = 2

-- get the distance to a creature
function getDistanceToCreature(id)
    if id == 0 or id == nil then
        --
        return 0
    end
    local cx, cy, cz = creatureGetPosition(id)
    if cx == nil then
        return 100
    end
    local sx, sy, sz = selfGetPosition()
    return math.max(math.abs(sx-cx), math.abs(sy-cy))    
end

-- do one step to reach position
function moveToPosition(x,y,z)
    selfMoveTo(x, y, z)
end

-- do one step to reach creature
function moveToCreature(id)
    if id == 0 or id == nil then
        selfGotoIdle()
    end
    local tx,ty,tz=creatureGetPosition(id)
    if tx == nil then
        --
    else
       moveToPosition(tx, ty, tz)
   end
end



CustomerQueue = {
    customers = nil,
    handler = nil
}

function CustomerQueue:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end


function CustomerQueue:removeFirst()
    table.remove(self.customers, 1)
end

function CustomerQueue:pushBack(cid)
    table.insert(self.customers, cid)
end

function CustomerQueue:getFirst()
    return self.customers[1]
end

function CustomerQueue:isInQueue(id)
    local pos = 1
    while true do
        local value = self.customers[pos]
        if value == nil then
            return false
        else
            if value == id then
                return true
            end
        end
        pos = pos+1
    end
    return false
end

function CustomerQueue:isEmpty()
    return (self:getFirst() == nil)
end


function CustomerQueue:greet(cid)
    selfSay('Hello, ' .. creatureGetName(cid) .. '! What a pleasent surprise.')
    self.handler:resetNpc()
    self.handler.focus = cid
    self.handler.talkStart = os.clock()
end

function CustomerQueue:canGreet(cid)
    local cx, cy, cz = creatureGetPosition(cid)
    if cx == nil then
        return false
    end
    
    local sx, sy, sz = selfGetPosition()
    local dist = math.max(math.abs(sx-cx), math.abs(sy-cy))
    
    return (dist <= 4)
    
end



function CustomerQueue:greetNext()
    while true do
        local first = self:getFirst()
        if(first == nil) then
            return false
        end
        
        if(not self:canGreet(first)) then
            self:removeFirst()
        else
            self:greet(first)
            self:removeFirst()
            return true
        end
        return true
    end
    return false
end





function getCount(msg)
    local ret = 1
    local b, e = string.find(msg, "%d+")
    if b ~= nil and e ~= nil then
       ret = tonumber(string.sub(msg, b, e))
    end
    
    return ret
end



function msgContains(message, keyword)
    return string.find(message, '(%a*)' .. keyword .. '(%a*)')
end



function walk(lastmove)
    if(os.time() - lastmove >= 1) then
        selfMove(math.random (0,3))
        lastmove = os.time()
    end
    return lastmove
end

function turnToCreature(cid, lastPos)
    local pos = getPlayerPosition(cid)
    local sx, sy, sz = selfGetPosition()
    if(pos == nil or sx == nil) then
        return
    else
        
        local dx = sx - pos.x
        local dy = sy - pos.y
        
        local direction = 0;
        local tan = 0;
        if(dx ~= 0) then
            tan = dy/dx;
        else
            tan = 10;
        end
        
        if(math.abs(tan) < 1) then
            if(dx > 0) then
                direction = 3;
            else
                direction = 1;
            end        
        
        else
            if(dy > 0) then
                direction = 0;
            else
                direction = 2;
            end
        end
        
        selfTurn(direction)
        
    end
end




KeywordLevel = {
    keywords = {},
    --children = {},
    func = nil,
    parameters = {}
}

function KeywordLevel:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function KeywordLevel:processMessage(cid, message)
    local i = 1
    while true do
        local key = self.keywords[i]
        if(key == nil) then
            break
        end
        
        if(not self:checkKeyword(message, key)) then
            return false
        end
        
        i = i+1
    end
    
    if(self.func == nil) then
        return true
    end
    
    
    return self.func(cid, message, self.keywords, self.parameters)
end


function KeywordLevel:checkKeyword(message, key)
    return msgContains(message, key)
end


KeywordHandler = {
    root = {}
}

function KeywordHandler:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function KeywordHandler:processMessage(cid, message)
    
    local ret = false
    local i = 1
    while true do
        local key = self.root[i]
        if(key == nil) then
            return false
        end
        ret = key:processMessage(cid, message)
        if(ret) then
            return ret
        end
        i = i+1
    end
    
    return false
end

function KeywordHandler:addKeyword(keys, f, params)
    local new = KeywordLevel:new(nil)
    new.keywords = keys
    new.func = f
    new.parameters = params
    table.insert(self.root, new)
end


-- NpcHandler class start
NpcHandler = {
    started = false,
    focus = 0,
    talkState = 0,
    talkStart = 0,
    lastPos = nil,
    lastMove = 0,
    queue = nil,
    keywordHandler = nil
}

function NpcHandler:new(o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end


function NpcHandler:resetNpc()
    self.focus = 0
    self.talkState = 0
    self.talkStart = 0
end

function NpcHandler:onThingMove(creature, thing, oldpos, oldstackpos)
end
function NpcHandler:onCreatureAppear(creature)
end
function NpcHandler:onCreatureDisappear(cid)
end
function NpcHandler:onCreatureSay(cid, type, msg)
end
function NpcHandler:onThink()
end


function NpcHandler:init(costumerQueue, newKeywordHandler)
    if(self.started) then
        return
    end
    
    self.queue = costumerQueue
    self.keywordHandler = newKeywordHandler
    self:resetNpc()
    
    self.started = true
end
-- NpcHandler class end




-- ShopHandler class start
ShopNpcHandler = {
    itemid = 0,
    count = 0,
    charges = 0,
    cost = 0,
    stackable = false
    
}
ShopNpcHandler = NpcHandler:new(ShopNpcHandler)


function ShopNpcHandler:setActiveItem(itemid, count, charges, cost, stackable)
    self.itemid = itemid
    self.count = count
    self.charges = charges
    self.cost = cost
    self.stackable = stackable
end

function ShopNpcHandler:resetNpc()
    self.focus = 0
    self.talkState = 0
    self.talkStart = 0
    
    self.itemid = 0
    self.count = 0
    self.charges = 0
    self.cost = 0
    self.stackable = false
end



function ShopNpcHandler:onCreatureDisappear(cid)
    if(cid == self.focus) then
        self:resetNpc()
        self.queue:greetNext()
    end
end

function ShopNpcHandler:onCreatureSay(cid, type, msg)
    
    --Only allow players...
    if(isPlayer(cid) == 0) then
        return
    end
    
    local dist = getDistanceToCreature(cid)
    if dist > 4 then
        return
    end
    
    msg = string.lower(msg)
    
    if cid == self.focus then
        self.talkStart = os.clock()
    end   
    local ret = self.keywordHandler:processMessage(cid, msg)
    if(ret == true) then
        return
    end
    
    if(cid == self.focus and self.talkState ~= TALKSTATE_NONE) then
        selfSay('I guess not then.')
        self.talkState = TALKSTATE_NONE
        return
    end
    
end


function ShopNpcHandler:onThink()
    
    if (os.clock() - self.talkStart) > 25 then
        if self.focus > 0 then
            selfSay('Next please!')
        end
        
        self:resetNpc()
        
        self.queue:greetNext()
    end
    
    local dist = getDistanceToCreature(self.focus)
    if dist > 4 then
        selfSay('Next please!')
        self:resetNpc()
        self.queue:greetNext()
    end
    
    
    
    if self.focus == 0 then
        self.lastMove = walk(self.lastMove)
    else
        self.lastPos = turnToCreature(self.focus, self.lastPos)
    end
    
end

-- ShopHandler class end


-- Default shop keyword handling functions...
function ShopNpcHandler:defaultTradeHandler(cid, message, keywords, parameters)
    if self.focus ~= cid then
        return false
    end
    
    local tempcount = getCount(message)
    if(tempcount > 500) then
        tempcount = 500
    end
    
    
    local itemname = keywords[1]
    if(keywords[1] == 'sell') then
        itemname = keywords[2]
    end
    
    if(parameters.realname ~= nil) then
        itemname = parameters.realname
    end
    
    local tradeKeyword = 'buy'
    if(keywords[1] == 'sell') then
        tradeKeyword = 'sell'
    end
    selfSay('Do you want to ' .. tradeKeyword .. ' ' .. tempcount .. ' ' .. itemname .. ' for ' .. parameters.cost*tempcount .. ' gold coins?')
    
    if(keywords[1] == 'sell') then
        self.talkState = TALKSTATE_SELL_ITEM
    else
        self.talkState = TALKSTATE_BUY_ITEM
    end
    
    self:setActiveItem(parameters.itemid, tempcount, parameters.charges, tempcount*parameters.cost, stackable, (parameters.stackable ~= nil and parameters.stackable == true))
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
            local ret = doPlayerBuyItem(self.focus, self.itemid, self.stackable, self.count, self.cost)
            if(ret == LUA_NO_ERROR) then
                selfSay('Here you go.')
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

function NpcHandler:defaultMessageHandler(cid, message, keywords, parameters)
    if(not parameters.onlyfocus or (parameters.onlyfocus and cid == self.focus)) then
        selfSay(parameters.text)
        self.talkState = TALKSTATE_NONE
        return true
    end
    return false
end

function NpcHandler:defaultGreetHandler(cid, message, keywords, parameters)
    if self.focus == cid then
        selfSay('I am already talking to you.')
        self.talkStart = os.clock()
    elseif self.focus > 0 or not(self.queue:isEmpty()) then
        selfSay('Please, ' .. creatureGetName(cid) .. '. Wait for your turn!.')
        if(not self.queue:isInQueue(cid)) then
            self.queue:pushBack(cid)
        end
    elseif(self.focus == 0) and (self.queue:isEmpty()) then
        selfSay('Hello, ' .. creatureGetName(cid) .. '. Welcome to my shop!')
        self.focus = cid
        self.talkStart = os.clock()
    end
    
    return true
end

function NpcHandler:defaultFarwellHandler(cid, message, keywords, parameters)
    if(cid == self.focus) then
        selfSay('Farewell, ' .. creatureGetName(cid) .. '!')
        self:resetNpc()
        self.queue:greetNext()
        return true
    end
    return false
end

function exhaust(cid, storevalue, exhausttime)
-- Exhaustion function by Alreth, v1.1 2006-06-24 01:31
-- Returns 1 if not exhausted and 0 if exhausted
    
    newExhaust = os.time()
    oldExhaust = getPlayerStorageValue(cid, storevalue)
    if (oldExhaust == nil or oldExhaust < 0) then
        oldExhaust = 0
    end
    if (exhausttime == nil or exhausttime < 0) then
        exhausttime = 1
    end
    diffTime = os.difftime(newExhaust, oldExhaust)
    if (diffTime >= exhausttime or diffTime < 0) then
        setPlayerStorageValue(cid, storevalue, newExhaust) 
        return 1
    else
        return 0
    end
end
-- End