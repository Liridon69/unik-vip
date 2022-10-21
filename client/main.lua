local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false



RegisterNetEvent('unik-vip:openMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = "VIP MENU",
            isMenuHeader = true,
        },
        {
            header = "VIP Categories",
            params = {
                event = "unik-vip:client:vehCategories",
            }
        },
        {
            header = "Return Vehicle ",
            params = {
                event = "unik-vip:return",
            }
        },
    })
end)





RegisterNetEvent('unik-vip:client:vehCategories', function()
    local vipcategoryMenu = {
        {
            header = 'Vehicle Categories',
            icon = "fa-solid fa-angle-left",
            params = {
                event = 'unik-vip:openMenu'
            }
        }
    }
    for k, v in pairs(Config.Vehicles['Categories']) do
        vipcategoryMenu[#vipcategoryMenu + 1] = {
            header = v,
            icon = "fa-solid fa-circle",
            params = {
                event = 'unik-vip:client:openVehCats',
                args = {
                    catName = k
                }
            }
        }
    end
    exports['qb-menu']:openMenu(vipcategoryMenu)
end)



RegisterNetEvent('unik-vip:client:openVehCats', function(data)
    local vehMenu = {
        {
            header = 'Categories',
            icon = "fa-solid fa-angle-left",
            params = {
                event = 'unik-vip:client:vehCategories'
            }
        }
    }
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if QBCore.Shared.Vehicles[k]["category"] == data.catName then
            vehMenu[#vehMenu + 1] = {
                header = v.name,
                icon = "fa-solid fa-car-side",
                    params = {
                        type = "client",
                        event = 'unik-vip:spawncar',
                        args = {
                            toVehicle = v.model,
                            }
                        }
                }   
        end
    end
    exports['qb-menu']:openMenu(vehMenu)
end)



RegisterNetEvent('unik-vip:spawncar', function(data)
    local model = data.toVehicle
    local player = PlayerPedId()
    local pos = GetEntityCoords(PlayerPedId())
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        exports[Config.FuelExport]:SetFuel(vehicle, 100)
        SetEntityHeading(vehicle, 340.0)
        TaskWarpPedIntoVehicle(player, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
        SpawnVehicle = true
    end, pos, true)
    Wait(1000)
end)




RegisterNetEvent('unik-vip:return')
AddEventHandler('unik-vip:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        QBCore.Functions.Notify("No vehicle to return", "error")
    end
end)
    
