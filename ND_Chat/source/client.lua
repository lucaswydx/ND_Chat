NDCore = exports["ND_Core"]:GetCoreObject()

if config["/me"] then
    TriggerEvent("chat:addSuggestion", "/me", "Send message in the third person (Proximity).", {{ name="Action", help="Describe your action."}})
end

if config["/do"] then
    TriggerEvent("chat:addSuggestion", "/do", "Send message in the third person (Proximity).", {{ name="Action", help="Describe your action."}})
end

if config["/gme"] then
    TriggerEvent("chat:addSuggestion", "/gme", "Send message in the third person (Global).", {{ name="Action", help="Describe your action."}})
end

if config["/twt"] then
    TriggerEvent("chat:addSuggestion", "/twt", "Send a Twotter in game. (Global)", {{name="Message", help="Twotter Message."}})
end

if config["/darkweb"] then
    TriggerEvent("chat:addSuggestion", "/darkweb", "Send a anonymous message in game (Global).", {
        {
            name = "Message",
            help = ""
        }
    })
end

if config["/radiochat"] then
    TriggerEvent("chat:addSuggestion", "/radiochat", "Send a Less important Radio Transmission", {{name="Transmission", help="Enter your transmission"}})
end

if config["/911"] then
    TriggerEvent("chat:addSuggestion", "/911", "Call 911 for your emergency.", {
        {
            name = "Report",
            help = "Enter your report here."
        }
    })
end

if config["/311"] then
    TriggerEvent("chat:addSuggestion", "/311", "Call 311 for your emergency.", {
        {
            name = "Report",
            help = "Enter your report here."
        }
    })
end


if config["/911"].enabled then
    RegisterNetEvent("ND_Chat:911", function(coords, Description)
        local character = NDCore.Functions.GetSelectedCharacter()
        if not character then
            return
        end
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0},
            multiline = true,
            args = {"^1^*[911]: ^3The Emergency Services are on their way."}
        })
        for _, department in pairs(config["/911"].callTo) do
            if character.job == department then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                TriggerEvent("chat:addMessage", {
                    color = {255, 0, 0},
                    args = {"^1^*[911]: ^3Location: ^7" .. location .. " ^3| Information: ^7" .. Description}
                })
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(blip, 189)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                SetBlipColour(blip, 59)
                AddTextComponentString("Active 911 Call: " .. location)
                EndTextCommandSetBlipName(blip)
                CreateThread(function()
                    Wait(2000)
                    AddTextEntry('ND_911', 'Press ~r~[K]~w~ to set a waypoint.')
                    SetNotificationTextEntry('ND_911')
                    SetNotificationMessage('CHAR_CALL911', 'CHAR_CALL911', true, 4, '~r~New 911 Call~r~', '~y~Check the chat for details.', character.firstName .. " " .. character.lastName, coords.x, coords.y, coords.z)
                    DrawNotification(false, true)
                    while true do
                        Wait(0)
                        if IsControlPressed(0, 311) then
                            SetNewWaypoint(coords.x, coords.y)
                            break
                        end
                    end
                end)
                Wait(60 * 1000)
                RemoveBlip(blip)
                break
            end
        end
    end)
end            

if config["/311"].enabled then
    RegisterNetEvent("ND_Chat:311", function(coords, Description)
        local character = NDCore.Functions.GetSelectedCharacter()
        if not character then
            return
        end
        TriggerEvent("chat:addMessage", {
            color = { 255, 0, 0},
            multiline = true,
            args = {"^1^*[311]: ^3The Emergency Services are on their way."}
        })
        for _, department in pairs(config["/311"].callTo) do
            if character.job == department then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                TriggerEvent("chat:addMessage", {
                    color = {255, 0, 0},
                    args = {"^1^*[311]: ^3Location: ^7" .. location .. " ^3| Information: ^7" .. Description}
                })
                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                SetBlipSprite(blip, 189)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                SetBlipColour(blip, 59)
                AddTextComponentString("Active 311 Call: " .. location)
                EndTextCommandSetBlipName(blip)
                CreateThread(function()
                    Wait(2000)
                    AddTextEntry('ND_311', 'Press ~r~[K]~w~ to set a waypoint.')
                    SetNotificationTextEntry('ND_311')
                    SetNotificationMessage('CHAR_CHAT_CALL', 'CHAR_CHAT_CALL', true, 4, '~r~New 311 Call~r~', '~y~Check the chat for details.', character.firstName .. " " .. character.lastName, coords.x, coords.y, coords.z)
                    DrawNotification(false, true)
                    while true do
                        Wait(0)
                        if IsControlPressed(0, 311) then
                            SetNewWaypoint(coords.x, coords.y)
                            break
                        end
                    end
                end)
                Wait(60 * 1000)
                RemoveBlip(blip)
                break
            end
        end
    end)
end            
