function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	local effect = tonumber(param)
	if not effect then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Usage: !z <effect_id> (0-65535)")
		return false
	end

	if effect < 0 or effect > 65535 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Effect ID must be between 0 and 65535.")
		return false
	end

	player:getPosition():sendMagicEffect(effect)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Magic effect " .. effect .. " sent!")

	return false
end
