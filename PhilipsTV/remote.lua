local http = libs.http;
local data = require("data");

local url = "http://192.168.1.18:1925";

-- Documentation
-- https://github.com/unifiedremote/Docs

-- Slider
-- https://github.com/unifiedremote/Docs/blob/master/controls/slider.md

-- http library
-- https://github.com/unifiedremote/Docs/blob/master/libs/http.md

events.focus = function()
    vol_update();
end

actions.volume_change = function (progress)
    http.post(url .. "/1/audio/volume", '{"muted":false,"current":' .. progress .. '"}', function (err, resp)
        if (err) then return; end
        print(resp);
    end);
    vol_update();
end

actions.volume_mute = function ()
    send_key("Mute");
    vol_update();
end

actions.volume_down = function ()
    send_key("VolumeDown");
    vol_update();
end

actions.volume_up = function ()
    send_key("VolumeUp");
    vol_update();
end

actions.screenoff = function ()
    send_key("GreenColour");
    os.sleep(2500);
    for i = 1, 4 do
        send_key("CursorUp");
        os.sleep(200);
    end
    send_key("CursorDown");
    os.sleep(500);
    send_key("Confirm");
end

actions.back = function ()
    send_key("Back");
end

actions.up = function ()
    send_key("CursorUp");
end

actions.light = function ()
    send_key("AmbilightOnOff");
end

actions.left = function ()
    send_key("CursorLeft");
end

actions.enter = function ()
    send_key("Confirm");
end

actions.right = function ()
    send_key("CursorRight");
end

actions.options = function ()
    send_key("Options");
end

actions.down = function ()
    send_key("CursorDown");
end

actions.format = function ()
    send_key("Viewmode");
end

function vol_update()
    http.get(url .. "/1/audio/volume", function (err, resp)
        if (err) then return; end
        print(resp);
        local volume_data = data.fromjson(resp);
        layout.vol.progress = volume_data.current;
        layout.vol.progressmax = volume_data.max;
        if (volume_data.muted == true) then
            layout.mute.color = "red";
        else
            layout.mute.color = "";
        end
    end);
end

function send_key(key)
    http.post(url .. "/1/input/key", '{"key":"' .. key .. '"}', function (err, resp)
        if (err) then return; end
        print(resp);
    end);
end
