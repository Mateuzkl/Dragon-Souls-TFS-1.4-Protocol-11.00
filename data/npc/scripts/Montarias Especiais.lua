local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
 
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
 
npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|. Eu vendo todas as montarias do jogo! Basta dizer {montarias} ou {ajuda} se voce não sabe o que fazer.")
 
function playerBuyMountNPC(cid, message, keywords, parameters, node)
if(not npcHandler:isFocused(cid)) then
return false
end
if (parameters.confirm ~= true) and (parameters.decline ~= true) then
if(getPlayerPremiumDays(cid) >= 1) and (parameters.premium == true) then
npcHandler:say('Desculpe, mas esta montaria e apenas para jogadores premium!', cid)
npcHandler:resetNpc()
return true
end
if (getPlayerStorageValue(cid, parameters.storageID) ~= -1) then
npcHandler:say('Voce ja tem esta montaria!', cid)
npcHandler:resetNpc()
return true
end
local itemsTable = parameters.items
local items_list = ''
if table.maxn(itemsTable) > 0 then
for i = 1, table.maxn(itemsTable) do
local item = itemsTable
items_list = items_list .. item[2] .. ' ' .. getItemNameById(item[1])
if i ~= table.maxn(itemsTable) then
items_list = items_list .. ', '
end
end
end
local text = ''
if (parameters.cost > 0) and table.maxn(parameters.items) then
text = items_list .. '' .. parameters.cost .. ' gp'
elseif (parameters.cost > 0) then
text = parameters.cost .. ' gp'
elseif table.maxn(parameters.items) then
text = items_list
end
npcHandler:say('Voce quer pagar ' .. text .. ' pelo ' .. keywords[1] .. '?', cid)
return true
elseif (parameters.confirm == true) then
local mountNode = node:getParent()
local mountinfo = mountNode:getParameters()
local items_number = 0
if table.maxn(mountinfo.items) > 0 then
for i = 1, table.maxn(mountinfo.items) do
local item = mountinfo.items
if (getPlayerItemCount(cid,item[1]) >= item[2]) then
items_number = items_number + 1
end
end
end
if(getPlayerMoney(cid) >= mountinfo.cost) and (items_number == table.maxn(mountinfo.items)) then
doPlayerRemoveMoney(cid, mountinfo.cost)
if table.maxn(mountinfo.items) > 0 then
for i = 1, table.maxn(mountinfo.items) do
local item = mountinfo.items
doPlayerRemoveItem(cid,item[1],item[2])
end
end
doPlayerAddMount(cid, mountinfo.mountid)
setPlayerStorageValue(cid,mountinfo.storageID,1)
npcHandler:say('Aqui esta.', cid)
else
npcHandler:say('Voce nao tem o dinheiro necessario!', cid)
end
npcHandler:resetNpc()
return true
elseif (parameters.decline == true) then
npcHandler:say('Este nao lhe interessa? Experimente outro!', cid)
npcHandler:resetNpc()
return true
end
return false
end
 
local noNode = KeywordNode:new({'no'}, playerBuyMountNPC, {decline = true})
local yesNode = KeywordNode:new({'yes'}, playerBuyMountNPC, {confirm = true})
 
