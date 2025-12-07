function onSay(player, words, param)
	local message = {}
	
	-- Header com informações do jogador
	table.insert(message, "===== PLAYER STATUS =====")
	table.insert(message, "")
	table.insert(message, "Name: " .. player:getName())
	table.insert(message, "Level: " .. player:getLevel() .. " (" .. player:getVocation():getName() .. ")")
	table.insert(message, "")
	
	-- HP e Mana
	table.insert(message, "--- HEALTH & MANA ---")
	table.insert(message, "HP: " .. player:getHealth() .. " / " .. player:getMaxHealth())
	table.insert(message, "MP: " .. player:getMana() .. " / " .. player:getMaxMana())
	table.insert(message, "")
	
	-- Skills atuais
	table.insert(message, "--- SKILLS ---")
	local skills = {
		{id = SKILL_FIST, name = "Fist"},
		{id = SKILL_CLUB, name = "Club"},
		{id = SKILL_SWORD, name = "Sword"},
		{id = SKILL_AXE, name = "Axe"},
		{id = SKILL_DISTANCE, name = "Distance"},
		{id = SKILL_SHIELD, name = "Shielding"},
		{id = SKILL_FISHING, name = "Fishing"}
	}
	
	for _, skill in ipairs(skills) do
		local level = player:getSkillLevel(skill.id)
		local percent = player:getSkillPercent(skill.id)
		table.insert(message, string.format("%s: %d (%.1f%%)", skill.name, level, percent / 100))
	end
	
	-- Magic Level
	local mlvl = player:getMagicLevel()
	table.insert(message, string.format("Magic Level: %d", mlvl))
	table.insert(message, "")
	
	-- Equipment Status Report (do C++)
	local equipmentReport = player:getEquipmentStatusReport()
	table.insert(message, equipmentReport)
	
	-- Enviar popup
	player:popupFYI(table.concat(message, "\n"))
	return false
end
