function onUse(cid, item, frompos, itemEx, topos)
         if itemEx.actionid == 1056 then
            doCreateItem(5070,1,topos)
            doPlayerAddItem(cid, 4874, 1) --pick special p/ valan
            return TRUE
         end
end