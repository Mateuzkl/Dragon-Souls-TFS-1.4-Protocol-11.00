local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local stime = 120 -- Tempo entre as execuções do comando (em segundos)
local time = os.time()

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, msgType, msg)   npcHandler:onCreatureSay(cid, msgType, msg) end

function onThink()                          
    npcHandler:onThink()
    
    if (time + stime) < os.time() then
        time = os.time()
        Game.broadcastMessage("Server cleaning...", MESSAGE_STATUS_WARNING)
        
        -- Execute clean command
        local players = Game.getPlayers()
        for _, player in pairs(players) do
            if player:getGroup():getAccess() then
                player:remove()
                break
            end
        end
        
        -- Alternative: Direct cleanup
        Game.cleanup()
    end
end

npcHandler:addModule(FocusModule:new())
