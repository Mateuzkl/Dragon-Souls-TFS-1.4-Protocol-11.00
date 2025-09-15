function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getActionId() == 6821 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você foi teletransportado pela Pedra magica.")
        player:teleportTo(Position(121, 311, 7))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end
