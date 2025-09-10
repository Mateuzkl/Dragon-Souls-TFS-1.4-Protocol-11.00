local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)                npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)             npcHandler:onCreatureDisappear(cid)            end
function onCreatureSay(cid, type, msg)            npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()                    npcHandler:onThink()                    end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

-- Statues --
shopModule:addBuyableItem({'knight statue'},		 	1442, 50,		'Knight Statue')
shopModule:addBuyableItem({'minotaur statue'},	 		1446, 50, 	 	'Minotaur Statue')
shopModule:addBuyableItem({'goblin statue'},		 	1447, 50,		'Goblin Statue')
-- Tables --
shopModule:addBuyableItem({'small table'},		 	3912, 15,		'Small Table')
shopModule:addBuyableItem({'small round table'},	 	3911, 15,		'Small Round Table')
shopModule:addBuyableItem({'stone table'},	 		3913, 20, 	 	'Stone Table')
shopModule:addBuyableItem({'square table'},		 	3910, 20,		'Square Table')
shopModule:addBuyableItem({'big table'},		 	3909, 25,		'Big Table')
shopModule:addBuyableItem({'tusk table'},		 	3914, 25,		'Tusk Table')
shopModule:addBuyableItem({'bamboo table'},		 	3919, 25,		'Bamboo Table')
-- Chairs --
shopModule:addBuyableItem({'wooden chair'},		 	3901, 25,		'Wooden Chair')
shopModule:addBuyableItem({'sofa chair'},		 	3902, 50,		'Sofa Chair')
shopModule:addBuyableItem({'red cushioned chair'}, 		3903, 40, 	 	'Red Cushioned Chair')
shopModule:addBuyableItem({'green cushioned chair'},	 	3904, 40,		'Green Cushioned Chair')
shopModule:addBuyableItem({'tusk chair'},		 	3905, 30,		'Tusk Chair')
shopModule:addBuyableItem({'ivory chair'},		 	3906, 30,		'Ivory Chair')
shopModule:addBuyableItem({'tree stump'},		 	3907, 15,		'Tree Stump')
-- other --
shopModule:addBuyableItem({'coal basin'},		 	3908, 40,		'Coal Basin')
shopModule:addBuyableItem({'harp'},			 	3917, 45,		'Harp')
shopModule:addBuyableItem({'bird cage'},		 	3918, 45,		'Bird Cage')
shopModule:addBuyableItem({'thick trunk'},		 	3920, 15,		'Thick Trunk')
shopModule:addBuyableItem({'drawers'},	 			3921, 40,		'Drawers')
shopModule:addBuyableItem({'barrel'},			 	3923, 15,		'Barrel')
shopModule:addBuyableItem({'piano'},			 	3926, 50,		'Piano')
shopModule:addBuyableItem({'globe'},		 		3927, 25,		'Globe')
shopModule:addBuyableItem({'potted flower'}, 			3928, 25,		'Potted Flower')
shopModule:addBuyableItem({'indoor plant'},		 	3929, 25,		'Indoor Plant')
shopModule:addBuyableItem({'christmas tree'},		 	3931, 35,		'Christmas Tree')
shopModule:addBuyableItem({'dresser'},		 		3932, 20,		'Dresser')
shopModule:addBuyableItem({'pendulum clock'},	 		3933, 45,		'Pendulum Clock')
shopModule:addBuyableItem({'locker'},		 		3934, 35,		'Locker')
shopModule:addBuyableItem({'trough'},		 		3935, 15,		'Trough')
shopModule:addBuyableItem({'bookcase'},		 		3936, 40,		'Bookcase')	
shopModule:addBuyableItem({'table lamp'},	 		3937, 25,		'Table Lamp')
shopModule:addBuyableItem({'large trunk'},		 	3938, 35,		'Large Trunk')	
-- Tapestries --
shopModule:addBuyableItem({'purple tapestry'},		 	1857, 25,		'Purple Tapestry')
shopModule:addBuyableItem({'green tapestry'},		 	1860, 25,		'Green Tapestry')
shopModule:addBuyableItem({'yellow tapestry'},		 	1863, 25,		'Yellow Tapestry')
shopModule:addBuyableItem({'orange tapestry'},		 	1866, 25,		'Orange Tapestry')
shopModule:addBuyableItem({'red tapestry'},		 	1869, 25,		'Red Tapestry')
shopModule:addBuyableItem({'blue tapestry'},		 	1872, 25,		'Blue Tapestry')
shopModule:addBuyableItem({'white tapestry'},		 	1880, 25,		'White Tapestry')

npcHandler:addModule(FocusModule:new())