local SysTime = SysTime

local connectTimes = {}
hook.Add('CheckPassword', 'Antispam for connecting', function( sid64 )
    if (connectTimes[ sid64 ] ~= nil) and (connectTimes[ sid64 ] > SysTime()) then
        return false, 'Too fast. Please be slowly :)'
    end

    connectTimes[ sid64 ] = SysTime() + 3
end)
