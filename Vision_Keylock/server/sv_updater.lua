local githubReleasesUrl = "https://api.github.com/repos/MacSyst/Vision_Keylock/releases/latest"

if Vision.Debug then
    local filename = function()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("^.*/(.*).lua$") or str
    end
    print("[^6VisionKeys^0 - ^6Debug^0] ^0: ^1"..filename()..".lua^0 ^2Loaded^0!");
end

if Vision.UpdateCheck == false then
    print("[^6Vision System^0 - ^6Update^0]^1 Update Check Disabled!^0")
    print("[^6Vision System^0 - ^6Update^0]^1 Please activate the updater so you don't miss important updates!^0")
end

function checkForUpdate()
    print("[^6Vision System^0 - ^6Update^0]^1 Checking for Update!^0")

    Wait(5000)

    PerformHttpRequest(githubReleasesUrl, function(statusCode, response, headers)
        if statusCode == 200 then
            local data = json.decode(response)
            local latestVersion = data.tag_name or "unknown"

            local currentVersion = "1.0.2"

            if latestVersion ~= currentVersion then
                print("[^6Vision System^0 - ^6Update^0]^1 New Version of Script Online!^0")
                print("[^6Vision System^0 - ^6Update^0]^1 Latest Version: " .. latestVersion .. "^0")
            else
                print("[^6Vision System^0 - ^6Update^0]^1 There is no update available!^0")
            end
        else
            print("[^6Vision System^0 - ^6Update^0]^1 Error retrieving version information!^0")
        end
    end, 'GET', '', { ['Content-Type'] = 'application/json' })
end

if Vision.UpdateCheck then
    checkForUpdate()
end
