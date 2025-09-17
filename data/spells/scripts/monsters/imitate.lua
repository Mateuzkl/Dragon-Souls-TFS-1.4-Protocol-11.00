local combat = Combat()

function onTargetCreature(creature, target)
	local outfit = target:getOutfit()
	creature:setOutfit(outfit)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end
