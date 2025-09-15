local WALL_ID_HORIZONTAL = 3390
local WALL_ID_VERTICAL = 3391
local CRYSTAL_ID_1 = 1543
local CRYSTAL_ID_2 = 1544
local EFFECT_ITEM_ID_1 = 2177
local EFFECT_ITEM_ID_2 = 5070
local TARGET_ITEM_ID = 3900
local DELAY_MS = 120000

local EFFECTS = {
    CONST_ME_MAGIC_BLUE,
    CONST_ME_MAGIC_RED,
    CONST_ME_MAGIC_GREEN,
    CONST_ME_ENERGYHIT,
    CONST_ME_POFF
}

local config = {
    [100] = {
        wall = { pos = Position(466, 239, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(465, 237, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[1],
        delayedFunction = nil
    },
    [200] = {
        wall = { pos = Position(478, 239, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(477, 237, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[2],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(466, 239, 13))
        end
    },
    [300] = {
        wall = { pos = Position(493, 239, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(492, 237, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[3],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(478, 239, 13))
        end
    },
    [400] = {
        wall = { pos = Position(511, 239, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(510, 237, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[4],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(493, 239, 13))
        end
    },
    [500] = {
        wall = { pos = Position(514, 247, 13), id = WALL_ID_VERTICAL },
        create = { pos = Position(512, 246, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[5],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(511, 239, 13))
        end
    },
    [600] = {
        wall = { pos = Position(514, 257, 13), id = WALL_ID_VERTICAL },
        create = { pos = Position(512, 256, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[1],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_2, 1, Position(514, 247, 13))
        end
    },
    [700] = {
        wall = { pos = Position(514, 271, 13), id = WALL_ID_VERTICAL },
        create = { pos = Position(512, 270, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[2],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_2, 1, Position(514, 257, 13))
        end
    },
    [800] = {
        wall = { pos = Position(501, 274, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(502, 272, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[3],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_2, 1, Position(514, 271, 13))
        end
    },
    [900] = {
        wall = { pos = Position(485, 274, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(486, 272, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[4],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(501, 274, 13))
        end
    },
    [1000] = {
        wall = { pos = Position(471, 274, 13), id = WALL_ID_HORIZONTAL },
        create = { pos = Position(472, 272, 13), items = {EFFECT_ITEM_ID_1, EFFECT_ITEM_ID_2} },
        effect = EFFECTS[5],
        delayedFunction = function()
            Game.createItem(CRYSTAL_ID_1, 1, Position(485, 274, 13))
            Game.createItem(CRYSTAL_ID_1, 1, Position(471, 274, 13))
        end
    }
}

local function handleInteraction(player, target, toPosition, cfg)
    local tile = Tile(cfg.wall.pos)
    if not tile then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "The target location is invalid.")
        return false
    end

    local wall = tile:getItemById(cfg.wall.id)
    if not wall then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "No wall found to remove.")
        return false
    end

    wall:remove()
    for _, itemId in ipairs(cfg.create.items) do
        Game.createItem(itemId, 1, cfg.create.pos)
    end

    toPosition:sendMagicEffect(cfg.effect)
    toPosition:sendDistanceEffect(toPosition, CONST_ANI_SMALLSTONE)
    player:getPosition():sendMagicEffect(cfg.effect)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You hear something open.")

    if cfg.delayedFunction then
        addEvent(cfg.delayedFunction, DELAY_MS)
    end

    return true
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not target or target:getId() ~= TARGET_ITEM_ID then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "You can only use this on a specific target.")
        return false
    end

    local actionId = target:getActionId()
    local cfg = config[actionId]
    if not cfg then
        player:sendTextMessage(MESSAGE_STATUS_WARNING, "Invalid action ID.")
        return false
    end

    if handleInteraction(player, target, toPosition, cfg) then
        item:remove()
    end

    return true
end
