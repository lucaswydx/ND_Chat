NDCore = exports["ND_Core"]:GetCoreObject()
NDCore.Functions.VersionChecker("ND_Chat", GetCurrentResourceName(), "https://github.com/Andyyy7666/ND_Framework", "https://raw.githubusercontent.com/Andyyy7666/ND_Framework/main/ND_Chat/fxmanifest.lua")

if config["/me"] then
    RegisterCommand("me", function(source, args, rawCommand, text)
        local player = source
        local players = NDCore.Functions.GetPlayers()
        local playerCoords = GetEntityCoords(GetPlayerPed(player))
        for serverPlayer, _ in pairs(players) do
            local targetCoords = GetEntityCoords(GetPlayerPed(serverPlayer))
            if (#(playerCoords - targetCoords) < 20.0) then
                TriggerClientEvent("chat:addMessage", serverPlayer, {
                    color = {255, 0, 0},
                    args = {"^*^3[ME] " .. players[player].firstName .. " " .. players[player].lastName .. " [" .. players[player].job .. "] (#" .. player .. ")", table.concat(args, " ")}
                })
            end
        end
    end, false)
end

if config['/gme'] then
    RegisterCommand('gme', function(source, args)
        local player = source
        local source = source
        local character = NDCore.Functions.GetPlayer(source)

        TriggerClientEvent('chat:addMessage', -1, { args = {"^*^6[GME] " .. character.firstName .. " " .. character.lastName .. " [" .. character.job .. "] (#" .. player .. ")", table.concat(args, " ")}})
    end, false)
end

if config['/twt'] then
    RegisterCommand('twt', function(source, args)
        local player = source
        local source = source
        local character = NDCore.Functions.GetPlayer(source)

        TriggerClientEvent('chat:addMessage', -1, { args = {"^*^4[Twitter] @" .. character.data.twtName .. " (#" .. player .. ")", table.concat(args, " ")}})
    end, false)
end

if config['/ooc'] then
    RegisterCommand('ooc', function(source, args)
        local player = source
        local source = source
        local character = NDCore.Functions.GetPlayer(source)

        TriggerClientEvent('chat:addMessage', -1, { args = {"^*^2[OOC] " .. GetPlayerName(source) .. " [" .. character.job .. "] (#" .. player .. ")", table.concat(args, " ")}})
    end, false)

function hasDarkWebPermission(player, players, args)
    for _, department in pairs(config["/darkweb"].canNotSee) do
        if players[player].job == department then 
            TriggerClientEvent("chat:addMessage", player, {
                color = {255, 0, 0},
                args = {"^*^5[System]", players[player].job .. " cannot access this command."}
            })
            return false
        end
    end
    for serverPlayer, playerInfo in pairs(players) do
        for _, department in pairs(config["/darkweb"].canNotSee) do
            if playerInfo.job == department then
                return false
            end
        end
        TriggerClientEvent("chat:addMessage", serverPlayer, {
            color = {0, 0, 0},
            args = {"^8^*[Dark Web] @Anonymous", table.concat(args, " ")}
        })
    end
end

if config["/darkweb"].enabled then
    RegisterCommand("darkweb", function(source, args, rawCommand)
        local player = source
        local players = NDCore.Functions.GetPlayers()
        hasDarkWebPermission(player, players, args)
    end, false)
end

if config["/911"].enabled then
    RegisterCommand("911", function(source, args, rawCommand)
        local player = source
        TriggerClientEvent("ND_Chat:911", -1, GetEntityCoords(GetPlayerPed(player)), table.concat(args, " "))
    end, false)
end
end