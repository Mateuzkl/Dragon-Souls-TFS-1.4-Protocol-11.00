local storage = 91831
local time = 5
local tempo = 20
local effect = {29}
local text = 'Skill Up!'

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_ATTRIBUTES)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo*1000)
setConditionParam(condition, CONDITION_PARAM_SKILL_MELEE, 50)
setConditionParam(condition, CONDITION_PARAM_SKILL_FIST, 50)
setConditionParam(condition, CONDITION_PARAM_SKILL_SHIELD, 50)
setCombatCondition(combat, condition)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_SUBID, 1)
setConditionParam(condition, CONDITION_PARAM_BUFF, TRUE)
setConditionParam(condition, CONDITION_PARAM_TICKS, tempo*1000)
setCombatCondition(combat, condition)


function magicEffect3(tempo2,tempo3,cid)
if (isCreature(cid)) then
    if getPlayerStorageValue(cid, 102053) ~= 0 and getCreatureCondition(cid, CONDITION_REGENERATION, 1) then
        for i=1, #effect do
        local position = {x=getPlayerPosition(cid).x+0, y=getPlayerPosition(cid).y, z=getPlayerPosition(cid).z}
        doSendMagicEffect(position, effect[i])
		doSendAnimatedText(getCreaturePos(cid), text, TEXTCOLOR_RED)
        end
    end
end
end

local cooldown = 20
function onCastSpell4(cid)
    if isPlayer(cid) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "CD: Exevo Grav.")
    end
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, storage) > os.time() then 
        return doPlayerSendCancel(cid, "You are already under this spell's effect.")
    else
        setPlayerStorageValue(cid, storage, os.time() + time)
        doPlayerSendTextMessage(cid, 27, string.format("Durante %d segundo%s, metade de todo dano que você receber será refletido.", time, time > 1 and "s" or ""))
    return true
end
if getPlayerStorageValue(cid, 10569) == 1 then
doSendAnimatedText((getCreaturePosition(cid)), "Socorro!", 255)
doSendMagicEffect(getCreaturePosition(cid), 19)
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
return false 

elseif getCreatureCondition(cid, CONDITION_REGENERATION, 1) == false then
    doCombat(cid, combat, var)
    tempo2 = 0
    while (tempo2 ~= (tempo*1000)) do
        addEvent(magicEffect3, tempo2, tempo2, tempo*1000, cid)
        tempo2 = tempo2 + 4000
    end
	doCreatureSay(cid, "Exevo Grav", TALKTYPE_MONSTER)
	addEvent(onCastSpell4, cooldown*4000, cid)
else
    doPlayerSendCancel(cid, "Desculpe, mais você ainda está no efeito da magia.")
	doSendMagicEffect(getCreaturePosition(cid), 2)
end
end
