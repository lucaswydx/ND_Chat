NDCore = exports["ND_Core"]:GetCoreObject()

if config["/me"] then
    TriggerEvent("chat:addSuggestion", "/me", "Send message in the third person (Proximity).", {{ name="Action", help="Describe your action."}})
end

if config["/gme"] then
    TriggerEvent("chat:addSuggestion", "/gme", "Send message in the third person (Global).", {{ name="Action", help="Describe your action."}})
end

if config["/twt"] then
    TriggerEvent("chat:addSuggestion", "/twt", "Send a Twotter in game. (Global)", {{name="Message", help="Twotter Message."}})
end

TriggerEvent("chat:addSuggestion", "/darkweb", "Send a anonymous message in game (Global).", {
    {
        name = "Message",
        help = ""
    }
})

TriggerEvent("chat:addSuggestion", "/911", "Call 911 for your emergency.", {
    {
        name = "Report",
        help = "Enter your report here."
    }
})

if config["/911"].enabled then
		RegisterNetEvent("ND_Chat:911")
		AddEventHandler("ND_Chat:911", function(coords, Description)
		local character = NDCore.Functions.GetSelectedCharacter()
		if not character then
			return
		end
		for _, department in pairs(config["/911"].callTo) do
			if character.job == department then
				local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
				if GetResourceState("ModernHUD") == "started" then
					exports["ModernHUD"]:AndyyyNotify({
					title = '<font color="#ff0000">911 EMERGENCY</font>',
					message = '<font color="#ff0000">Location:</font> ' .. location .. '<br><font color="#ff0000">Report:</font> ' .. Description,
					icon = "fas fa-ambulance",
					colorHex = "#ff0000",
					timeout = 8000
					})
				else
				TriggerEvent("chat:addMessage", {
					color = {255, 0, 0},
					args = {"^1^*[911]: ^3Location: ^7" .. location .. " ^3| Information: ^7" .. Description}
				})
				end
				local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
				SetBlipSprite(blip, 189)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				SetBlipColour(blip, 59)
				AddTextComponentString("Active 911 Call: " .. location)
				EndTextCommandSetBlipName(blip)
				Citizen.Wait(60 * 1000)
				RemoveBlip(blip)
				break
			end
		end
	end)
end
