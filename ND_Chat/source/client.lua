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

if config["/ooc"] then
    TriggerEvent("chat:addSuggestion", "/ooc", "Send a Out Of Character message (Global)", {{name="Message", help="OOC Message."}})
end

if config["/darkweb"] then
    TriggerEvent("chat:addSuggestion", "/darkweb", "Send a anonymous message in game (Global).", {{name="Message", help=""}})
end

if config["/radiochat"] then
    TriggerEvent("chat:addSuggestion", "/radiochat", "Send a Less important Radio Transmission", {{name="Transmission", help="Enter your transmission"}})
end

if config["/911"] then
    TriggerEvent("chat:addSuggestion", "/911", "Call 911 for your emergency.", {{name="Report", help="Enter your report here."}})
end

if config["/911"].enabled then
    RegisterNetEvent("ND_Chat:911")

    AddEventHandler("ND_Chat:911", function(coords, Description)
        local character = NDCore.Functions.GetSelectedCharacter()
        if not character then return end

        TriggerEvent("chat:addMessage", {
            color = {255, 0, 0},
            multiline = true,
            args = {"^1^*[911]: ^3The Emergency Services are on their way."}
        })

        for _, department in pairs(config["/911"].callTo) do
            if character.job == department then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                TriggerEvent('InteractSound_CL:PlayOnOne', '911call', 0.3)
                if GetResourceState("ModernHUD") == "started" then
                    exports["ModernHUD"]:AndyyyNotify({
                        title = '<font color="#ff0000">911 EMERGENCY</font>',
                        message = '<font color="#ff0000">Location:</font> ' .. location .. '<br><font color="#ff0000">Report:</font> ' .. Description,
                        icon = "fas fa-ambulance",
                        colorHex = "#ff0000",
                        timeout = 12000
                    })
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipSprite(blip, 189)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    SetBlipColour(blip, 59)
                    AddTextComponentString("Active 911 Call: " .. location)
                    EndTextCommandSetBlipName(blip)

                    Citizen.CreateThread(function()
                        Citizen.Wait(2000)
                        local playerPed = GetPlayerPed(-1)
                        local playerName = GetPlayerName(PlayerId())
                        local playerCoords = GetEntityCoords(playerPed)
                        exports["ModernHUD"]:AndyyyNotify({
                            title = '<font color="#ff0000">911 EMERGENCY</font>',
                            message = '<font color="#FFFFFF">Press <font color="#ff0000">[K]</font> to respond to call</font> ' .. Description,
                            icon = "fas fa-ambulance",
                            colorHex = "#ff0000",
                            timeout = 12000
                        })

                        while true do
                            Citizen.Wait(0)

                            -- Y button
                            if IsControlPressed(0, 311) then
                                SetNewWaypoint(coords.x, coords.y)
                                break
                            end
                        end
                    end)
                    Citizen.Wait(60 * 1000)
                    RemoveBlip(blip)
                    break
                end
            end
        end
    end)
end       
