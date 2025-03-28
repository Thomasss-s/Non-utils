Main = {}

Main.Blip = {}
Main.Ped = {}
Main.Vehicle = {}
--------------------
Main.Player = {}

Main.Player.Shake = function()

    while true do
        if IsPedShooting(PlayerPedId()) then
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.5)
        end

        Wait(1)
    end
end

Citizen.CreateThread(Main.Player.Shake)



Main.Blip.Create = function(name, sprite, color, x, y, z)

    if name == nil or #name <= 0 then
        return
    end

    local blip = AddBlipForCoord(x,y,z)
        SetBlipSprite(blip, sprite)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(name)
        EndTextCommandSetBlipName(blip)
    
    return blip
end


Main.Blip.DestroyBlip = function(blip)
    RemoveBlip(blip)
end


Main.Ped.Create = function(name, x, y, z, heading)
    local model = GetHashKey(name)

    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(60)
    end

    local ped = CreatePed(4, model, x, y, z, heading, false, true)

    return ped
end

Main.Ped.Settings = function(model, freeze, noreaction, invicible)

    FreezeEntityPosition(model, freeze)
    SetBlockingOfNonTemporaryEvents(model, noreaction)
    SetEntityInvincible(model, invicible)
    StopPedSpeaking(ped, noreaction)
end

Main.Vehicle.Create = function(model, x, y, z, heading, setpedincar)
    local hash = GetHashKey(model)

    RequestModel(hash)

    while not HasModelLoaded(hash) do
        Wait(50)
    end

    local car =  CreateVehicle(hash, x, y, z, heading, true, false)

    if setpedincar then
        SetPedIntoVehicle(PlayerPedId(), car, -1)
    end

    return car
end





SharedObj = function()
    return Main
end


exports('SharedObj', SharedObj)