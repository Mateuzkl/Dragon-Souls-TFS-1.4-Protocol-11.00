function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local twentyfour = false
    local tibiantime = true
    
    local time
    if not tibiantime then
        if twentyfour then
            time = os.date('%H:%M')
        else
            time = os.date('%I:%M %p')
        end
    else
        time = rl2tib(os.date('%M'), os.date('%S'), twentyfour)
    end
    
    player:sendTextMessage(MESSAGE_INFO_DESCR, "The time is " .. time .. ".")
    return true
end

function rl2tib(min, sec, twentyfour)
    local suffix = ''
    local varh = (min * 60 + sec) / 150
    local tibH = math.floor(varh)
    local tibM = math.floor(60 * (varh - tibH))
    
    if not twentyfour then
        if tonumber(tibH) > 11 then
            tibH = tonumber(tibH) - 12
            suffix = ' pm'
        else
            suffix = ' am'
        end
        if tibH == 0 then
            tibH = 12
        end
    end
    
    if tibH < 10 then
        tibH = '0' .. tibH
    end
    if tibM < 10 then
        tibM = '0' .. tibM
    end
    
    return tibH .. ':' .. tibM .. suffix
end
