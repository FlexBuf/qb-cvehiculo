---MENU CIRCULAR CONTROLES DE VEHICULO --
local QBCore = exports['qb-core']:GetCoreObject()

----- Extrae datos del trabajo -----

local PlayerData = {}

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	PlayerData = QBCore.Functions.GetPlayerData()
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

----- Abre el menu ----

RegisterNetEvent('ccvehmenu:client:openMenu')
AddEventHandler('ccvehmenu:client:openMenu', function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        createCarControlMenu()
        exports['qb-menu']:openMenu(ccMenu)
    else
        QBCore.Functions.Notify("No estas en un vehiculo", "error", 3500)
    end
end)

------ Controles de ventanas ---- 

RegisterNetEvent('qb-vehiclemenu:windowscontrol', function(args)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local args = tonumber(args)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            if args == 1 then 
                IsVehicleWindowIntact(veh, 0)
                RollDownWindow(veh, 0)
                QBCore.Functions.Notify("Ventana abajo", "success", 3500)
                elseif args == 2 then 
                IsVehicleWindowIntact(veh, 1)
                RollDownWindow(veh, 1)
                QBCore.Functions.Notify("Ventana abajo", "success", 3500)
                elseif args == 3 then 
                IsVehicleWindowIntact(veh, 2)
                RollDownWindow(veh, 2)
                QBCore.Functions.Notify("Ventana abajo", "success", 3500)
                elseif args == 4 then 
                IsVehicleWindowIntact(veh, 3)
                RollDownWindow(veh, 3)
                QBCore.Functions.Notify("Ventana abajo", "success", 3500)
                elseif args == 5 then
                IsVehicleWindowIntact(veh, 0)
                RollUpWindow(veh, 0)
                QBCore.Functions.Notify("Ventana arriba", "success", 3500)
                elseif args == 6 then 
                IsVehicleWindowIntact(veh, 1)
                RollUpWindow(veh, 1)
                QBCore.Functions.Notify("Ventana arriba", "success", 3500)
                elseif args == 7 then 
                IsVehicleWindowIntact(veh, 2)
                RollUpWindow(veh, 2)
                QBCore.Functions.Notify("Ventana arriba", "success", 3500)
                elseif args == 8 then 
                IsVehicleWindowIntact(veh, 3)
                RollUpWindow(veh, 3)
                QBCore.Functions.Notify("Ventana arriba", "success", 3500)
                end
                TriggerEvent('ccvehmenu:client:windowsMenu')
        end
end)

------ Controles de motor ------

RegisterNetEvent('qb-vehiclemenu:enginecontrol:on', function(args)
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local args = tonumber(args)
    local IsSeatFree = IsVehicleSeatFree(veh, -1)
    if IsSeatFree == false then
        if GetPedInVehicleSeat(veh, -1) then
            if args == 1 then 
                SetVehicleEngineOn(veh, true, false, true)
                QBCore.Functions.Notify("Motor Encendido", "success", 3500)
                elseif args == 2 then 
                SetVehicleEngineOn(veh, false, false, true)
                QBCore.Functions.Notify("Motor Apagado", "success", 3500)
                end
                TriggerEvent('ccvehmenu:client:engineMenu')
            end
    else
        QBCore.Functions.Notify("Debes estar de Piloto", "error", 3500)
        TriggerEvent('ccvehmenu:client:engineMenu')
    end
end)

----- Controles de neones ------

local VehiclesWithNeons = {}

local function HasNeon(vehicle)
    if VehiclesWithNeons[vehicle] ~= nil then
        return true
    end

    if IsVehicleNeonLightEnabled(vehicle) then
        VehiclesWithNeons[vehicle] = true
        return true
    end

end

RegisterNetEvent('qb-vehiclemenu:neoncontrol', function()
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if not vehicle or not IsPedInAnyVehicle(playerPed, false) or GetPedInVehicleSeat(vehicle, -1) ~= playerPed then return end -- Valida si esta en el vehiculo o asiento de piloto

    local hasNeons = HasNeon(vehicle)

    if not hasNeons then 
        QBCore.Functions.Notify('Neones no instalados', 'error')
        TriggerEvent('ccvehmenu:client:ccMenu')
        return
    end

        local neonsOn = (VehiclesWithNeons[vehicle] ~= nil and VehiclesWithNeons[vehicle] or false)

    SetVehicleNeonLightEnabled(vehicle, 0, not neonsOn)
    SetVehicleNeonLightEnabled(vehicle, 1, not neonsOn)
    SetVehicleNeonLightEnabled(vehicle, 2, not neonsOn)
    SetVehicleNeonLightEnabled(vehicle, 3, not neonsOn)
        VehiclesWithNeons[vehicle] = not neonsOn
        TriggerEvent('ccvehmenu:client:ccMenu')

end)

------ Eventos de los menús ------

RegisterNetEvent('ccvehmenu:client:ccMenu', function()
    local ped = PlayerPedId()
    local veh = IsPedSittingInVehicle(ped)
    local isnotVeh = IsPedInVehicle(ped, veh, false)
        if isnotVeh == true then
            QBCore.Functions.Notify('No estas en un vehiculo', 'error')
        else
            createCarControlMenu()
            exports['qb-menu']:openMenu(ccMenu)
        end
end)

