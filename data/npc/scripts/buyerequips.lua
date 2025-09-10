 focus = 0
 talk_start = 0
 target = 0
 following = false
 attacking = false
 
 function onThingMove(creature, thing, oldpos, oldstackpos)
 
 end
 
 
 function onCreatureAppear(creature)
 
 end
 
 
 function onCreatureDisappear(cid, pos)
 	if focus == cid then
         selfSay('Good Bye.')
         focus = 0
         talk_start = 0
 	end
 end
 
 
 function onCreatureTurn(creature)
 
 end
 
 function msgcontains(txt, str)
 	return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
 end
 
 function onCreatureSay(cid, type, msg)
 	msg = string.lower(msg)
 
 	if ((string.find(msg, '(%a*)hi(%a*)')) and (focus == 0)) and getDistanceToCreature(cid) < 3 then
 		selfSay('Hiho ' .. creatureGetName(cid) .. '! I buy ALL equipments: Shields, Helmets, Legs, Armors, Weapons, Amulets and Rings. Also I\'m buying Pearls, etc. Say the name of the item what you want and I will buy from you!')
 		selfLook(cid)
		focus = cid
 		talk_start = os.clock()
 	end
 
 	if string.find(msg, '(%a*)hi(%a*)') and (focus ~= cid) and getDistanceToCreature(cid) < 3 then
 		selfSay('Wait Please.')
 	end
 
 	if msgcontains(msg, 'swords list') and focus == cid then
		selfSay('I buy Combat Knife, Silver Dagger, Short Sword, Sabre, Bone Sword, Carlin Sword, Heavy Machete, Katana, Long Sword, Poison Dagger, Scimitar, Templar Scytheblade, Broad Sword, Serpent Sword, Two-Handed Sword, Fire Sword, Bright Sword, Giant Sword, Magic Sword, Warlord Sword, Magic Long Sword, Ice Rapier.')
 		talk_start = os.clock()
 	end
 
	if msgcontains(msg, 'dagger') and focus == cid then
	item = 3205
	price = 5
	selfSay('Do you want to sell a Dagger for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end 	

        if msgcontains(msg, 'combat knife') and focus == cid then
	item = 3230
	price = 7
	selfSay('Do you want to sell a Combat Knife for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'silver dagger') and focus == cid then
	item = 3228
	price = 10
	selfSay('Do you want to sell a Silver Dagger for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'short sword') and focus == cid then
	item = 3232
	price = 15
	selfSay('Do you want to sell a Short Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'sabre') and focus == cid then
	item = 3211
	price = 17
	selfSay('Do you want to sell a Sabre for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'bone sword') and focus == cid then
	item = 3276
	price = 20
	selfSay('Do you want to sell a Bone Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'carlin sword') and focus == cid then
	item = 3221
	price = 22
	selfSay('Do you want to sell a Carlin Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'heavy machete') and focus == cid then
	item = 3268
	price = 35
	selfSay('Do you want to sell a Heavy Machete for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if msgcontains(msg, 'katana') and focus == cid then
	item = 3238
	price = 40
	selfSay('Do you want to sell a Katana for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'longsword') and focus == cid then
	item = 3223
	price = 50
	selfSay('Do you want to sell a Longsword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'poison dagger') and focus == cid then
	item = 3237
	price = 60
	selfSay('Do you want to sell a Poison Dagger for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scimitar') and focus == cid then
	item = 3245
	price = 75
	selfSay('Do you want to sell a Scimitar for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'templar scytheblade') and focus == cid then
	item = 3283
	price = 250
	selfSay('Do you want to sell a Templar Scytheblade for ' ..price.. ' Gold Coins?')
	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'broad sword') and focus == cid then
	item = 3239
	price = 150
	selfSay('Do you want to sell a Broad Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'serpent sword') and focus == cid then
	item = 3235
	price = 300
	selfSay('Do you want to sell a Serpent Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'two-handed sword') and focus == cid then
	item = 3203
	price = 400
	selfSay('Do you want to sell a Two-handed sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'fire sword') and focus == cid then
	item = 3218
	price = 2500
	selfSay('Do you want to sell a Fire Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'bright sword') and focus == cid then
	item = 3233
	price = 7500
	selfSay('Do you want to sell a Bright Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'giant sword') and focus == cid then
	item = 3219
	price = 10000
	selfSay('Do you want to sell a Giant Sword for ' ..price.. ' Gold Coins?')
 		sell(cid,3219,1,10000)
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'magic sword') and focus == cid then
	item = 3226
	price = 75000
	selfSay('Do you want to sell a Magic Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'warlord sword') and focus == cid then
	item = 3234
	price = 125000
	selfSay('Do you want to sell a Warlord Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'magic long sword') and focus == cid then
	item = 3216
	price = 200000
	selfSay('Do you want to sell a Magic Long Sword for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ice rapier') and focus == cid then
	item = 3222
	price = 1500
	selfSay('Do you want to sell a Ice Rapier for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'clubs list') and focus == cid then
		selfSay('I buy Crowbar, Scythe, Studded Club, Bone Club, Iron Hammer, Daramanian Mace, Battle Hammer, Morning Star, Banana Staff, Clerical Mace, Dragon Hammer, Skull Staff, Crystal Mace, Silver Mace, War Hammer, Hammer of Wrath, Thunder Hammer and Magic Staff.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crowbar') and focus == cid then
	item = 3242
	price = 50
	selfSay('Do you want to sell a Crowbar for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'club') and focus == cid then
	item = 3208
	price = 2
	selfSay('Do you want to sell a Club for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scythe') and focus == cid then
	item = 3391
	price = 5
	selfSay('Do you want to sell a Scythe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'studded club') and focus == cid then
	item = 3274
	price = 7
	selfSay('Do you want to sell a Studded Club for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'bone club') and focus == cid then
	item = 3275
	price = 12
	selfSay('Do you want to sell a Bone Club for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'mace') and focus == cid then
	item = 3224
	price = 15
	selfSay('Do you want to sell a Mace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'iron hammer') and focus == cid then
	item = 3248
	price = 40
	selfSay('Do you want to sell a Iron Hammer for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'daramanian mace') and focus == cid then
	item = 3265
	price = 50
	selfSay('Do you want to sell a Daramanian Mace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'battle hammer') and focus == cid then
	item = 3146
	price = 60
	selfSay('Do you want to sell a Battle Hammer for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'morning star') and focus == cid then
	item = 3220
	price = 75
	selfSay('Do you want to sell a Morning Star for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'banana staff') and focus == cid then
	item = 3286
	price = 250
	selfSay('Do you want to sell a Banana Staff for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'clerical mace') and focus == cid then
	item = 3249
	price = 200
	selfSay('Do you want to sell a Clerical Mace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon hammer') and focus == cid then
	item = 3260
	price = 1500
	selfSay('Do you want to sell a Dragon Hammer for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'skull staff') and focus == cid then
	item = 3262
	price = 5000
	selfSay('Do you want to sell a Skull Staff for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crystal mace') and focus == cid then
	item = 3271
	price = 20000
	selfSay('Do you want to sell a Crystal Mace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'silver mace') and focus == cid then
	item = 3250
	price = 40000
	selfSay('Do you want to sell a Silver Mace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'war hammer') and focus == cid then
	item = 3217
	price = 2500
	selfSay('Do you want to sell a War Hammer for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'hammer of wrath') and focus == cid then
	item = 3270
	price = 50000
	selfSay('Do you want to sell a Hammer of Wrath for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'thunder hammer') and focus == cid then
	item = 3247
	price = 75000
	selfSay('Do you want to sell a Thunder Hammer for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'magic staff') and focus == cid then
	item = 3259
	price = 7500
	selfSay('Do you want to sell a Magic Staff for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'axes list') and focus == cid then
		selfSay('I buy Hand Axe, Golden Sickle, Hatchet, Hunting Spear, Orcish Axe, Battle Axe, Ripper Lance, Barbarian Axe, Knight Axe, Obsidian Lance, Double Axe, Halberd, Fire Axe, Naginata, Daramanian Waraxe, Guardian Halberd, Dragon Lance, Stonecutter Axe and Great Axe.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'hand axe') and focus == cid then
	item = 3206
	price = 5
	selfSay('Do you want to sell a Hand Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden sickle') and focus == cid then
	item = 3244
	price = 500
	selfSay('Do you want to sell a Golden Sickle for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'hatchet') and focus == cid then
	item = 3214
	price = 15
	selfSay('Do you want to sell a Hatchet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'hunting spear') and focus == cid then
	item = 3285
	price = 250
	selfSay('Do you want to sell a Hunting Spear for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'orcish axe') and focus == cid then
	item = 3254
	price = 200
	selfSay('Do you want to sell a Orcish Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'battle axe') and focus == cid then
	item = 3204
	price = 300
	selfSay('Do you want to sell a Battle Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ripper lance') and focus == cid then
	item = 3284
	price = 1000
	selfSay('Do you want to sell a Ripper Lance for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'barbarian axe') and focus == cid then
	item = 3255
	price = 400
	selfSay('Do you want to sell a Barbarian Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'knight axe') and focus == cid then
	item = 3256
	price = 1500
	selfSay('Do you want to sell a Knight Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'obsidian lance') and focus == cid then
	item = 3251
	price = 300
	selfSay('Do you want to sell a Obsidian Lance for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'double axe') and focus == cid then
	item = 3213
	price = 400
	selfSay('Do you want to sell a Double Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'fire axe') and focus == cid then
	item = 3258
	price = 6000
	selfSay('Do you want to sell a Fire Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'naginata') and focus == cid then
	item = 3252
	price = 5000
	selfSay('Do you want to sell a Naginata for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'daramanian waraxe') and focus == cid then
	item = 3266
	price = 5000
	selfSay('Do you want to sell a Daramanian Waraxe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'guardian halberd') and focus == cid then
	item = 3253
	price = 7500
	selfSay('Do you want to sell a Guardian Halberd for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon lance') and focus == cid then
	item = 3240
	price = 10000
	selfSay('Do you want to sell a Dragon Lance for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'stonecutter axe') and focus == cid then
	item = 3257
	price = 75000
	selfSay('Do you want to sell a Stonecutter Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'great axe') and focus == cid then
	item = 3241
	price = 150000
	selfSay('Do you want to sell a Great Axe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'armors list') and focus == cid then
		selfSay('I buy Simple Dress, Ball Gown, Cape, Jacket, Green Tunic, Red Robe, Doublet, Red Tunic, Leather Armor, Studded Armor, Chain Armor, Brass Armor, Scale Armor, Plate Armor, Dark Armor, Noble Armor, Knight Armor, Crown Armor, Lady Armor, Blue Robe, Golden Armor, Dragon Scale Mail, Demon Armor, Magic Plate Armor.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'simple dress') and focus == cid then
	item = 3206
	price = 100
	selfSay('Do you want to sell a Simple Dress for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ball gown') and focus == cid then
	item = 3508
	price = 150
	selfSay('Do you want to sell a Ball Gown for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'cape') and focus == cid then
	item = 3503
	price = 25
	selfSay('Do you want to sell a Cape for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'jacket') and focus == cid then
	item = 3500
	price = 5
	selfSay('Do you want to sell a Jacket for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'green tunic') and focus == cid then
	item = 3501
	price = 25
	selfSay('Do you want to sell a Green Tunic for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'red robe') and focus == cid then
	item = 3504
	price = 10000
	selfSay('Do you want to sell a Red Robe for ' ..price.. ' Gold Coins?')
 		sell(cid,3504,1,10000)
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'doublet') and focus == cid then
	item = 3317
	price = 15
	selfSay('Do you want to sell a Doublet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'red tunic') and focus == cid then
	item = 3502
	price = 150
	selfSay('Do you want to sell a Red Tunic for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'leather armor') and focus == cid then
	item = 3299
	price = 20
	selfSay('Do you want to sell a Leather Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'studded armor') and focus == cid then
	item = 3316
	price = 30
	selfSay('Do you want to sell a Studded Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'chain armor') and focus == cid then
	item = 3296
	price = 100
	selfSay('Do you want to sell a Chain Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'brass armor') and focus == cid then
	item = 3297
	price = 200
	selfSay('Do you want to sell a Brass Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scale armor') and focus == cid then
	item = 3315
	price = 150
	selfSay('Do you want to sell a Scale Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'plate armor') and focus == cid then
	item = 3295
	price = 400
	selfSay('Do you want to sell a Plate Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dark armor') and focus == cid then
	item = 3321
	price = 500
	selfSay('Do you want to sell a Dark Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'noble armor') and focus == cid then
	item = 3318
	price = 1000
	selfSay('Do you want to sell a Noble Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'knight armor') and focus == cid then
	item = 3308
	price = 2500
	selfSay('Do you want to sell a Knight Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crown armor') and focus == cid then
	item = 3319
	price = 5000
	selfSay('Do you want to sell a Crown Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'lady armor') and focus == cid then
	item = 3332
	price = 6000
	selfSay('Do you want to sell a Lady Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'blue robe') and focus == cid then
	item = 3505
	price = 5500
	selfSay('Do you want to sell a Blue Robe for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden armor') and focus == cid then
	item = 3298
	price = 25000
	selfSay('Do you want to sell a Golden Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon scale mail') and focus == cid then
	item = 3324
	price = 60000
	selfSay('Do you want to sell a Dragon Scale Mail for ' ..price.. ' Gold Coins?')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'demon armor') and focus == cid then
	item = 3326
	price = 150000
	selfSay('Do you want to sell a Demon Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'magic plate armor') and focus == cid then
	item = 3304
	price = 250000
	selfSay('Do you want to sell a Magic Plate Armor for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'shields list') and focus == cid then
		selfSay('I buy Wooden Shield, Studded Shield, Brass Shield, Plate Shield, Black Shield, Copper Shield, Bone Shield, Steel Shield, Sentinel Shield, Ornamented Shield, Viking Shield, Battle Shield, Scarab Shield, Dark Shield, Salamander Shield, Dwarven Shield, Tusk Shield, Ancient Shield, Rose Shield, Castle Shield, Beholder Shield, Griffin Shield, Guardian Shield, Dragon Shield, Tower Shield, Crown Shield, Amazon Shield, Medusa Shield, Shield of Honour, Vampire Shield, Phoenix Shield, Demon Shield, Mastermind Shield, Great Shield and Blessed Shield.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'wooden shield') and focus == cid then
	item = 3350
	price = 5
	selfSay('Do you want to sell a Wooden Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'studded shield') and focus == cid then
	item = 3364
	price = 20
	selfSay('Do you want to sell a Studded Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'brass shield') and focus == cid then
	item = 3349
	price = 30
	selfSay('Do you want to sell a Brass Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'plate shield') and focus == cid then
	item = 3348
	price = 50
	selfSay('Do you want to sell a Plate Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'black shield') and focus == cid then
	item = 3367
	price = 200
	selfSay('Do you want to sell a Black Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'copper shield') and focus == cid then
	item = 3368
	price = 125
	selfSay('Do you want to sell a Copper Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'bone shield') and focus == cid then
	item = 3379
	price = 200
	selfSay('Do you want to sell a Bone Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'steel shield') and focus == cid then
	item = 3347
	price = 200
	selfSay('Do you want to sell a Steel Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'sentinel shield') and focus == cid then
	item = 3382
	price = 400
	selfSay('Do you want to sell a Sentinel Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ornamented shield') and focus == cid then
	item = 3362
	price = 300
	selfSay('Do you want to sell a Ornamented Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'viking shield') and focus == cid then
	item = 3369
	price = 350
	selfSay('Do you want to sell a Viking Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'battle shield') and focus == cid then
	item = 3351
	price = 250
	selfSay('Do you want to sell a Battle Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scarab shield') and focus == cid then
	item = 3378
	price = 600
	selfSay('Do you want to sell a Scarab Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dark shield') and focus == cid then
	item = 3359
	price = 350
	selfSay('Do you want to sell a Dark Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'salamander shield') and focus == cid then
	item = 3383
	price = 900
	selfSay('Do you want to sell a Salamander Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dwarven shield') and focus == cid then
	item = 3363
	price = 100
	selfSay('Do you want to sell a Dwarven Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'tusk shield') and focus == cid then
	item = 3381
	price = 500
	selfSay('Do you want to sell a Tusk Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ancient shield') and focus == cid then
	item = 3370
	price = 400
	selfSay('Do you want to sell a Ancient Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'rose shield') and focus == cid then
	item = 3365
	price = 1000
	selfSay('Do you want to sell a Rose Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'castle shield') and focus == cid then
	item = 3373
	price = 4000
	selfSay('Do you want to sell a Castle Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'beholder shield') and focus == cid then
	item = 3356
	price = 750
	selfSay('Do you want to sell a Beholder Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'griffin shield') and focus == cid then
	item = 3371
	price = 1000
	selfSay('Do you want to sell a Griffin Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'guardian shield') and focus == cid then
	item = 3353
	price = 1250
	selfSay('Do you want to sell a Guardian Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon shield') and focus == cid then
	item = 3354
	price = 2000
	selfSay('Do you want to sell a Dragon Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'tower shield') and focus == cid then
	item = 3366
	price = 3000
	selfSay('Do you want to sell a Tower Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crown shield') and focus == cid then
	item = 3357
	price = 3500
	selfSay('Do you want to sell a Crown Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'amazon shield') and focus == cid then
	item = 3375
	price = 5000
	selfSay('Do you want to sell a Amazon Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'medusa shield') and focus == cid then
	item = 3374
	price = 5000
	selfSay('Do you want to sell a Medusa Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'shield of honour') and focus == cid then
	item = 3355
	price = 6000
	selfSay('Do you want to sell a Shield of Honour for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'vampire shield') and focus == cid then
	item = 3372
	price = 10000
	selfSay('Do you want to sell a Vampire Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'phoenix shield') and focus == cid then
	item = 3377
	price = 11500
	selfSay('Do you want to sell a Phoenix Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'demon shield') and focus == cid then
	item = 3358
	price = 20000
	selfSay('Do you want to sell a Demon Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'mastermind shield') and focus == cid then
	item = 3352
	price = 75000
	selfSay('Do you want to sell a Mastermind Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'great shield') and focus == cid then
	item = 3360
	price = 150000
	selfSay('Do you want to sell a Great Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'blessed shield') and focus == cid then
	item = 3361
	price = 250000
	selfSay('Do you want to sell a Blessed Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'legs list') and focus == cid then
		selfSay('I buy Bast Skirt, Leather Legs, Studded Legs, Chain Legs, Brass Legs, Plate Legs, Knight Legs, Crown Legs, Demon Legs, Dragon Scale Legs.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'bast skirt') and focus == cid then
	item = 3498
	price = 250
	selfSay('Do you want to sell a Bast Skirt for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'leather legs') and focus == cid then
	item = 3497
	price = 7
	selfSay('Do you want to sell a Leather Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'studded legs') and focus == cid then
	item = 3300
	price = 50
	selfSay('Do you want to sell a Studded Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'chain legs') and focus == cid then
	item = 3496
	price = 40
	selfSay('Do you want to sell a Chain Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'brass legs') and focus == cid then
	item = 3310
	price = 100
	selfSay('Do you want to sell a Brass Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'plate legs') and focus == cid then
	item = 3495
	price = 500
	selfSay('Do you want to sell a Plate Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'knight legs') and focus == cid then
	item = 3309
	price = 5000
	selfSay('Do you want to sell a Knight Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crown legs') and focus == cid then
	item = 3320
	price = 12500
	selfSay('Do you want to sell a Crown Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden legs') and focus == cid then
	item = 3302
	price = 75000
	selfSay('Do you want to sell a Golden Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'demon legs') and focus == cid then
	item = 3327
	price = 200000
	selfSay('Do you want to sell a Demon Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon scale legs') and focus == cid then
	item = 3301
	price = 400000
	selfSay('Do you want to sell a Dragon Scale Legs for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'helmets list') and focus == cid then
		selfSay('I buy Mystic Turban, Posts Officers Hat, Magician Hat, Leather Helmet, Tribal Mask, Feather Headdress, Chain Helmet, Studded Helmet, Brass Helmet, Viking Helmet, Legion Helmet, Steel Helmet, Horseman Helmet, Dark Helmet, Strange Helmet, Lady Helmet, Crown Helmet, Devil Helmet, Warrior Helmet, Crusader Helmet, Helmet of the Ancients, Royal Helmet, Demon Helmet, Winged Helmet, Horned Helmet, Full Helmet of the Ancients and Golden Helmet.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'mystic turban') and focus == cid then
	item = 3512
	price = 500
	selfSay('Do you want to sell a Mystic Turban for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'post officers hat') and focus == cid then
	item = 3514
	price = 1000
	selfSay('Do you want to sell a Post officers hat for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'magician hat') and focus == cid then
	item = 3511
	price = 500
	selfSay('Do you want to sell a Magician Hat for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'leather helmet') and focus == cid then
	item = 3293
	price = 2
	selfSay('Do you want to sell a Leather Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'tribal mask') and focus == cid then
	item = 3341
	price = 1500
	selfSay('Do you want to sell a Tribal Mask for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'feather headdress') and focus == cid then
	item = 3344
	price = 1500
	selfSay('Do you want to sell a Feather Headdress for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'chain helmet') and focus == cid then
	item = 3290
	price = 12
	selfSay('Do you want to sell a Chain Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'studded helmet') and focus == cid then
	item = 3314
	price = 20
	selfSay('Do you want to sell a Studded Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'brass helmet') and focus == cid then
	item = 3292
	price = 22
	selfSay('Do you want to sell a Brass Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'viking helmet') and focus == cid then
	item = 3305
	price = 30
	selfSay('Do you want to sell a Viking Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'legion helmet') and focus == cid then
	item = 3312
	price = 50
	selfSay('Do you want to sell a Legion Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'steel helmet') and focus == cid then
	item = 3289
	price = 100
	selfSay('Do you want to sell a Steel Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'horseman helmet') and focus == cid then
	item = 3343
	price = 500
	selfSay('Do you want to sell a Horseman Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dark helmet') and focus == cid then
	item = 3322
	price = 100
	selfSay('Do you want to sell a Dark Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'strange helmet') and focus == cid then
	item = 3311
	price = 150
	selfSay('Do you want to sell a Strange Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'lady helmet') and focus == cid then
	item = 3331
	price = 2000
	selfSay('Do you want to sell a Lady Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crown helmet') and focus == cid then
	item = 3323
	price = 1500
	selfSay('Do you want to sell a Crown Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'devil helmet') and focus == cid then
	item = 3294
	price = 1000
	selfSay('Do you want to sell a Devil Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'warrior helmet') and focus == cid then
	item = 3307
	price = 3000
	selfSay('Do you want to sell a Warrior Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crusader helmet') and focus == cid then
	item = 3329
	price = 5000
	selfSay('Do you want to sell a Crusader Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'helmet of the ancients') and focus == cid then
	item = 3333
	price = 25000
	selfSay('Do you want to sell a Helmet of the Ancients for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'royal helmet') and focus == cid then
	item = 3330
	price = 40000
	selfSay('Do you want to sell a Royal Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'demon helmet') and focus == cid then
	item = 3325
	price = 150000
	selfSay('Do you want to sell a Demon Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'winged helmet') and focus == cid then
	item = 3306
	price = 175000
	selfSay('Do you want to sell a Winged Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'horned helmet') and focus == cid then
	item = 3328
	price = 225000
	selfSay('Do you want to sell a Horned Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'full helmet of the ancients') and focus == cid then
	item = 3168
	price = 300000
	selfSay('Do you want to sell a Full Helmet of the Ancients for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden helmet') and focus == cid then
	item = 3303
	price = 500000
	selfSay('Do you want to sell a Golden Helmet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end


 	if msgcontains(msg, 'boots list') and focus == cid then
		selfSay('I buy Boots of Haste, Soft Boots, Sandals, Leather Boots, Crocodile Boots, Steel Boots, Golden Boots.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'boots of haste') and focus == cid then
	item = 3017
	price = 20000
	selfSay('Do you want to sell a Boots of Haste for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'soft boots') and focus == cid then
	item = 3184
	price = 30000
	selfSay('Do you want to sell a Soft Boots for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'sandals') and focus == cid then
	item = 3489
	price = 200
	selfSay('Do you want to sell a Sandals for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'leather boots') and focus == cid then
	item = 3490
	price = 5
	selfSay('Do you want to sell a Leather Boots for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crocodile boots') and focus == cid then
	item = 3494
	price = 1000
	selfSay('Do you want to sell a Crocodile Boots for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'steel boots') and focus == cid then
	item = 3492
	price = 50000
	selfSay('Do you want to sell a Steel Boots for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden boots') and focus == cid then
	item = 3493
	price = 1000000
	selfSay('Do you want to sell a Golden Boots for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'amulets list') and focus == cid then
		selfSay('I buy Bronze Amulet, Crystal Necklace, Dragon Necklace, Elven Amulet, Garlic Necklace, Golden Amulet, Platinum Amulet, Ruby Necklace, Protection Amulet, Silver Amulet, Silver Necklace, Stone Skin Amulet, Strange Symbol, Strange Talisman, Scarab Amulet, Demonbones Amulet and Leaf with Golden items.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'bronze amulet') and focus == cid then
	item = 2994
	price = 100
	selfSay('Do you want to sell a Bronze Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crystal necklace') and focus == cid then
	item = 2946
	price = 150
	selfSay('Do you want to sell a Crystal Necklace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dragon necklace') and focus == cid then
	item = 3023
	price = 250
	selfSay('Do you want to sell a Dragon Necklace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'elven amulet') and focus == cid then
	item = 2952
	price = 500
	selfSay('Do you want to sell a Elven Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'garlic necklace') and focus == cid then
	item = 3021
	price = 250
	selfSay('Do you want to sell a Garlic Necklace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'golden amulet') and focus == cid then
	item = 2951
	price = 3500
	selfSay('Do you want to sell a Golden Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'platinum amulet') and focus == cid then
	item = 2993
	price = 2500
	selfSay('Do you want to sell a Platinum Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ruby necklace') and focus == cid then
	item = 2954
	price = 1000
	selfSay('Do you want to sell a Ruby Necklace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'protection amulet') and focus == cid then
	item = 3022
	price = 350
	selfSay('Do you want to sell a Protection Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'silver amulet') and focus == cid then
	item = 2953
	price = 50
	selfSay('Do you want to sell a Silver Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'silver necklace') and focus == cid then
	item = 2992
	price = 250
	selfSay('Do you want to sell a Silver Necklace for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'stone skin amulet') and focus == cid then
	item = 3019
	price = 1500
	selfSay('Do you want to sell a Stone Skin Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'strange symbol') and focus == cid then
	item = 2996
	price = 500
	selfSay('Do you want to sell a Strange Symbol for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'strange talisman') and focus == cid then
	item = 3144
	price = 400
	selfSay('Do you want to sell a Strange Talisman for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scarab amulet') and focus == cid then
	item = 2956
	price = 1000
	selfSay('Do you want to sell a Scarab Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'demonbones amulet') and focus == cid then
	item = 2957
	price = 5000
	selfSay('Do you want to sell a Demonbones Amulet for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'leaf with golden items') and focus == cid then
	item = 2958
	price = 200
	selfSay('Do you want to sell a Leaf with golden items for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'rings list') and focus == cid then
		selfSay('I buy Axe Ring, Club Ring, Sword Ring, Crystal Ring, Dwarven Ring, Energy Ring, Gold Ring, Life Ring, Might Ring, Power Ring, Ring of Healing, Ring of the Skies, Stealth Ring, Time Ring and Wedding Ring.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'axe ring') and focus == cid then
	item = 3030
	price = 100
	selfSay('Do you want to sell a Axe Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'club ring') and focus == cid then
	item = 3031
	price = 100
	selfSay('Do you want to sell a Club Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'sword ring') and focus == cid then
	item = 3029
	price = 100
	selfSay('Do you want to sell a Sword Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'crystal ring') and focus == cid then
	item = 2945
	price = 500
	selfSay('Do you want to sell a Crystal Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'dwarven ring') and focus == cid then
	item = 3035
	price = 25
	selfSay('Do you want to sell a Dwarven Shield for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'energy ring') and focus == cid then
	item = 2989
	price = 400
	selfSay('Do you want to sell a Energy Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'gold ring') and focus == cid then
	item = 3001
	price = 4000
	selfSay('Do you want to sell a Gold Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'life ring') and focus == cid then
	item = 3027
	price = 400
	selfSay('Do you want to sell a Life Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'might ring') and focus == cid then
	item = 2986
	price = 400
	selfSay('Do you want to sell a Might Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'power ring') and focus == cid then
	item = 2988
	price = 50
	selfSay('Do you want to sell a Power Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ring of healing') and focus == cid then
	item = 3036
	price = 400
	selfSay('Do you want to sell a Ring of Healing for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'ring of the skies') and focus == cid then
	item = 3183
	price = 25000
	selfSay('Do you want to sell a Ring of the Skies for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'stealth ring') and focus == cid then
	item = 2987
	price = 400
	selfSay('Do you want to sell a Stealth Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'time ring') and focus == cid then
	item = 2991
	price = 1000
	selfSay('Do you want to sell a Time Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'wedding ring') and focus == cid then
	item = 2942
	price = 500
	selfSay('Do you want to sell a Wedding Ring for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'pearls list') and focus == cid then
		selfSay('I buy Scarab Coin, Blue Gem, Big Ruby, Big Emerald, Yellow Gem, Violet Gem, Talon, Small Amethyst, Small Emerald, Small Ruby, Small Sapphire, Small Diamond, Black Pearl and White Pearl.')
 		talk_start = os.clock()
 	end

 	if msgcontains(msg, 'scarab coin') and focus == cid then
	item = 2980
	price = 50
	selfSay('Do you want to sell a Scarab Coin for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'blue gem') and focus == cid then
	item = 2979
	price = 250
	selfSay('Do you want to sell a Blue Gem for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'big ruby') and focus == cid then
	item = 2977
	price = 500
	selfSay('Do you want to sell a Big Ruby for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'big emerald') and focus == cid then
	item = 2976
	price = 500
	selfSay('Do you want to sell a Big Emerald for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'yellow gem') and focus == cid then
	item = 2975
	price = 150
	selfSay('Do you want to sell a Yellow Gem for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'violet gem') and focus == cid then
	item = 2974
	price = 150
	selfSay('Do you want to sell a Violet Gem for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'talon') and focus == cid then
	item = 2972
	price = 100
	selfSay('Do you want to sell a Talon for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'small amethyst') and focus == cid then
	item = 2971
	price = 25
	selfSay('Do you want to sell a Small Amethyst for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'small emerald') and focus == cid then
	item = 2970
	price = 50
	selfSay('Do you want to sell a Small Emerald for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'small ruby') and focus == cid then
	item = 2968
	price = 75
	selfSay('Do you want to sell a Small Ruby for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'small sapphire') and focus == cid then
	item = 2967
	price = 50
	selfSay('Do you want to sell a Small Sapphire for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'small diamond') and focus == cid then
	item = 2966
	price = 100
	selfSay('Do you want to sell a Small Diamond for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'black pearl') and focus == cid then
	item = 2965
	price = 250
	selfSay('Do you want to sell a Black Pearl for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end

 	if msgcontains(msg, 'white pearl') and focus == cid then
	item = 2964
	price = 150
	selfSay('Do you want to sell a White Pearl for ' ..price.. ' Gold Coins?')
 	talk_start = os.clock()
 	end
 
 	if string.find(msg, '(%a*)bye(%a*)') and focus == cid and getDistanceToCreature(cid) < 3 then
 		selfSay('Good bye and enjoy with the money that you received.')
 		focus = 0
 		talk_start = 0
 	end

	if string.find(msg, '(%a*)yes(%a*)') and focus == cid then
	sell(cid,item,1,price)
	talk_star = os.clock()

	elseif string.find(msg, '(%a*)no(%a*)') and focus == cid then
	selfSay('HUH!? Leave me alone.')
	focus = 0
	talk_star = 0

 	end

 end
 
 
 function onCreatureChangeOutfit(creature)
 
 end
 
 
 function onThink()
 	if (os.clock() - talk_start) > 30 then
 		if focus > 0 then
 			selfSay('Next now!!')
 		end
 			focus = 0
 	end
 end
 
