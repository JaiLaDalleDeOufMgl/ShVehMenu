Vehicle = {}

local open = false 
Vehicle.MenuVehicle = RageUI.CreateMenu("Gestion Véhicule", "INTERACTION")
local limit,door,hood,chest,limitlist,moteurengine,porte = "~r~Aucun",1,1,1,1,1,1
MenuIsOpen = function() 
    if open then open = false RageUI.Visible(Vehicle.MenuVehicle, false) return else open = true RageUI.Visible(Vehicle.MenuVehicle, true)
        Citizen.CreateThread(function()
            while open do 
                RageUI.IsVisible(Vehicle.MenuVehicle, function()
                    RageUI.Separator("→→ ~y~Gestion véhicule~s~ ←←")
                    RageUI.Separator("Limitateur Actuelle : "..limit)
                    RageUI.List("Limitateur",{"30","50","80","120","Aucun"},limitlist,nil,{},true,{
                        onListChange = function(Index)
                            limitlist = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 8.1)
                                limit = "~g~30"
                            elseif Index == 2 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 13.7)
                                limit = "~g~50"
                            elseif Index == 3 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 22.0)
                                limit = "~g~80"
                            elseif Index == 4 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 33.0)
                                limit = "~g~120"
                            elseif Index == 5 then
                                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
                                limit = "~r~Aucun"
                            end
                        end
                    })
                    RageUI.List("Moteur",{"Eteindre","Allumé"},moteurengine,nil,{},true,{
                        onListChange = function(Index)
                            moteurengine = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, true)
                            elseif Index == 2 then
                                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), true, false, true)
                            end
                        end
                    })
                    RageUI.List("Ouvrir Porte",{"Avant gauche","Avant droite","Arrière gauche","Arrière droite","Capot","Coffre"},porte,nil,{},true,{
                        onListChange = function(Index)
                            porte = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            elseif Index == 2 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            elseif Index == 3 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            elseif Index == 4 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            elseif Index == 5 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                            elseif Index == 6 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                            end
                        end
                    })  
                    RageUI.List("Fermer Porte",{"Avant gauche","Avant droite","Arrière gauche","Arrière droite","Capot","Coffre"},porte,nil,{},true,{
                        onListChange = function(Index)
                            porte = Index
                        end,
                        onSelected = function(Index)
                            if Index == 1 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 0, false, false)
                            elseif Index == 2 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 1, false, false)
                            elseif Index == 3 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 2, false, false)
                            elseif Index == 4 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 3, false, false)
                            elseif Index == 5 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 4, false, false)
                            elseif Index == 6 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId()), 5, false, false)
                            end
                        end
                    })  
                end)
            Wait(0)
            end
        end)
    end
end

Keys.Register("G", "G", "VehMenu", function()
    local ped = GetPlayerPed(-1)
    if IsPedInAnyVehicle(ped) then
        MenuIsOpen()
    else
        print('tu nes pas dans un vehicule')
    end
end) 
