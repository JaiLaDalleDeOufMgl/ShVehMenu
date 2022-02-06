--[[ 
    Beaucoup de correction faite, tu as encore beaucoup à apprendre.
    Prend bien en compte les corrections car tu fais beaucoup de répétition.

    Tu n'as pas encore bien saisie le fonctionnement de la programattion. Un conseil : met toi à la place de la machine
    L'indentation et mettre des commantaire c'est aussi important !! 
    

    /!\ La correction n'est pas été tester mais les prinipes sont là.
    Compare ton code avec la correction.

    Bon courage ! :)
 ]]

Vehicle = {}

local open = false 

Vehicle.MenuVehicle = RageUI.CreateMenu("Gestion Véhicule", "INTERACTION")

local vehStatut = {
    limit = 30,
    door = true,
    hood = true,
    chest = true,
    limitlist = {30, 50, 80, 120, 0},
    moteurengine = true,
    porte = true
}

local function MenuIsOpen()

    if open then

        open = not open

        RageUI.Visible(Vehicle.MenuVehicle, open)

        return

    else
        open = not open

        RageUI.Visible(Vehicle.MenuVehicle, open)

        Citizen.CreateThread(function()

            while open do 

                local veh = GetVehiclePedIsIn(PlayerPedId(), false)

                RageUI.IsVisible(Vehicle.MenuVehicle, function()

                    RageUI.Separator("→→ ~y~Gestion véhicule~s~ ←←")

                    RageUI.Separator("Limiteur Actuelle :~g~ " ..  vehStatut.limit)

                    RageUI.List("Limiteur",vehStatut.limitlist , vehStatut.limit, nil, {}, true, {

                        onListChange = function(Index)
                            vehStatut.limit = vehStatut.limitlist[Index]
                        end,

                        onSelected = function(Index)
                            SetVehicleMaxSpeed(veh, vehStatut.limitlist[Index] / 3.6 or 0)
                        end
                    })


                    RageUI.Checkbox("Moteur", "Eteindre/Allumer", vehStatut.moteurengine, nil, {

                        onSelected = function(Index)

                            vehStatut.moteurengine = not vehStatut.moteurengine
                            SetVehicleEngineOn(veh, vehStatut.moteurengine, false, true)

                        end

                    })

                    RageUI.List("Ouvrir/Fermer Porte", {"Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite", "Capot", "Coffre"} ,vehStatut.porte ,nil, {}, true, {
                        onListChange = function(Index)
                            vehStatut.porte = Index
                        end,

                        onSelected = function(Index)
                            if IsVehicleDoorFullyOpen(veh, Index - 1) then
                                SetVehicleDoorShut(veh, Index -1, false, false)
                            else
                                SetVehicleDoorOpen(veh, Index - 1, false, false)
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

    if IsPedInAnyVehicle(PlayerPedId()) then 
        MenuIsOpen()
    else
        print('Tu n\'es pas dans un véhicule.')
    end
end)
