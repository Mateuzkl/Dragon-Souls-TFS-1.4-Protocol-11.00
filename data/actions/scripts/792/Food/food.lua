MAX_FOOD = 1200
function onUse(cid, item, frompos, item2, topos)
if item.itemid == 2666 then
food = 180
som = "Munch"
elseif item.itemid == 2667 then
food = 144
som = "Munch"
elseif item.itemid == 2668 then
food = 120
som = "Mmmm"
elseif item.itemid == 2669 then
food = 254
som = "Munch"
elseif item.itemid == 2670 then
food = 196
som = "Munch"
elseif item.itemid == 2671 then
food = 360
som = "Chomp"
elseif item.itemid == 2672 then
food = 720
som = "Chomp"
elseif item.itemid == 2673 then
food = 56
som = "Yum"
elseif item.itemid == 2674 then
food = 72
som = "Yum"
elseif item.itemid == 2675 then
food = 156
som = "Yum"
elseif item.itemid == 2676 then
food = 96
som = "Yum"
elseif item.itemid == 2677 then
food = 12
som = "Yum"
elseif item.itemid == 2678 then
food = 160
som = "Yum"
elseif item.itemid == 2679 then
food = 12
som = "Yum"
elseif item.itemid == 2680 then
food = 24
som = "Yum"
elseif item.itemid == 2681 then
food = 108
som = "Yum"
elseif item.itemid == 2682 then
food = 240
som = "Yum"
elseif item.itemid == 2683 then
food = 240
som = "Yum"
elseif item.itemid == 2684 then
food = 96
som = "Crunch"
elseif item.itemid == 2685 then
food = 46
som = "Yum"
elseif item.itemid == 2686 then
food = 108
som = "Crunch"
elseif item.itemid == 2687 then
food = 24
som = "Crunch"
elseif item.itemid == 2688 then
food = 126
som = "Mmmm"
elseif item.itemid == 2689 then
food = 120
som = "Crunch"
elseif item.itemid == 2690 then
food = 72
som = "Crunch"
elseif item.itemid == 2691 then
food = 96
som = "Crunch"
elseif item.itemid == 2695 then
food = 96
som = "Gulp"
elseif item.itemid == 2696 then
food = 108
som = "Smack"
elseif item.itemid == 2787 then
food = 72
som = "Crunch"
elseif item.itemid == 2788 then
food = 48
som = "Crunch"
elseif item.itemid == 2789 then
food = 264
som = "Crunch"
elseif item.itemid == 2790 then
food = 84
som = "Crunch"
elseif item.itemid == 2791 then
food = 84
som = "Crunch"
elseif item.itemid == 2792 then
food = 140
som = "Crunch."
elseif item.itemid == 2793 then
food = 126
som = "Crunch"
elseif item.itemid == 2794 then
food = 111
som = "Crunch"
elseif item.itemid == 2795 then
food = 136
som = "Crunch"
elseif item.itemid == 2796 then
food = 60
som = "Crunch"
elseif item.itemid == 5097 then
food = 48
som = "Yum"
elseif item.itemid == 5678 then
food = 96
som = "Gulp"
elseif item.itemid == 6501 then
food = 240
som = "Mmmm"
elseif item.itemid == 6278 then
food = 120
som = " Mmmm"
elseif item.itemid == 6279 then
food = 120
som = " Mmmm"
elseif item.itemid == 6280 then
food = 180
som = " Mmmm"
elseif item.itemid == 1378 then
food = 10000
som = " Glup"

else
return 0
end

vomit = math.random(1,3)
vomit2 = math.random(10,20)

if (getPlayerFood(cid) + food > MAX_FOOD) then
if getPlayerAccess(cid) > 0 then
doPlayerFeed(cid, food)
doRemoveItem(item.uid, 1)
doPlayerSay(cid, som..'.', 16)
return 1
else
if vomit == 2 then
doPlayerSendCancel(cid,"You are full.")
doSendMagicEffect(getPlayerPosition(cid),8)
doPlayerAddHealth(cid,-vomit2)
doPlayerSay(cid,'Huuuuuugo!', 16)
vom = doCreateItem(2025,4,getPlayerPosition(cid))
doSendAnimatedText(getPlayerPosition(cid),vomit2, TEXTCOLOR_LIGHTGREEN)
doRemoveItem(item.uid,1)
doSetItemSpecialDescription(vom,"It is vomit.")
doDecayItem(vom)
else
doPlayerSendCancel(cid,"You are full.")
end
return 1
end
end


doPlayerFeed(cid,food)
doRemoveItem(item.uid,1)
doPlayerSay(cid, som..'.', 16)
return 1
end

