--[[ Version Checker ]]--
local VERSION = "0.1.2"

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        checkVersion()
    end
end)

function checkVersion()
  PerformHttpRequest("https://raw.githubusercontent.com/iTzCrutchie/esx_moneywash/master/version.json", function(err, text, h)
    if err == 200 then
      local versionArray = json.decode(text)
      local gitVersion = versionArray.version

      if(VERSION ~= gitVersion) then
        print("\n=================================\n")
        local patchnotesArray = versionArray.patchnotes
        local patchnotes = ""
        for _, line in pairs(patchnotesArray) do
          patchnotes = patchnotes..line.."\n"
        end

        print("A new version of esx_moneywash is available: "..gitVersion)
        print("patchnotes: \n"..patchnotes)
        print("\n=================================\n")
      end
    else
      print("Can't get the latest version from GitHub!")
    end
  end, "GET")
end
