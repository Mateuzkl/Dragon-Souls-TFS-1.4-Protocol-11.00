function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getUniqueId() ~= 6036 or item:getId() ~= 4331 then
        if item:getUniqueId() == 6036 and item:getId() == 4332 then
            item:transform(4331)
            return true
        else
            player:sendTextMessage(MESSAGE_STATUS_WARNING, "Sorry you need the sequence of mystic books.")
            return false
        end
    end
    
    local piecePositions = {
        {pos = Position(471, 253, 13), itemId = 1982},
        {pos = Position(471, 255, 13), itemId = 1983}, 
        {pos = Position(471, 257, 13), itemId = 1984},
        {pos = Position(471, 259, 13), itemId = 1985},
        {pos = Position(471, 261, 13), itemId = 1986},
        {pos = Position(476, 257, 13), itemId = 1354}
    }
    
    local createPositions = {
        Position(471, 253, 13),
        Position(471, 255, 13),
        Position(471, 257, 13), 
        Position(471, 259, 13),
        Position(471, 261, 13),
        Position(474, 257, 13)
    }
    
    local allPiecesValid = true
    local pieces = {}
    
    for i, data in ipairs(piecePositions) do
        local tile = Tile(data.pos)
        if tile then
            local piece = tile:getItemById(data.itemId)
            if piece then
                pieces[i] = piece
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
        for i, pos in ipairs(createPositions) do
            Game.createItem(5070, 1, pos)
        end
        
        if pieces[6] then
            pieces[6]:remove()
        end
        
        Game.sendAnimatedText("Cleck!", player:getPosition(), TEXTCOLOR_ORANGE)
        toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
        player:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
        
        item:transform(4332)
    else
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Sorry you need the sequence of mystic books.")
    end
    
    return true
end