-- blazebringer (done)(custom)
local mount_node = keywordHandler:addKeyword({'blazebringer'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 9, storageID = 10057})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Donkey (done)(custom)
local mount_node = keywordHandler:addKeyword({'donkey'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 13, storageID = 10058})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Rented Horse (done)(custom)
local mount_node = keywordHandler:addKeyword({'rented horse 1'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 22, storageID = 10059})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
local mount_node = keywordHandler:addKeyword({'rented horse 2'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 25, storageID = 10060})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
local mount_node = keywordHandler:addKeyword({'rented horse 3'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 26, storageID = 10061})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Shadow Draptor (done)(custom)
local mount_node = keywordHandler:addKeyword({'shadow draptor'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 24, storageID = 10062})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Stampor (done)(custom)
local mount_node = keywordHandler:addKeyword({'stampor'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 11, storageID = 10063})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Uniwheel (done)(custom)
local mount_node = keywordHandler:addKeyword({'uniwheel'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 15, storageID = 10064})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Tin Lizzard (done)(custom)
local mount_node = keywordHandler:addKeyword({'tin lizzard'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 8, storageID = 10065})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Dragonling (done)(custom)
local mount_node = keywordHandler:addKeyword({'dragonling'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 31, storageID = 10066})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Rei Scorpiao (done)(custom)
local mount_node = keywordHandler:addKeyword({'rei scorpiao'}, playerBuyMountNPC, {premium = false, cost = 1000000, items = {}, mountid = 21, storageID = 10067})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Manta (done)(custom)
local mount_node = keywordHandler:addKeyword({'manta'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 28, storageID = 10068})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Iron Blight (done)(custom)
local mount_node = keywordHandler:addKeyword({'iron blight'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 29, storageID = 10069})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Widow Queen (done)(custom)
local mount_node = keywordHandler:addKeyword({'widow queen'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 1, storageID = 10070})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Racing Bird (done)(custom)
local mount_node = keywordHandler:addKeyword({'racing bird'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 2, storageID = 10071})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- War Bear (done)(custom)
local mount_node = keywordHandler:addKeyword({'war bear'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 3, storageID = 10072})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Black Sheep (done)(custom)
local mount_node = keywordHandler:addKeyword({'black sheep'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 4, storageID = 10073})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Midnight Panther (done)(custom)
local mount_node = keywordHandler:addKeyword({'midnight panther'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 5, storageID = 10074})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Draptor (done)(custom)
local mount_node = keywordHandler:addKeyword({'draptor'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 6, storageID = 10075})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Titanica (done)(custom)
local mount_node = keywordHandler:addKeyword({'titanica'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 7, storageID = 10076})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Rapid Boar (done)(custom)
local mount_node = keywordHandler:addKeyword({'rapid boar'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 10, storageID = 10077})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Undead Cavebear (done)(custom)
local mount_node = keywordHandler:addKeyword({'undead cavebear'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 12, storageID = 10078})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Tiger Slug (done)(custom)
local mount_node = keywordHandler:addKeyword({'tiger slug'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 14, storageID = 10079})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Crystal Wolf (done)(custom)
local mount_node = keywordHandler:addKeyword({'crystal wolf'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 16, storageID = 10080})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Kingly Deer (done)(custom)
local mount_node = keywordHandler:addKeyword({'kingly deer'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 18, storageID = 10081})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Tamed Panda (done)(custom)
local mount_node = keywordHandler:addKeyword({'tamed panda'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 19, storageID = 10082})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Dromedary (done)(custom)
local mount_node = keywordHandler:addKeyword({'dromedary'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 20, storageID = 10083})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Ladybug (done)(custom)
local mount_node = keywordHandler:addKeyword({'ladybug'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 27, storageID = 10084})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Magma Crawler (done)(custom)
local mount_node = keywordHandler:addKeyword({'magma crawler'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 30, storageID = 10085})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
-- Gnarlhound (done)(custom)
local mount_node = keywordHandler:addKeyword({'gnarlhound'}, playerBuyMountNPC, {premium = false, cost = 30000, items = {}, mountid = 30, storageID = 10086})
mount_node:addChildKeywordNode(yesNode)
mount_node:addChildKeywordNode(noNode)
 
 
keywordHandler:addKeyword({'montarias'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Posso te vender  {gnarlhound}, {magma crawler}, {ladybug}, {dromedary}, {tamed panda}, {kingly deer}, {crystal wolf}, {tiger slug}, {undead cavebear}, {rapid boar}, {titanica}, {draptor}, {midnight panther}, {black sheep}, {war bear} {racing bird}, {widow queen}, {blazebringer}, {donkey}, {rented horse} de 1 a 3, {shadow draptor}, {manta}, {iron Blight}, {dragonling}, {stampor}, {uniwheel}, {tin lizzard} e o grande {rei scorpiao}.'})
keywordHandler:addKeyword({'ajuda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Para ter a montaria fale um dos nomes da lista (falando {montarias}) .'})
keywordHandler:addKeyword({'rented horse'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Existem 3 tipos de rented horse, para compra-los é {rented horse 1}, {rented horse 2} e {rented horse 3} eles são por tempo ilimitado.'})
 
npcHandler:addModule(FocusModule:new())
