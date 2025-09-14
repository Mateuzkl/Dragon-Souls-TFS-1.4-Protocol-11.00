function onUse(cid, item, frompos, item2, topos)
         local pos_parede_fogo = {x=464, y=257, z=14, stackpos = 2}
         if getThingfromPos(pos_parede_fogo).itemid == 5061 then
            doRemoveItem(getThingfromPos({x=464, y=257, z=14, stackpos = 2}).uid, 1)
            doRemoveItem(getThingfromPos({x=464, y=257, z=14, stackpos = 1}).uid, 1)
            doCreateItem(3393,1, pos_parede_fogo)
            doCreateItem(1505,1, pos_parede_fogo)
            local hammer = doPlayerAddItem(cid,5908,1)
            doSetItemActionId(hammer,2105)
            doSendMagicEffect(topos,12)
            doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"You have found an obsidian knife. (Used for addons)")
         else
            if not(getThingfromPos(pos_parede_fogo).itemid == 1505) then 
               doPlayerSendCancel(cid,"The room is not ready.")
            end
         end
   return TRUE
end
         
 
 --[[
if item.uid ==7573 then --unique ID do bau da quest pode ser qualquer um

queststatus = getPlayerStorageValue(cid,7573) --storage value, para saber se fez a quest ou nao

if queststatus == 1 then

doPlayerSendTextMessage(cid,22,"This Chest is empty.") --msg caso ja tenha feito a quest

 

else

doPlayerSendTextMessage(cid,22,"you have found a King Key")

doSendMagicEffect(topos,12)

key_uid = doPlayerAddItem(cid,2091,1) --ID da chave que voce recebe (crystal, woode, cooper, etc...)

doSetItemActionId(key_uid,2091) --action ID da key que vc ganha na quest

setPlayerStorageValue(cid,7573,1)

end

return 0

end

return 1

end--]]