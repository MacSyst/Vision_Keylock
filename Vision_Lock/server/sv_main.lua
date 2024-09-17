        
if Vision.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("[^6VisionKeys^0 - ^6Debug^0] ^0: ^1"..filename()..".lua^0 ^2Loaded^0!");
end

if Vision.CallbackTest then
    print("Registering Vision:Lock:IsVehicleOwner callback")
end

ESX.RegisterServerCallback('Vision:Lock:IsVehicleOwner', function(source, isOwner, plate)
    local vehicle = MySQL.single.await("SELECT * FROM owned_vehicles WHERE plate = :plate AND owner = :owner", {
        plate = string.upper(plate:match("^%s*(.-)%s*$")),
        owner = ESX.GetPlayerFromId(source).getIdentifier()
    })

    isOwner(vehicle and true or false)

end)