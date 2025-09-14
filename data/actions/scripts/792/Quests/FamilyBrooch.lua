function onUse(cid, item, frompos, item2, topos)

if item.itemid == 4873 then
doPlayerSendTextMessage(cid,22,"Você encontrou a chave no castelo vá até a Rainha e fale com ela sobre a (blessing) e vá em buscar do Narzan que se encontra no terraço do castelo preso pelos demonios, para voltar para o castelo fale com o npc sobre a Two Mission.")
doSendMagicEffect(getPlayerPosition(cid),2)
end
end
