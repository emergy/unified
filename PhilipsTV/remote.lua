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
        --print(resp);
    end);
end

actions.volume_mute = function ()
    send_key("Mute");
end

actions.home = function ()
    send_key("Home");
end

actions.green = function ()
    send_key("GreenColour");
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

actions.channel_1 = function ()
    send_key("Digit1");
end

actions.channel_2 = function ()
    send_key("Digit2");
end

actions.channel_3 = function ()
    send_key("Digit3");
end

actions.channel_4 = function ()
    send_key("Digit4");
end

actions.channel_5 = function ()
    send_key("Digit5");
end

actions.channel_6 = function ()
    send_key("Digit6");
end

actions.channel_7 = function ()
    send_key("Digit7");
end

actions.channel_8 = function ()
    send_key("Digit8");
end

actions.channel_9 = function ()
    send_key("Digit9");
end

actions.channel_0 = function ()
    send_key("Digit0");
end

actions.channel_down = function ()
    send_key("ChannelStepDown");
end

actions.channel_up = function ()
    send_key("ChannelStepUp");
end

function vol_update()
    http.get(url .. "/1/audio/volume", function (err, resp)
        if (err) then return; end
        local volume_data = data.fromjson(resp);
        layout.vol.progress = volume_data.current;
        layout.vol.progressmax = volume_data.max;
        --print(resp);
    end);
end

function send_key(key)
    http.post(url .. "/1/input/key", '{"key":"' .. key .. '"}', function (err, resp)
        if (err) then return; end
        --print(resp);
    end);
end
