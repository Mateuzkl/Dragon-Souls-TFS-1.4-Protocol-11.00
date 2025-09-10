focus1 = 0
focus2 = 0
talk_start = 0
target = 0 
following = false 
attacking = false 
talkstate = 0
moved=0
function onThingMove(creature, thing, oldpos, oldstackpos)
end
function onCreatureAppear(creature)
end
function onCreatureDisappear(id, stackpos)
if id == focus1 or id == focus1 then
ceremonyend('Goodbye, then.')
end
end
function onCreatureTurn(creature)
end
function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end
function ceremonyend(msg)
focus1 = 0
focus2 = 0
talk_start = 0
talkstate = 0
selfSay(msg)
end
function onCreatureSay(cid, type, msg)
msg = string.lower(msg)
if talkstate == 1 then
if cid == focus2 then
if msgcontains(msg, 'sim') then
talkstate=2
selfSay('' .. creatureGetName(focus1) .. ' devo comecar a cerimonia?')
else
ceremonyend('Volte quando voce estiver preparado.')
end
end
end
if talkstate == 2 then
if cid == focus1 then
if msgcontains(msg, 'sim') then
talkstate=3
else
ceremonyend('Volte quando voce estiver preparado.')
end
end
end
if talkstate == 9 then
if cid == focus1 then
if string.find(msg, '(%a*)sim(%a*)') then
talkstate=10
else
ceremonyend('Volte quando voce estiver preparado.')
end
end
end
if talkstate == 11 then
if cid == focus2 then
if string.find(msg, '(%a*)sim(%a*)') then
talkstate=12
else
ceremonyend('Volte quando voce estiver preparado.')
end
end
end
if msgcontains(msg, 'oi') and focus1 > 0 and focus2 == 0 and not(cid==focus1) and getDistanceToCreature(cid) < 3 then
if isMarried(cid) == "poo" then

selfSay('Ola, ' .. creatureGetName(cid) .. '! Grande dia nao? Bem, vamos comecar?')
focus2 = cid
talk_start = os.clock()
talkstate=1

else


selfSay('Voce ja esta casado(a).')
end
end

if msgcontains(msg, 'oi') and focus1 == 0 and getDistanceToCreature(cid) < 3 then
if isMarried(cid) == "poo" then

selfSay('Oi, ' .. creatureGetName(cid) .. '! Eu sou o padre do Dragon Souls Otserv. E posso unir voces com seu grande amor.')
focus1 = cid
talk_start = os.clock()

else


selfSay('Voce ja esta casado(a).')
end
end
if string.find(msg, '(%a*)tchau(%a*)') and (focus1 == cid or focus2 == cid) and getDistanceToCreature(cid) < 6 then
ceremonyend('Va com deus, ' .. creatureGetName(cid) .. '!')
end
end
function onCreatureChangeOutfit(creature)
end
function onThink() 
if talkstate==3 and (os.clock() - talk_start) > 10 then
selfSay('Duas vidas, duas pessoas, dois seres vivos tao diferentes, mas tao iguais ao mesmo tempo.');
talk_start = os.clock()
talkstate=4
end
if talkstate==4 and (os.clock() - talk_start) > 6 then
selfSay('Juntos eles formao soh um, para celebrar o futuro nao importando qual for.');
talk_start = os.clock()
talkstate=5
end
if talkstate==5 and (os.clock() - talk_start) > 6 then
selfSay('O passado eh passado. Agora o que importa eh o futuro desse lindo casal.');
talk_start = os.clock()
talkstate=6
end
if talkstate==6 and (os.clock() - talk_start) > 8 then
selfSay('Honestidade e amor, essas sao as caracteristicas de um bom casamento.');
talk_start = os.clock()
talkstate=7
end
if talkstate==7 and (os.clock() - talk_start) > 6 then
selfSay('Que as almas de todos os dragoes os abencoe esse dia tao especial.');
talk_start = os.clock()
talkstate=8
end
if talkstate==8 and (os.clock() - talk_start) > 6 then
selfSay(creatureGetName(focus1) .. ' voce aceita ' .. creatureGetName(focus2) .. ' para sempre....na alegria...na tristesa...na riquesa...ou na pobresa...na saude ou na doenca...para viver...confiar...e acima de tudo amar?');
talk_start = os.clock()
talkstate=9
end
if talkstate==10 and (os.clock() - talk_start) > 6 then
selfSay(creatureGetName(focus2) .. ' voce aceita ' .. creatureGetName(focus1) .. ' para sempre....na alegria...na tristesa...na riquesa...ou na pobresa...na saude ou na doenca...para viver...confiar...e acima de tudo amar?');
talk_start = os.clock()
talkstate=11
end
if talkstate==12 and (os.clock() - talk_start) > 6 then
pla1 = creatureGetName(focus1)
pla2 = creatureGetName(focus2)
getMarried(focus2,pla1)
getMarried(focus1,pla2)
ceremonyend('Pelos poderes em mim investidos eu vos declaro marido e mulher. Boa sorte.');
talk_start = os.clock()
end
if (os.clock() - talk_start) > 100 then
if focus1 > 0 or focus2 > 0 then
ceremonyend('Goodbye, then.')
end
end
--if moved==0 then
--x, y, z = selfGetPosition()
--moveToPosition(x+1, y, z)
--moved=1
--end
end