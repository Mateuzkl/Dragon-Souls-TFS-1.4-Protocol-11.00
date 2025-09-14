function onUse(cid, item, frompos, item2, topos)

if item.actionid == 6821 then
doPlayerSendTextMessage(cid,24,"Você foi teletransportado pela Pedra magica.")
doTeleportThing(cid,{x=121, y=311, z=7})
doSendMagicEffect(getPlayerPosition(cid),50)
end
end