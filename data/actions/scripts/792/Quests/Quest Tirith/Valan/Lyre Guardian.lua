function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() ~= 2071 then
        return true
    end
    
    if fromPosition.x ~= 463 or fromPosition.y ~= 234 or fromPosition.z ~= 14 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "O item só pode ser usado no altar sagrado.")
        return true
    end
    
    local altarTile = Tile(fromPosition)
    if not altarTile then
        return true
    end
    
    local altar = altarTile:getItemById(1642)
    if not altar or altar:getActionId() ~= 4508 then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este não é o altar correto.")
        return true
    end
    
    local piecePositions = {
        {pos = {x=453, y=236, z=14}, itemId = 1455},
        {pos = {x=453, y=238, z=14}, itemId = 1455},
        {pos = {x=453, y=240, z=14}, itemId = 1455},
        {pos = {x=453, y=242, z=14}, itemId = 1455},
        {pos = {x=453, y=244, z=14}, itemId = 1455},
        {pos = {x=473, y=236, z=14}, itemId = 1454},
        {pos = {x=473, y=238, z=14}, itemId = 1454},
        {pos = {x=473, y=240, z=14}, itemId = 1454},
        {pos = {x=473, y=242, z=14}, itemId = 1454},
        {pos = {x=473, y=244, z=14}, itemId = 1454},
        {pos = {x=461, y=247, z=14}, itemId = 1455},
        {pos = {x=461, y=250, z=14}, itemId = 1455},
        {pos = {x=466, y=247, z=14}, itemId = 1454},
        {pos = {x=466, y=250, z=14}, itemId = 1454}
    }
    
    local pieces = {}
    local allPiecesValid = true
    
    for i, data in ipairs(piecePositions) do
        local tile = Tile(Position(data.pos.x, data.pos.y, data.pos.z))
        if tile then
            local pieceItem = tile:getItemById(data.itemId)
            if pieceItem then
                pieces[i] = pieceItem
            else
                allPiecesValid = false
                break
            end
        else
            allPiecesValid = false
            break
        end
    end
    
    if allPiecesValid then
        for i, piece in ipairs(pieces) do
            if piece then
                piece:remove()
            end
        end
        
        local newItems = {
            1459, 1459, 1459, 1459, 1459,
            1458, 1458, 1458, 1458, 1458,
            1459, 1459, 1458, 1458
        }
        
        for i, data in ipairs(piecePositions) do
            local pos = Position(data.pos.x, data.pos.y, data.pos.z)
            Game.createItem(newItems[i], 1, pos)
            Game.createMonster("Guardian Gargoyle", pos)
        end
        
        Game.createItem(5070, 1, Position(463, 234, 14))
        Game.createItem(3687, 1, Position(463, 247, 14))
        
        addEvent(function()
            local altarTile = Tile(Position(463, 234, 14))
            if altarTile then
                local item2071 = altarTile:getItemById(2071)
                if item2071 then
                    item2071:remove()
                end
                
                local item5070 = altarTile:getItemById(5070)
                if item5070 then
                    item5070:remove()
                end
            end
            
            local itemPos2 = Tile(Position(463, 247, 14))
            if itemPos2 then
                local item3687 = itemPos2:getItemById(3687)
                if item3687 then
                    item3687:remove()
                end
            end
        end, 30 * 60 * 1000)
        
        for _, data in ipairs(piecePositions) do
            local pos = Position(data.pos.x, data.pos.y, data.pos.z)
            pos:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        end
        
        toPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
        Game.sendAnimatedText("Check!", toPosition, TEXTCOLOR_ORANGE)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Os seres adormecidos foram despertados atraves do som dos deuses.")
    else
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Desculpe, não é possivel.")
    end
    
    return true
end
