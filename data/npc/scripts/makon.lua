local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    if not player then
        return false
    end
    
    if msgcontains(msg, 'kar') then
        selfSay('Oh, the Flame of Kar\'ce? Many people think this is a legend, but it\'s not...', cid)
        selfSay('Many years ago, this sword was forged on the hottest mountain in the world... (say continue)', cid)
        npcHandler.topic[cid] = 1
        
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == 1 then
        selfSay('Forged by a Legion of Devil minions, it has extremely strong bad vibrations!', cid)
        selfSay('If any mortal finds this sword, he will have to destroy it faster than the wind!', cid)
        selfSay('...or the sword will destroy his life!', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'thordain') then
        selfSay('Haha! This Blacksmith dwarf is really wise... He lives in a deep mine south of here.', cid)
        selfSay('Only a few humans have met him because the way to his place is inhabited by many mangy dwarves!', cid)
        
    elseif msgcontains(msg, 'leon') then
        selfSay('Hmm... This name is not strange... Oh! I remember this young man!', cid)
        selfSay('He was a treasure hunter! Really young by the way... One day he found a Map, he showed me...', cid)
        selfSay('I never saw a map like that before, I warned him that it was dangerous to follow an unknown map... (say continue)', cid)
        npcHandler.topic[cid] = 4
        
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == 4 then
        selfSay('But he was stubborn! He was obsessed by that map...', cid)
        selfSay('Now I can\'t tell you where he is because he left the town and never came back!', cid)
        selfSay('Poor young adventurer...', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'raccoon') then
        selfSay('Oh my loved town... Now turned into ruins! Did you know Raccoon\'s History?', cid)
        npcHandler.topic[cid] = 2
        
    elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 2 then
        selfSay('Ok then.', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 2 then
        selfSay('I expected...', cid)
        selfSay('Raccoon is one of the first towns built in this part of the world, it has been constructed by one great tribe...', cid)
        selfSay('Through all the years until now, it has faced many wars and monster raids... But this time there was no way of winning... (say continue)', cid)
        npcHandler.topic[cid] = 3
        
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == 3 then
        selfSay('A curse is cast above our city, the Devils that live under our feet built an army vast beyond imagination! Their servants are tormented souls of fallen warriors!', cid)
        selfSay('By far this is the most powerful army that we ever faced! I can\'t see a way to return our beloved city back...', cid)
        selfSay('May the Gods bless and give us strength to face these horrible times.', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'genesis') then
        selfSay('The genesis prophecy...', cid)
        selfSay('The legend says that the world will be taken by the Devil-God Har\'dur, a beast created by Belkor...', cid)
        selfSay('I guess it\'s not only a legend because Raccoon is suffering the 5th plague, the epidemic... (say continue)', cid)
        npcHandler.topic[cid] = 5
        
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == 5 then
        selfSay('The epidemic fell upon us because someone found the Blade that Shimmers in Light Blue!', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'har') then
        selfSay('Har\'dur is a Devil-God created by Belkor, one of the Supremes.', cid)
        selfSay('In contradiction to Amel and the other Supremes, Belkor created Har\'dur to be the God of Ambition.', cid)
        selfSay('Because of this creation and other bad things Belkor made, he was arrested in the Supreme Spirits Crystal... (say continue)', cid)
        npcHandler.topic[cid] = 6
        
    elseif msgcontains(msg, 'continue') and npcHandler.topic[cid] == 6 then
        selfSay('... After being arrested there, the Supremes cannot touch the Crystal again to free him...', cid)
        selfSay('A human can easily be killed by touching the Crystal, only a Semi-God can free him from his punishment.', cid)
        npcHandler.topic[cid] = 0
        
    elseif msgcontains(msg, 'spirits crystal') or msgcontains(msg, 'crystal') then
        selfSay('No one has ever found this crystal, praise be the Gods for that... The catastrophe that would happen if someone freed Belkor is unimaginable!', cid)
        
    elseif msgcontains(msg, 'semi') then
        selfSay('The God Anoriel, son of Amel itself, has the power to transform a mere mortal into a Semi-God, the Valans!', cid)
        
    elseif msgcontains(msg, 'valans') then
        selfSay('I never heard about any Valan yet... I think no human is good enough to be allowed to become a Semi-God, it\'s just a prophecy... I guess!', cid)
        
    elseif msgcontains(msg, 'prophecy') or msgcontains(msg, 'profecia') then
        selfSay('Ohh, the older prophecy... Well, a long history, when you enter the temple of Anoriel, you must have all rare tomes, the prophecy says when you put them in the right order on the altar, the stone of knowledge will disappear... But it\'s only a myth, I guess!', cid)
        
    elseif msgcontains(msg, 'tomes') then
        selfSay('Ohh, the rare tomes, there are five tomes, I\'ve seen two in my life, purple tome and red tome!', cid)
        
    elseif msgcontains(msg, 'job') then
        selfSay('I am an ancient monk of the Raccoon city!', cid)
        
    elseif msgcontains(msg, 'offer') then
        selfSay('Sorry young one, I can offer you nothing but history... and I have a lot of them haha!', cid)
        
    elseif msgcontains(msg, 'sell') then
        selfSay('Hehe! I ain\'t selling stuff.', cid)
        
    elseif msgcontains(msg, 'buy') then
        selfSay('Hehe! I ain\'t buying stuff.', cid)
        
    elseif msgcontains(msg, 'quest') then
        selfSay('Ha! This old man has no need for quests anymore.', cid)
        
    elseif msgcontains(msg, 'mission') then
        selfSay('Ha! This old man has no need for missions anymore.', cid)
        
    elseif msgcontains(msg, 'apocalypse') then
        selfSay('Sshh! Don\'t say this name near me!', cid)
        
    elseif msgcontains(msg, 'anoriel') then
        selfSay('Anoriel is the divine son of Amel, with power to elevate mortals to Semi-God status.', cid)
        
    elseif msgcontains(msg, 'belkor') then
        selfSay('Belkor was a Supreme who created evil beings and was imprisoned for his crimes.', cid)
        
    elseif msgcontains(msg, 'amel') then
        selfSay('Amel is one of the Supreme beings, father of the divine Anoriel.', cid)
    end
    
    return true
end

function onGreet(cid)
    local player = Player(cid)
    if player then
        selfSay('Greetings, ' .. player:getName() .. '! I am a keeper of ancient knowledge and stories. What would you like to hear about?', cid)
    end
    return true
end

function onFarewell(cid)
    local player = Player(cid)
    if player then
        selfSay('May the ancient wisdom guide your path, ' .. player:getName() .. '!', cid)
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:addModule(FocusModule:new())
