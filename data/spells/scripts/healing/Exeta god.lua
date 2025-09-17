local tempo = 5 -- tempo em segundos.
local outfit = {lookType = 253, lookHead = 114, lookBody = 128, lookLegs = 114, lookFeet = 128, lookTypeEx = 114, lookAddons = 3} -- Outfit
local effect = {35} -- effect no player, caso queira apenas 1, basta remover os outros numeros.
local health = 9999 -- A cada 1 segundo quantos aumentar de vida
local text = 'Imortal!'

local combat = Combat()
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local condition = Condition(CONDITION_REGENERATION)
condition:setParameter(CONDITION_PARAM_SUBID, 1)
condition:setParameter(CONDITION_PARAM_BUFF, TRUE)
condition:setParameter(CONDITION_PARAM_TICKS, tempo * 1000)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, health)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, 500)
condition:setParameter(CONDITION_PARAM_OUTFIT, outfit)
combat:addCondition(condition)

local sys = Condition(CONDITION_OUTFIT)
sys:setParameter(CONDITION_PARAM_TICKS, tempo * 1000)
sys:addOutfit(outfit)
combat:addCondition(sys)

function magicEffect(tempo, cid)
    if isCreature(cid) then
        if cid:getCondition(CONDITION_REGENERATION, 1) then
            for i = 1, #effect do
                local position = Position(cid:getPosition().x + 0, cid:getPosition().y, cid:getPosition().z)
                position:sendMagicEffect(effect[i])
                doSendAnimatedText(cid:getPosition(), text, TEXTCOLOR_LIGHTBLUE)
                cid:setOutfit(outfit)
            end
        end
    end
end

local cooldown = 5

function onCastSpell99(cid)
    cid:sendTextMessage(MESSAGE_STATUS_WARNING, "CD: Exeta God.")
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 105656569) == 1 then
        doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
        doSendMagicEffect(getCreaturePosition(cid), 19)
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    elseif not getCreatureCondition(cid, CONDITION_REGENERATION, 1) then
        combat:execute(cid, var)
        tempo9 = 0

        while (tempo9 ~= (tempo * 1500)) do
            addEvent(onCastSpell99, cooldown * 1000, cid)
            addEvent(magicEffect, tempo9, tempo9, cid)
            addEvent(doRemoveCondition, tempo * 1000, cid, CONDITION_OUTFIT)
            tempo9 = tempo9 + 1500
        end

        doCreatureSay(cid, "Exeta God!", TALKTYPE_MONSTER)
    else
        doPlayerSendCancel(cid, "Desculpe, mas você ainda está com o efeito da magia.")
    end
end
