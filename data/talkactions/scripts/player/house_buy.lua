function onSay(player, words, param)
	print("DEBUG BUYHOUSE: Comando !buyhouse executado por " .. player:getName())
	
	local housePrice = configManager.getNumber(configKeys.HOUSE_PRICE)
	print("DEBUG BUYHOUSE: housePrice configurado = " .. housePrice)
	
	if housePrice == -1 then
		print("DEBUG BUYHOUSE: housePrice é -1, sistema de casas desabilitado")
		return true
	end

	local houseLevelMinimum = 150
	local playerLevel = player:getLevel()
	print("DEBUG BUYHOUSE: Level do player = " .. playerLevel .. ", mínimo necessário = " .. houseLevelMinimum)
	
	if playerLevel < houseLevelMinimum then
		print("DEBUG BUYHOUSE: Player não tem level suficiente")
		player:sendCancelMessage("You have to be level "..houseLevelMinimum.." to purchase a house.")
        return false
    end

	local isPremium = player:isPremium()
	print("DEBUG BUYHOUSE: Player é premium? " .. tostring(isPremium))
	
	if not isPremium then
		print("DEBUG BUYHOUSE: Player não é premium")
		player:sendCancelMessage("You need a premium account to buy a house.")
		return false
	end

	local position = player:getPosition()
	position:getNextPosition(player:getDirection())
	print("DEBUG BUYHOUSE: Posição checada = " .. position.x .. "," .. position.y .. "," .. position.z)

	local tile = Tile(position)
	local house = tile and tile:getHouse()
	print("DEBUG BUYHOUSE: Tile encontrado? " .. tostring(tile ~= nil) .. ", Casa encontrada? " .. tostring(house ~= nil))

	if not house then
		print("DEBUG BUYHOUSE: Nenhuma casa encontrada na posição")
		player:sendCancelMessage("Please face the door of the house you would like to buy.")
		return false
	end

	local playerHouse = player:getHouse()
	print("DEBUG BUYHOUSE: Player já possui casa? " .. tostring(playerHouse ~= nil))
	
	if house == playerHouse then
		print("DEBUG BUYHOUSE: Player já possui esta casa")
		player:sendCancelMessage("You already own this house.")
		return false
	end

	local houseOwnerGuid = house:getOwnerGuid()
	print("DEBUG BUYHOUSE: Casa já tem dono? OwnerGuid = " .. houseOwnerGuid)
	
	if houseOwnerGuid > 0 then
		print("DEBUG BUYHOUSE: Casa já tem dono")
		player:sendCancelMessage("This house already has an owner.")
		return false
	end

	if playerHouse then
		print("DEBUG BUYHOUSE: Player já possui outra casa: " .. playerHouse:getName())
		player:sendCancelMessage("You already own " .. playerHouse:getName() .. ".")
		return false
	end

	local tileCount = house:getTileCount()
	local price = tonumber(tileCount * housePrice)
	local bankBalance = player:getBankBalance()
	
	print("DEBUG BUYHOUSE: Tiles da casa = " .. tileCount)
	print("DEBUG BUYHOUSE: Preço calculado = " .. price)
	print("DEBUG BUYHOUSE: Saldo no banco = " .. bankBalance)
	print("DEBUG BUYHOUSE: Tem dinheiro suficiente? " .. tostring(bankBalance >= price))

	if (bankBalance >= price) then
		print("DEBUG BUYHOUSE: Comprando casa - removendo " .. price .. " gold do banco")
		player:setBankBalance(bankBalance - price)
		house:setOwnerGuid(player:getGuid())
		print("DEBUG BUYHOUSE: Casa comprada com sucesso!")

		local rentPeriod = configManager.getString(configKeys.HOUSE_RENT_PERIOD)

		if rentPeriod ~= "never" then
			rentString = " Be sure to have " .. price .. " gold in your bank account for the " .. rentPeriod .. " rent."
		else
			rentString = ""
		end

		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You bought " .. house:getName(tile) .. " for " .. price .. " gold from your bank account." .. rentString)
		return true
	else
		print("DEBUG BUYHOUSE: Dinheiro insuficiente - precisa " .. price .. " mas tem " .. bankBalance)
		player:sendCancelMessage("You do not have enough money.")
		return false
	end

	return false
end
