function onUse(cid, item, frompos, item2, topos) --by mirto
         local esquerda = {
         {x=436,y=238,z=14},
         {x=436,y=240,z=14}
         }
         local direita = {
         {x=440,y=239,z=14},
         {x=440,y=241,z=14}
         }
         local porta = {x=438,y=236,z=14,stackpos=1}
         if item.itemid == 1945 then
            for x=1, #esquerda do
                doRemoveItem(getThingfromPos({x=esquerda[x].x,y=esquerda[x].y,z=esquerda[x].z, stackpos=1}).uid, 1)
                doSummonCreature("Guardian Gargoyle", esquerda[x])
                doCreateItem(1459, 1, esquerda[x])
                doSendMagicEffect(esquerda[x], 10)
            end
            for x=1, #direita do
                doRemoveItem(getThingfromPos({x=direita[x].x,y=direita[x].y,z=direita[x].z, stackpos=1}).uid, 1)
                doSummonCreature("Guardian Gargoyle", direita[x])
                doCreateItem(1458, 1, direita[x])
                doSendMagicEffect(direita[x], 10)
            end
            doRemoveItem(getThingfromPos(porta).uid,1)
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "The prophecy was completed!")
            doTransformItem(item.uid, 1946)
         end
   return TRUE
end
            