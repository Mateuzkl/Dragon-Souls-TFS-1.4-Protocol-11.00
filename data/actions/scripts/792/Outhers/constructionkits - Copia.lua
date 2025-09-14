function onUse(cid, item, frompos, item2, topos)
	if frompos.x == 65535 then
		doPlayerSendCancel(cid, "Put the construction kit on the ground first.")
		return 1
	end
	doSendMagicEffect(topos,2)
	if item.itemid == 3901 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3902 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3903 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3904 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3905 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3906 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3908 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3909 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3910 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3911 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3912 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3913 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3914 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3917 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3918 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3919 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3926 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3927 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3928 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3929 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3931 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3932 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3933 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3935 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3937 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3907 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3915 then
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3920 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3921 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3923 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3934 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3936 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	elseif item.itemid == 3938 then
		doPlayerSay(cid,"Nops...",16)
		doTransformItem(item.uid,2148)
	else
		return 0
	end
	return 1
end
