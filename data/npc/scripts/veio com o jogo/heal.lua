local target = 0
local focus = 0
local talk_start = 0

 function onThingMove(creature, thing, oldpos, oldstackpos)

 end


 function onCreatureAppear(creature)

 end


 function onCreatureDisappear(cid, pos)

 end


 function onCreatureTurn(creature)

 end



 function onCreatureSay(cid, type, msg)
     msg = string.lower(msg)

     if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 5 then
        selfSay('Hello ' .. creatureGetName(cid) .. '!')
         focus = cid
         talk_start = os.clock()

    elseif (string.find(msg, '(%a*)bye(%a*)') and focus ~= 0) then
        selfSay('Goodbye ' .. creatureGetName(cid) .. '!')
         focus = 0
         talk_start = 0

    elseif (string.find(msg, '(%a*)heal(%a*)') and focus ~= 0) then
         if getPlayerHealth(cid) <= 79 then
            heal(cid, 80)
        else
            selfSay('I cannot heal you.')
        end
    end
 end

 function onCreatureChangeOutfit(creature)

 end


function onThink()
 if (os.clock() - talk_start) > 30 then
  		if focus > 0 then
  			selfSay('Next Please...')
  		end
  			focus = 0
  	end
 	if focus ~= 0 then
 		if getDistanceToCreature(focus) > 5 then
 			selfSay('Good bye then.')
 			focus = 0
 		end
 	end
end
