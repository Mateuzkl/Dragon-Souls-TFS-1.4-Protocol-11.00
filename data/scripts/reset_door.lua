local doorConfigs = {
	-- Exemplo de configuração. Duplique ou modifique as entradas conforme necessário.
	{
		requiredResets = 5,
		positions = {
			Position(100, 100, 7),
		},
		destination = Position(102, 100, 7),
		successMessage = "Bem-vindo, seu acesso foi liberado!",
		failureMessage = "Você precisa de pelo menos %d resets para entrar!",
	},
}

local DEFAULT_SUCCESS_MESSAGE = "Você atravessa a porta."
local DEFAULT_FAILURE_MESSAGE = "Você precisa de pelo menos %d resets para entrar!"

local function registerDoorAction(config)
	config.successMessage = config.successMessage or DEFAULT_SUCCESS_MESSAGE
	config.failureMessage = config.failureMessage or DEFAULT_FAILURE_MESSAGE

	local action = Action()
	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		if not player or not player:isPlayer() then
			return false
		end

		local resets = player:getReset and player:getReset() or 0
		if resets < config.requiredResets then
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format(config.failureMessage, config.requiredResets))
			return true
		end

		local destination = config.destination
		if destination then
			fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
			player:teleportTo(destination)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			if config.successMessage then
				player:sendTextMessage(MESSAGE_INFO_DESCR, config.successMessage)
			end
			return true
		end

		player:sendTextMessage(MESSAGE_INFO_DESCR, config.successMessage)
		return true
	end

	for _, pos in ipairs(config.positions) do
		action:position(pos)
	end

	action:register()
end

for _, config in ipairs(doorConfigs) do
	registerDoorAction(config)
end

