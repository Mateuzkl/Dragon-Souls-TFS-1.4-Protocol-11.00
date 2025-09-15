function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- annihilator
    if item:getUniqueId() == 7000 then
        if item:getId() == 1945 then
            local player1pos = Position(776, 731, 13)
            local player1 = Tile(player1pos):getTopCreature()
            
            local player2pos = Position(775, 731, 13)
            local player2 = Tile(player2pos):getTopCreature()
            
            local player3pos = Position(774, 731, 13)
            local player3 = Tile(player3pos):getTopCreature()
            
            local player4pos = Position(773, 731, 13)
            local player4 = Tile(player4pos):getTopCreature()
            
            if player1 and player1:isPlayer() and player2 and player2:isPlayer() and 
               player3 and player3:isPlayer() and player4 and player4:isPlayer() then
                
                local player1level = player1:getLevel()
                local player2level = player2:getLevel()
                local player3level = player3:getLevel()
                local player4level = player4:getLevel()
                
                local questlevel = 100
                
                if player1level >= questlevel and player2level >= questlevel and 
                   player3level >= questlevel and player4level >= questlevel then
                    
                    local queststatus1 = player1:getStorageValue(7000)
                    local queststatus2 = player2:getStorageValue(7000)
                    local queststatus3 = player3:getStorageValue(7000)
                    local queststatus4 = player4:getStorageValue(7000)
                    
                    if queststatus1 == -1 and queststatus2 == -1 and 
                       queststatus3 == -1 and queststatus4 == -1 then
                        
                        local nplayer1pos = Position(777, 717, 13)
                        local nplayer2pos = Position(776, 717, 13)
                        local nplayer3pos = Position(775, 717, 13)
                        local nplayer4pos = Position(774, 717, 13)
                        
                        player1pos:sendMagicEffect(CONST_ME_TELEPORT)
                        player2pos:sendMagicEffect(CONST_ME_TELEPORT)
                        player3pos:sendMagicEffect(CONST_ME_TELEPORT)
                        player4pos:sendMagicEffect(CONST_ME_TELEPORT)
                        
                        player1:teleportTo(nplayer1pos)
                        player2:teleportTo(nplayer2pos)
                        player3:teleportTo(nplayer3pos)
                        player4:teleportTo(nplayer4pos)
                        
                        nplayer1pos:sendMagicEffect(CONST_ME_TELEPORT)
                        nplayer2pos:sendMagicEffect(CONST_ME_TELEPORT)
                        nplayer3pos:sendMagicEffect(CONST_ME_TELEPORT)
                        nplayer4pos:sendMagicEffect(CONST_ME_TELEPORT)
                        
                        item:transform(item:getId() + 1)
                        
                    else
                        player:sendCancelMessage("Somebody in your team has already done this quest.")
                    end
                else
                    player:sendCancelMessage("All players must have level 100 to enter.")
                end
            else
                player:sendCancelMessage("You need 4 players in your team, must have level 100.")
            end
        elseif item:getId() == 1946 then
            if player:getAccess() > 0 then
                item:transform(1945)
            else
                player:sendCancelMessage("Sorry, not possible.")
            end
        end
    end
    return true
end
