local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat2:setParameter(COMBAT_PARAM_DISPEL, CONDITION_FIRE)

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat3:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

local combat4 = Combat()
combat4:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat4:setParameter(COMBAT_PARAM_DISPEL, CONDITION_BLEEDING)

local combat5 = Combat()
combat5:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat5:setParameter(COMBAT_PARAM_DISPEL, CONDITION_ENERGY)

local combat6 = Combat()
combat6:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat6:setParameter(COMBAT_PARAM_DISPEL, CONDITION_REGENERATION)

local combat8 = Combat()
combat8:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat8:setParameter(COMBAT_PARAM_DISPEL, CONDITION_INVISIBLE)

local combat9 = Combat()
combat9:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat9:setParameter(COMBAT_PARAM_DISPEL, CONDITION_LIGHT)

local combat10 = Combat()
combat10:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat10:setParameter(COMBAT_PARAM_DISPEL, CONDITION_FROZZEN)

local combat11 = Combat()
combat11:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat11:setParameter(COMBAT_PARAM_DISPEL, CONDITION_DROWN)

local combat12 = Combat()
combat12:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
combat12:setParameter(COMBAT_PARAM_DISPEL, CONDITION_DRUNK)

function onTargetCreature(creature, target)
    if target:isPlayer() then
        local slotItem9 = target:getSlotItem(CONST_SLOT_AMMO)
        local slotItem10 = target:getSlotItem(CONST_SLOT_RING)
        
        if (slotItem9 and slotItem9:getId() == 2204) or (slotItem10 and slotItem10:getId() == 13502) then
            Game.sendAnimatedText("Dispel!", target:getPosition(), 215)
        else
            combat10:execute(target, Variant(target:getPosition()))
            combat6:execute(target, Variant(target:getPosition()))
            Game.sendAnimatedText("Dispel!", target:getPosition(), 215)
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETCREATURE, "onTargetCreature")

function onCastSpell(creature, variant)
    combat2:execute(creature, variant)
    combat3:execute(creature, variant)
    combat4:execute(creature, variant)
    combat5:execute(creature, variant)
    combat8:execute(creature, variant)
    combat9:execute(creature, variant)
    combat11:execute(creature, variant)
    combat12:execute(creature, variant)
    return combat:execute(creature, variant)
end
