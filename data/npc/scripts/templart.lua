focus = 0
talk_start = 0
target = 0
following = false
attacking = false
talk_state = 0
cname = ''

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)

end


function onCreatureDisappear(cid, pos)
  if focus == cid then
         selfSay('Good bye then.')
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
  cname = creatureGetName(cid)
msg = string.lower(msg)

  if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
   selfSay('Hello ' .. cname .. '! Are you ready to live with us on TOMBSTONE?')
   talk_state = 0
   focus = cid
   selfLook(cid)
   talk_start = os.clock()

elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
   selfSay('Sorry, ' .. cname .. '! I talk to you in a minute.')

  elseif msgcontains(msg, 'bye') and focus == cid and getDistanceToCreature(cid) < 4 then
  selfSay('Good bye, ' .. cname .. '!')
  talk_state = 0
  focus = 0
  talk_start = 0   elseif focus == cid then
 talk_start = os.clock()    if talk_state == 0 then
  if msgcontains(msg, 'yes') then  -- wanna change temple to tombstone
     
    selfSay('Great! I change your temple to live here. Is that what do you want?')
    talk_state = 3
   end

  elseif talk_state == 3 then  -- telling city name
   if msgcontains(msg, 'yes') then
    selfSay('congratulations, You Have Been Blessed and Now You Are a Citizen of Tombstone.')
    setPlayerMasterPos(cid,160,54,7)
    selfSay('/send ' .. cname .. ', 160 54 7')

    talk_state = 0
    focus = 0
    talk_start = 0
   else
    selfSay('Sorry, thats inst the answer. Do you want to live on TOMBSTONE with us ?')
    talk_state = 3
   end
   end
  end
end


function onCreatureChangeOutfit(creature)

end


function onThink()
  if (os.clock() - talk_start) > 45 then
   if focus > 0 then
    selfSay('Next Please...')
   end
    focus = 0
  end
 if focus ~= 0 then
  if getDistanceToCreature(focus) > 5 then
   selfSay('Good bye then.')
   focus = 0
  end
 end
end