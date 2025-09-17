local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)

local area = createCombatArea({
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
})

combat:setArea(area)

local damage = 1000000 
local radius = 5 
local timeToKill = 5

function onCastSpell(cid, var)
    local creature = Creature(cid)
    local targets = {}
    
    local function doCreatureDamage(target)
        if target and target ~= creature then
            target:addHealth(-damage)
        end
    end

    local function getTargetsInArea(centerPosition)
        for x = centerPosition.x - radius, centerPosition.x + radius do
            for y = centerPosition.y - radius, centerPosition.y + radius do
                local tile = Tile(Position(x, y, centerPosition.z))
                if tile then
                    local creature = tile:getTopCreature()
                    if creature and creature:isCreature() then
                        table.insert(targets, creature)
                    end
                end
            end
        end
    end

    creature:say("You have " .. timeToKill .. " seconds to kill me, mohaha!", TALKTYPE_MONSTER_SAY)
    getTargetsInArea(creature:getPosition())

    local function startCombat()
        local function countdown()
            if timeToKill > 0 then
                creature:say(timeToKill, TALKTYPE_MONSTER_SAY, false, nil, creature:getPosition())
                timeToKill = timeToKill - 1
                addEvent(countdown, 1000)
            else
                creature:say("Warning!", TALKTYPE_MONSTER_SAY, false, nil, creature:getPosition())

                for _, target in ipairs(targets) do
                    doCreatureDamage(target) 
                end

                combat:execute(creature, var)
            end
        end
        countdown()
    end

    startCombat()

    return true
end
