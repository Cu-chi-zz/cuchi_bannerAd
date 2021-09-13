local devMode = true
local renderBanner = false

if devMode then
    RegisterCommand("cdisplay", function(s, a, r)
        if a[1] == "true" then
            TriggerServerEvent("cadBanner:callServer", true, {10, 10, 10, 255}, "TESTING AD BANNER :)", {255, 255, 255, 255}, 2)
        else
            TriggerServerEvent("cadBanner:callServer", false, {10, 10, 10, 255}, "TESTING AD BANNER :)", {255, 255, 255, 255}, 2)
        end
    end, false)
end

local currentScreenPosition = nil
local position = { x = 0.0, y = 0.0 }
function DrawBanner(topOfScreen, rgbaColor, text, textColor)
    CreateThread(function() 
        while not NetworkIsSessionStarted() do Wait(100) end
        if topOfScreen then position = { x = 1.0, y = 0.0075 } else position = { x = 1.0, y = 0.960 } end
        while renderBanner do
            Wait(0)
            if topOfScreen then
                currentScreenPosition = "top"
                DrawRect(0.5, 0.0, 1.0, 0.1, rgbaColor[1], rgbaColor[2], rgbaColor[3], rgbaColor[4])
                DrawTexts(position, text, textColor)
                UpdatePosition()
            else
                currentScreenPosition = "bottom"
                DrawRect(0.5, 1.0, 1.0, 0.1, rgbaColor[1], rgbaColor[2], rgbaColor[3], rgbaColor[4])
                DrawTexts(position, text, textColor)
                UpdatePosition()
            end
        end
    end)
end

function UpdatePosition()
    if position.x <= 0.0 then 
        position.x = 1.0 
    else
        position.x = position.x - 0.0015
    end
end

function DrawTexts(_position, text, color)
    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_position.x, _position.y)
end

RegisterNetEvent("cadBanner:Draw")
AddEventHandler("cadBanner:Draw", function(data)
    renderBanner = true
    DrawBanner(data.topOfScreen, data.bannerColor, data.text, data.textColor) 
end)

RegisterNetEvent("cadBanner:Destruct")
AddEventHandler("cadBanner:Destruct", function()
    renderBanner = false
end)
