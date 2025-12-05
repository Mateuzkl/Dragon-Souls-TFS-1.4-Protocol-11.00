function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local effect = tonumber(param)
	if not effect then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: !x <effect_id> (0-65535)")
		return false
	end

	if effect < 0 or effect > 65535 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Effect ID must be between 0 and 65535.")
		return false
	end

	local position = player:getPosition()
	local toPositionLow = {z = position.z}
	local toPositionHigh = {z = position.z}

	toPositionLow.x = position.x - 7
	toPositionHigh.x = position.x + 7
	for i = -5, 5 do
		toPositionLow.y = position.y + i
		toPositionHigh.y = toPositionLow.y
		position:sendDistanceEffect(toPositionLow, effect)
		position:sendDistanceEffect(toPositionHigh, effect)
	end

	toPositionLow.y = position.y - 5
	toPositionHigh.y = position.y + 5
	for i = -6, 6 do
		toPositionLow.x = position.x + i
		toPositionHigh.x = toPositionLow.x
		position:sendDistanceEffect(toPositionLow, effect)
		position:sendDistanceEffect(toPositionHigh, effect)
	end

	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Distance effect " .. effect .. " sent!")
	return false
end
