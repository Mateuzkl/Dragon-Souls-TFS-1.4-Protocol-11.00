local config = {
walks = 4, -- qnts passos irá dar
delay = 750, -- tempo entre 1 passo e outro
speed = 100, --- velocidade do passo
delaycast = 200, -- delay pra carregar (200 milisegundos por cada 10% da spell)
effect = 36, -- efeito que sai enquanto carrega
key = 61728, -- storage q fica salvo se o channeling foi realizado com sucesso
storagCooldown = 61729, -- storage que salva o cooldown da spell
cooldown = 25 -- tempo entre 1 uso e outro da spell
}

function onCastSpell(cid, var)

if getPlayerStorageValue(cid, config.storagCooldown) - os.time() <= 0 then
	setPlayerStorageValue(cid, config.storagCooldown, os.time() + config.cooldown)
else
	doPlayerSendCancel(cid, "Your skill is in cooldown, wait more ".. getPlayerStorageValue(cid, config.storagCooldown) - os.time() .." seconds to use it.")
	return false
end
local time = onCastChannel(cid, getCreatureTarget(cid), config.delaycast, config.effect, config.key)
addEvent(function()
	if isCreature(cid) and getPlayerStorageValue(cid, config.key) == 11 then			
		Taunt(cid, variantToNumber(var), config.delay, config.walks) 
		doCreatureSay(variantToNumber(var), "I WILL KILL YOU!", 20, false, 0, getCreaturePosition(variantToNumber(var)))
		doCreatureSay(cid, "COME AT ME BRO", 20)
		doChangeSpeed(variantToNumber(var), (config.speed - getCreatureBaseSpeed(variantToNumber(var))))
		addEvent(function() 
			if isCreature(variantToNumber(var)) then
				doChangeSpeed(variantToNumber(var), (-config.speed + getCreatureBaseSpeed(variantToNumber(var))))
			end
		end, config.delay * (config.walks + 1))
	elseif isCreature(cid) then
		doPlayerSendCancel(cid, "You broke the channeling spell so the cast was canceled.")
	end
end, time)
return true
end