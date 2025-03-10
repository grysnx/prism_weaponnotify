local lib = exports.ox_lib
local currentWeapon = nil

CreateThread(function()
    while true do
        Wait(500) -- checks every half an second

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)

        if weaponHash ~= currentWeapon and weaponHash ~= `WEAPON_UNARMED` then
            local weaponName = GetLabelText(GetWeaponDisplayName(weaponHash)) or 'Unknown Weapon'

            if exports.ox_lib then
                exports.ox_lib:notify({
                    title = 'Weapon Holstered',
                    icon = 'gun',
                    description = 'You pulled out a ' .. weaponName,
                    type = 'info'
                })
            else
                print("^1[ERROR] ox_lib is not found! Ensure it's running.^0")
            end

            currentWeapon = weaponHash
        elseif weaponHash == `WEAPON_UNARMED` then
            currentWeapon = nil
        end
    end
end)

function GetWeaponDisplayName(hash)
    return string.upper(WeaponHashToString(hash))
end

function WeaponHashToString(hash)
    for weapon, _ in pairs(GetWeaponHashes()) do
        if GetHashKey(weapon) == hash then
            return weapon
        end
    end
    return "WEAPON_UNKNOWN"
end

function GetWeaponHashes()
    return {
        -- to add more weapons do this
        -- weapon_example = true,
        WEAPON_PISTOL = true,
        WEAPON_COMBATPISTOL = true,
        WEAPON_APPISTOL = true,
        WEAPON_PISTOL50 = true,
        WEAPON_MICROSMG = true,
        WEAPON_SMG = true,
        WEAPON_ASSAULTSMG = true,
        WEAPON_ASSAULTRIFLE = true,
        WEAPON_CARBINERIFLE = true,
        WEAPON_ADVANCEDRIFLE = true,
        WEAPON_MG = true,
        WEAPON_COMBATMG = true,
        WEAPON_SNIPERRIFLE = true,
        WEAPON_HEAVYSNIPER = true,
        WEAPON_PUMPSHOTGUN = true,
        WEAPON_SAWNOFFSHOTGUN = true,
        WEAPON_BULLPUPSHOTGUN = true,
        WEAPON_KNIFE = true,
        WEAPON_BAT = true,
        WEAPON_CROWBAR = true,
        WEAPON_GOLFCLUB = true,
        WEAPON_HAMMER = true,
        WEAPON_NIGHTSTICK = true
    }
end
