local portalPositions = {
	Position(95, 116, 7),
	Position(96, 116, 7),
	Position(97, 116, 7),
	Position(98, 116, 7),
	Position(99, 116, 7),
}

local destination = Position(95, 112, 7)

local portal = MoveEvent()

function portal.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	position:sendMagicEffect(CONST_ME_TELEPORT)
	player:teleportTo(destination)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been teleported!")
	return true
end

portal:type("stepin")

for _, pos in pairs(portalPositions) do
	portal:position(pos)
end

portal:register()
