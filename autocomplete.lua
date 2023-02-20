-- const
local int32 = 2^32

-- func
local valueType = 0 -- type here
if (valueType == TYPE_STRING) then return end
if (valueType == TYPE_BOOL) then
    return { cmd .. ' ' .. 0, cmd .. ' ' .. 1, '' }
elseif (valueType == TYPE_NUMBER) then
    local number = tonumber( value ) or 0
    if (number >= int32) or (number <= -int32) then return end

    local tbl = {}
    for _, int in ipairs( basicNumbers ) do
        if (int == 0) and (number == int) then continue end
        tbl[ #tbl + 1 ] = cmd .. ' ' .. (number == 0 and '' or number) .. tostring( int )
    end

    return tbl
end
