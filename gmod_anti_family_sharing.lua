local cvar = CreateConVar('allow_family_sharing', '0', FCVAR_ARCHIVE, ' - Allows connecting players with family shared Garry\'s Mod copy.', 0, 1 )
hook.Add('PlayerInitialSpawn', 'Simple Anti-Family Sharing', function( ply )
    if ply:IsBot() or ply:IsListenServerHost() then return end
    if cvar:GetBool() then
        if (ply:OwnerSteamID64() ~= ply:SteamID64()) then return end
        ply:Kick( 'Family sharing restricted!' )
    end
end)
