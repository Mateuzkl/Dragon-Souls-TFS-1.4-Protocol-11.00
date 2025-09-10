-- NPC Clean (by ma123282)

stime = 120 -- Tempo entre as execuções do comando (em segundos).
time = os.clock()

function onThink()
if (time + stime) < os.clock() then
time = os.clock()
selfSay("/clean")
end
end