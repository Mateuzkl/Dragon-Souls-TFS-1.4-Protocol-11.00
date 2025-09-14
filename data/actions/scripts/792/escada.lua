   function onUse(cid, item, frompos, item2, topos)
   	npos = {x=frompos.x, y=frompos.y, z=frompos.z}
   	if item.itemid == 410 then
   		npos.y = npos.y + 10
   		npos.z = npos.z - 10
   		doTeleportThing(cid,npos)
   	else
   		npos.z = npos.z + 10
   		doTeleportThing(cid,npos)
   	end
 
   	return 1
   end
