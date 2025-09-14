function onUse(cid, item, frompos, item2, topos)
         if item2.actionid == 2551 then
            doTransformItem(item2.uid, 2253) 
            local b = doCreateItem(2091, 1, topos)
            doSetItemActionId(b,2091)
            doSendMagicEffect(topos, 2)
         end
   return TRUE         
end