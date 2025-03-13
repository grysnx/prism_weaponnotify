local lib = exports.ox_lib
local currentWeapon = nil

CreateThread(function()
    while true do
        Wait(500) -- checks every half second

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)

        if weaponHash ~= currentWeapon and weaponHash ~= `WEAPON_UNARMED` and IsWeaponAllowed(weaponHash) then
            local weaponName = GetLabelText(GetWeaponDisplayName(weaponHash)) or 'Unknown Weapon'

            if lib then
                lib:notify({
                    title = 'Weapon Holstered',
                    icon = 'gun',
                    description = 'You pulled out a ' .. weaponName,
                    type = 'info'
                })
            else
                print("^1[ERROR] ox_lib is not found! Ensure it's running.^0")
            end

            currentWeapon = weaponHash
        elseif weaponHash == `WEAPON_UNARMED` and currentWeapon ~= nil then
            if lib then
                lib:notify({
                    title = 'Weapon Unholstered',
                    icon = 'gun',
                    description = 'You put away your weapon.',
                    type = 'info'
                })
            else
                print("^1[ERROR] ox_lib is not found! Ensure it's running.^0")
            end

            currentWeapon = nil
        end
    end
end)

function GetWeaponDisplayName(hash)
    return string.upper(WeaponHashToString(hash))
end

function WeaponHashToString(hash)
    local weaponHashes = GetWeaponHashes()
    for weapon, _ in pairs(weaponHashes) do
        if GetHashKey(weapon) == hash then
            return weapon
        end
    end
    return "WEAPON_UNKNOWN"
end

function IsWeaponAllowed(hash)
    local weaponHashes = GetWeaponHashes()
    for weapon, _ in pairs(weaponHashes) do
        if GetHashKey(weapon) == hash then
            return true
        end
    end
    return false
end

function GetWeaponHashes()
    return {
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
