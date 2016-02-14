local keyboard = libs.keyboard;
local device = libs.device;
local script = require("script");
local utf8 = require("utf8");

local _text = "";

events.detect = function ()
	return libs.fs.exists("/Applications/Google Chrome.app");
end

--@help Focus Chrome application
actions.switch = function()
	os.script("tell application \"Google Chrome\" to reopen activate");
end

--@help Launch Chrome application
actions.launch = function()
	os.open("/Applications/Google Chrome.app");
end

--@help Naviagte back
actions.back = function()
	actions.switch();
	keyboard.stroke("cmd", "left");
end

--@help Close current tab
actions.close_tab = function()
	actions.switch();
	keyboard.stroke("cmd", "W");
end

--@help Navigate forward
actions.forward = function()
	actions.switch();
	keyboard.stroke("cmd", "right");
end

--@help Go to next tab
actions.next_tab = function()
	actions.switch();
	keyboard.stroke("cmd", "option", "right");
end

--@help Go to previous tab
actions.previous_tab = function()
	actions.switch();
	keyboard.stroke("cmd", "option", "left");
end

--@help Open new tab
actions.new_tab = function()
	actions.switch();
	keyboard.stroke("cmd", "T");
end

--@help Type address
actions.address = function()
	actions.switch();
	keyboard.stroke("cmd", "L");
	device.keyboard();
end

--@help Go to home page
actions.home = function()
	actions.switch();
	keyboard.stroke("cmd", "shift", "H");
end

--@help Find on current page
actions.find = function()
	actions.switch();
	keyboard.stroke("cmd", "F");
	device.keyboard();
end

--@help Zoom page in
actions.zoom_in = function()
	actions.switch();
	keyboard.stroke("cmd", "plus");
end

--@help Zoom page out
actions.zoom_out = function()
	actions.switch();
	keyboard.stroke("cmd", "kpminus");
end

--@help Use normal zoom
actions.zoom_normal = function()
	actions.switch();
	keyboard.stroke("cmd", "0");
end

--@help Scroll page down
actions.scroll_down = function()
	actions.switch();
	keyboard.stroke("space");
end

--@help Scroll page up
actions.scroll_up = function()
	actions.switch();
	keyboard.stroke("shift", "space");
end

--@help Refresh current page
actions.refresh = function()
	actions.switch();
	keyboard.stroke("cmd", "R");
end

actions.open_in_new_tab = function()
    actions.switch();
    os.sleep(500);
    keyboard.stroke("cmd", "T");
    os.sleep(100);
    keyboard.text(_text);
    os.sleep(50);
    keyboard.press("return");
end

actions.open_in_current_tab = function()
    actions.switch();
    os.sleep(500);
    keyboard.stroke("cmd", "L");
    os.sleep(100);
    keyboard.text(_text);
    os.sleep(50);
    keyboard.press("return");
end

actions.change = function(text)
    _text = text;
end