RegisterNetEvent('ccvehmenu:client:windowsMenu', function()
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if veh ~= nil or veh ~= 0 then
        local seatCount = GetVehicleModelNumberOfSeats(GetEntityModel(veh))
        if seatCount == 2 then
            create2WindowsMenu()
            exports['qb-menu']:openMenu(windows2Menu)
        elseif seatCount == 4 then
            createWindowsMenu()
            exports['qb-menu']:openMenu(windowsMenu)
        elseif seatCount == 6 then
            createWindowsMenu()
            exports['qb-menu']:openMenu(windowsMenu)
        end
    end
end)

RegisterNetEvent('ccvehmenu:client:engineMenu', function()
    createEngineMenu()
    exports['qb-menu']:openMenu(engineMenu)
end)


RegisterNetEvent('ccvehmenu:client:neonMenu', function()
    createNeonMenu()
    exports['qb-menu']:openMenu(neonMenu)
end)

------ Estructuras de menú ------

function createCarControlMenu()
    ccMenu = {
        {
            isHeader = true,
            header = ' 🚓 | Controles de Vehiculo'
        },
        {
            header = "Ventanas",
			txt = "Subir o bajar el vidrio de ventanas",
			params = {
                isServer = false,
                event = "ccvehmenu:client:windowsMenu",
            }
        },
        {
            header = "Motor",
			txt = "Encender o Apagar el Motor",
			params = {
                isServer = false,
                event = "ccvehmenu:client:engineMenu",
            }
        },
        {
            header = "Neones",
			txt = "Encerder o Apagar los neones",
			params = {
                isServer = false,
                --event = "ccvehmenu:client:neonMenu", 
				 event = "qb-vehiclemenu:neoncontrol", 
            }
        },
        {
            header = "⬅ Cerrar",
			txt = "Cerrar el Menu",
			params = {
                isServer = false,
                event = exports['qb-menu']:closeMenu(),
            }
        },
    }
    exports['qb-menu']:openMenu(ccMenu)
end


function createWindowsMenu()
    windowsMenu = {
        {
            isHeader = true,
            header = ' 🚓 | Ventanas'
        },
        {
            header = "Bajar Vidrio Piloto",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 1,
            }
        },
        {
            header = "Bajar Vidrio Copiloto",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 2,
            }
        },
        {
            header = "Vidrio Trasera Izquerda",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 3,
            }
        },
        {
            header = "Vidrio Trasera Derecha",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 4,
            }
        },
        {
            header = "Subir Vidrio Piloto",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 5,
            }
        },
        {
            header = "Subir Vidrio Copiloto",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 6,
            }
        },
        {
            header = "Vidrio Trasera Izquerda",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 7,
            }
        },
        {
            header = "Vidrio Trasera Derecha",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 8,
            }
        },
        {
            header = '⬅ | Atras',
            txt = 'Volver al menu de controles',
            params = {
                isServer = false,
                event = 'ccvehmenu:client:openMenu',
            }
        },
    }
    exports['qb-menu']:openMenu(windowsMenu)
end

function create2WindowsMenu()
    windows2Menu = {
        {
            isHeader = true,
            header = ' 🚓 | Ventanas'
        },
        {
            header = "Bajar Vidrio Piloto",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 1,
            }
        },
        {
            header = "Bajar Vidrio Copiloto",
			txt = "Presiona para BAJAR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 2,
            }
        },
        {
            header = "Subir Vidrio Piloto",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 5,
            }
        },
        {
            header = "Subir Vidrio Copiloto",
			txt = "Presiona para SUBIR el vidrio",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:windowscontrol",
                args = 6,
            }
        },
        {
            header = '⬅ | Atras',
            txt = 'Volver al menu de controles',
            params = {
                isServer = false,
                event = 'ccvehmenu:client:openMenu',
            }
        },
    }
    exports['qb-menu']:openMenu(windows2Menu)
end


function createEngineMenu()
    engineMenu = {
        {
            isHeader = true,
            header = ' 🚓 | Motor del Vehiculo'
        },
        {
            header = "Encender Motor",
			txt = "Presiona para encender",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:enginecontrol:on",
                args = 1
            }
        },
        {
            header = "Apagar Motor",
			txt = "Presiona para apagar",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:enginecontrol:on",
                args = 2
            }
        },
        {
            header = '⬅ | Atras',
            txt = 'Presiona para volver al menu',
            params = {
                isServer = false,
                event = 'ccvehmenu:client:openMenu',
            }
        },
    }
    exports['qb-menu']:openMenu(seatMenu)
end


---- funcion que abre el menu de neones para encernder/apagar 

--[[function createNeonMenu()
    neonMenu = {
        {
            isHeader = true,
            header = ' 🚓 | Neones'
        },
        {
            header = "Encender",
			txt = "Presiona para encender",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:neoncontrol",
                args = 1
            }
        },
        {
            header = "Apagar",
			txt = "Presiona para apagar",
			params = {
                isServer = false,
                event = "qb-vehiclemenu:neoncontrol",
                args = 2
            }
        },
        {
            header = '⬅ | Atras',
            txt = 'Presiona para volver al menu',
            params = {
                isServer = false,
                event = 'ccvehmenu:client:openMenu',
            }
        },
    }
    exports['qb-menu']:openMenu(neonMenu)
end]]
