function onCastSpell(creature, variant)
    Game.sendAnimatedText("Light!", creature:getPosition(), TEXTCOLOR_LIGHTBLUE)
    creature:getPosition():sendMagicEffect(12)
    creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return creature:setLight(1000, 1000, 1000*1000+1000*1000)
end
