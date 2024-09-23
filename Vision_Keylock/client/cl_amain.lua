if Vision.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("[^6VisionKeys^0 - ^6Debug^0] ^0: ^1"..filename()..".lua^0 ^2Loaded^0!");
end

RegisterKeyMapping("akey", "Admin Toggle Lock/Unlock", "keyboard", Vision.AdminKey)


    RegisterCommand("akey", function(source, rawCommand)

        local playerPed = GetPlayerPed(-1)
        local coords = GetEntityCoords(playerPed)
        local vehicle
        local Time = 5000

        if IsPedInAnyVehicle(playerPed, false) then
            vehicle = GetVehiclePedIsIn(playerPed, false)
            plate = GetVehicleNumberPlateText(vehicle)
        else
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 10.0, 0, 71)
            plate = GetVehicleNumberPlateText(vehicle)
        end 

        if vehicle == 0 then

            if Vision.okoknotify == false then
                BeginTextCommandThefeedPost("STRING")
                AddTextComponentSubstringPlayerName("No vehicle found!")
                EndTextCommandThefeedPostTicker(true, true)
                print("[^6VisionKeys^0 - ^6Admin^0]^1 No vehicle found!^0")
            end

            if Vision.okoknotify then
                exports['okokNotify']:Alert("Admin", "No vehicle found!", Time, 'warning')
            end
        end

        ESX.TriggerServerCallback('Vision:Keys:IsAdmin', function(IsAdmin)
            if IsAdmin then

                if vehicle ~= 0 then
                    
                    RequestAnimDict("anim@mp_player_intmenu@key_fob@")
                    while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                        Wait(100)
                    end

                            RequestAnimDict("anim@mp_player_intmenu@key_fob@")
                            while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
                                Wait(100)
                            end
                    
                        if GetVehicleDoorLockStatus(vehicle) == 1 then
                            SetVehicleDoorsLocked(vehicle, 2)

                            if Vision.okoknotify == false then
                    
                                BeginTextCommandThefeedPost("STRING")
                                AddTextComponentSubstringPlayerName("Car is ~r~Locked~s~!")
                                EndTextCommandThefeedPostTicker(true, true)

                                print("[^6VisionKeys^0 - ^6Admin^0]^1 Car is now locked!^0")

                            end

                            if Vision.okoknotify then
                                exports['okokNotify']:Alert("Admin", "Car is now locked!", Time, 'error')
                            end
                    
                            StartVehicleHorn(vehicle, 25, "HELDDOWN", false)
                            Wait(100)
                            StartVehicleHorn(vehicle, 25, "HELDDOWN", false)
                    
                            TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, -8.0, -1, 49, 0, false, false, false)
                            Wait(1000)
                            ClearPedTasks(playerPed)
                    
                            SetVehicleLights(vehicle, 2)
                            Wait(200)
                            SetVehicleLights(vehicle, 0)
                            Wait(150)
                            SetVehicleLights(vehicle, 2)
                            Wait(200)
                            SetVehicleLights(vehicle, 0)
                    
                        elseif GetVehicleDoorLockStatus(vehicle) == 2 then
                            SetVehicleDoorsLocked(vehicle, 1)
                    
                            if Vision.okoknotify == false then
                                BeginTextCommandThefeedPost("STRING")
                                AddTextComponentSubstringPlayerName("Car is ~g~unlocked~s~!")
                                EndTextCommandThefeedPostTicker(true, true)

                                print("[^6VisionKeys^0 - ^6Admin^0]^1 Car is now unlocked^0")
                            end

                            if Vision.okoknotify then
                                exports['okokNotify']:Alert("Admin", "Car is now unlocked!", Time, 'success')
                            end
                    
                            StartVehicleHorn(vehicle, 25, "HELDDOWN", false)
                            Wait(100)
                            StartVehicleHorn(vehicle, 25, "HELDDOWN", false)
                    
                            TaskPlayAnim(playerPed, "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, -8.0, -1, 49, 0, false, false, false)
                            Wait(1000)
                            ClearPedTasks(playerPed)
                    
                            SetVehicleLights(vehicle, 2)
                            Wait(200)
                            SetVehicleLights(vehicle, 0)
                            Wait(150)
                            SetVehicleLights(vehicle, 2)
                            Wait(200)
                            SetVehicleLights(vehicle, 0)

                        end
                end
            end
        end, plate)
    end)