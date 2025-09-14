function onUse(cid, item, frompos, item2, topos)
skill = getPlayerSkill(cid,0)
maglevel = getPlayerMagLevel(cid)
level = getPlayerLevel(cid)
min = ((level*994)+skill+maglevel)
max = ((level*1680)+skill+maglevel)

exp = math.random(min,max)

doPlayerAddExp(cid,exp)
doPlayerSendTextMessage(cid,20,'Você recebeu ' .. exp .. ' de experiência.')
doSendMagicEffect(getCreaturePosition(cid), 12)
doSendAnimatedText(getPlayerPosition(cid),exp, 179)
end