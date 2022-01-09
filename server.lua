local bannerIsRendering = false
local bannerData = {}
local bannerQueue = {}
local devMode = false
local currentIndex = 0

AddEventHandler("playerJoining", function() 
    if bannerIsRendering then
        TriggerClientEvent("cadBanner:Draw", source, bannerData, currentIndex)
    end
end)

RegisterNetEvent("cadBanner:callServer")
AddEventHandler("cadBanner:callServer", function(topOfScreen, rgbaColor, text, textColor, timeoutInSeconds) 
    local _bannerData = {
        topOfScreen = topOfScreen, 
        bannerColor = rgbaColor, 
        text = text, 
        textColor = textColor,
        timeoutInSeconds = timeoutInSeconds,
        showed = false
    }
    
    if not bannerIsRendering then
        bannerIsRendering = true
        bannerData = _bannerData
        currentIndex = -1
        TriggerClientEvent("cadBanner:Draw", -1, bannerData, currentIndex)

        CreateThread(function() 
            while not (timeoutInSeconds <= 0) do
                Wait(1000)
                timeoutInSeconds = timeoutInSeconds - 1
            end
            bannerIsRendering = false
            TriggerClientEvent("cadBanner:Destruct", -1)
            CheckQueue()
        end)
    else
        for i = 1, #bannerQueue + 1, 1 do
            if bannerQueue[i] == nil then
                if devMode then 
                    print("setted "..tostring(bannerQueue[i]).." to "..tostring(_bannerData)) 
                end

                bannerQueue[i] = _bannerData
                
                if devMode then 
                    print("now > "..tostring(bannerQueue[i])) 
                end
                
                break
            end
        end
    end
end)

function CheckQueue()
    for i = 1, #bannerQueue + 1, 1 do
        if bannerQueue[i] ~= nil then
            if bannerQueue[i].showed then goto next end
            currentIndex = i
            bannerIsRendering = true
            TriggerClientEvent("cadBanner:Draw", -1, bannerQueue[i], currentIndex)

            CreateThread(function() 
                local timeoutInSeconds = bannerQueue[i].timeoutInSeconds
                while not (timeoutInSeconds <= 0) do
                    Wait(1000)
                    timeoutInSeconds = timeoutInSeconds - 1
                end
                bannerQueue[i].showed = true
                bannerIsRendering = false
                TriggerClientEvent("cadBanner:Destruct", -1)
                CheckQueue()
            end)

            if devMode then 
                print("diff nil > "..bannerQueue[i].text) 
            end
            break
        else
            break
        end
        ::next::
    end
end
