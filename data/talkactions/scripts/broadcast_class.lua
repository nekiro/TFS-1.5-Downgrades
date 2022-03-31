function onSay(player, words, param)
	local types = {18, 19, 20, 21, 22, 23, 24, 25, 26, 27}

	if (not player:hasFlag(PlayerFlag_CanBroadcast)) then
		return true
	end

	local t = string.split(param, ",")
	if (not t or not t[1] or not t[2]) then
		player:sendCancelMessage("Invalid param specified.")
		return false
	end

	local message = t[1]
	local type = tonumber(t[2])

	if (not table.contains(types, type)) then
		player:sendCancelMessage("Invalid type specified. Check file broadcast_class in talkactions/scripts folder to see valid types.")
		return false
	end

	print("> " .. player:getName() .. " broadcasted: \n \"" .. message .. "\".")
	Game.broadcastMessage(message, type)
	return false
end
