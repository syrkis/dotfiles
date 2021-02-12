-- rounded corners
hs.loadSpoon("RoundedCorners")
spoon.RoundedCorners:start()

-- auto conffig package
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- auto mute when not connected to home wifi
wifiWatcher = nil
homeSSID = "gedigen"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- We just joined our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(25)
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- We just departed our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(0)
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
