-- directional window focus similar to tiling WMs

local function focus_window(direction)
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local target
	if direction == "west" then
		target = win:focusWindowWest()
	elseif direction == "east" then
		target = win:focusWindowEast()
	elseif direction == "north" then
		target = win:focusWindowNorth()
	elseif direction == "south" then
		target = win:focusWindowSouth()
	end

	if target then
		target:focus()
	end
end

hs.hotkey.bind({ "cmd" }, "h", function()
	focus_window("west")
end)
hs.hotkey.bind({ "cmd" }, "l", function()
	focus_window("east")
end)
hs.hotkey.bind({ "cmd" }, "k", function()
	focus_window("north")
end)
hs.hotkey.bind({ "cmd" }, "j", function()
	focus_window("south")
end)

hs.hotkey.bind({ "ctrl" }, "left", function()
	focus_window("west")
end)
hs.hotkey.bind({ "ctrl" }, "right", function()
	focus_window("east")
end)
hs.hotkey.bind({ "ctrl" }, "up", function()
	focus_window("north")
end)
hs.hotkey.bind({ "ctrl" }, "down", function()
	focus_window("south")
end)
