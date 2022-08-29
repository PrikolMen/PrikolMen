local folder = "/"
local function addFile( path, client, server )
	local fullPath = folder .. path .. ".lua"
	if (SERVER) then
		if (client) then
			AddCSLuaFile( fullPath )
		end

		if (server) then
			include( fullPath )
		end
	elseif (client) then
		include( fullPath )
	end
end
