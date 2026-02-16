ITEM_ATTRIBUTE_DESCRIPTION = 1
ITEM_ATTRIBUTE_EXTRADEFENSE = 2
ITEM_ATTRIBUTE_DEFENSE = 3
ITEM_ATTRIBUTE_ARMOR = 4
ITEM_ATTRIBUTE_HITCHANCE = 5
ITEM_ATTRIBUTE_SHOOTRANGE = 6
ITEM_ATTRIBUTE_ARTICLE = 7
ITEM_ATTRIBUTE_DURATION = 8
ITEM_ATTRIBUTE_DECAYTO = 9
ITEM_ATTRIBUTE_CHARGES = 10
ITEM_ATTRIBUTE_UNIQUEID = 11
ITEM_ATTRIBUTE_ACTIONID = 12
ITEM_ATTRIBUTE_NAME = 13
ITEM_ATTRIBUTE_TEXT = 14
ITEM_ATTRIBUTE_DATE = 15
ITEM_ATTRIBUTE_WRITER = 16
ITEM_ATTRIBUTE_IMBUINGSLOTS = 24   -- Check this value, might be different
ITEM_ATTRIBUTE_TIER = 32           -- Explicit guess based on recent TFS
ITEM_ATTRIBUTE_CLASSIFICATION = 33 -- Explicit guess

-- Helper function to safely get attribute if global is missing
function Item.safelyGetAttribute(self, key)
    if self:hasAttribute(key) then
        return self:getAttribute(key)
    end
    return nil
end
