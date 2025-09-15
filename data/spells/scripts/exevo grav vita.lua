local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)

function onTargetTile(creature, position)
    local tile = Tile(position)
    if tile then
        local topThing = tile:getTopVisibleThing(creature)
        if not topThing or not topThing:isItem() or topThing:getType():isMoveable() then
            local item = Game.createItem(Game.getWorldType() == WORLD_TYPE_NO_PVP and ITEM_WILDGROWTH_SAFE or ITEM_WILDGROWTH, 1, position)
            if item then
                item:setAttribute(ITEM_ATTRIBUTE_DURATION, 60000)
            end
        end
    end
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local area = createCombatArea({
    {0, 1, 0},
    {2, 0, 3},
    {0, 4, 0}
})

combat:setArea(area)

function onCastSpell(creature, variant)
    return combat:execute(creature, variant)
end
