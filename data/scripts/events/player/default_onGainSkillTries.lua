local event = Event()
event.onGainSkillTries = function(self, skill, tries)
    if APPLY_SKILL_MULTIPLIER == false then
        return tries
    end

    local multiplier
    if skill == SKILL_MAGLEVEL then
        multiplier = Game.getMagicLevelStage(self:getMagicLevel())
    else
        multiplier = Game.getSkillStage(self:getSkillLevel(skill))
    end
    
    return tries * multiplier
end
event:register(1)