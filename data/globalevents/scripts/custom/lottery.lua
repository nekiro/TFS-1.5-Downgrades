local LOTTERY = {
	days = {
		["Sunday"] = {"13:55"},
		["Monday"] = {"13:55"},
		["Tuesday"] = {"13:55"},
		["Wednesday"] = {"13:55"},
		["Thursday"] = {"13:55"},
		["Friday"] = {"13:55"},
		["Saturday"] = {"13:55"},
	},
	rewards = {
		{id = 5957, count = 1},
	},
}

function LOTTERY:start()
	local candidates = {}
	local randomReward = math.random(1, LOTTERY.rewards[#LOTTERY.rewards])

	for a, b in ipairs(Game.getPlayers()) do
		local player = Player(b)
		if player and not player:getAccess() then
			candidates[#candidates+1] = player:getId()
		end
	end

	if #candidates > 0 then
		local chooseWinner = math.random(#candidates)
		local winner = Player(candidates[chooseWinner])
		local item = ItemType(randomReward.id)
		if not winner or not item then
			return false
		end

		winner:addItem(randomReward.id, randomReward.count)
		Game.broadcastMessage('The player '.. winner:getName() ..' won the lottery and won '.. randomReward.count ..'x '.. item:getName(), MESSAGE_STATUS_WARNING)
	end
	return true
end

function onThink(interval)
	if not configManager.getBoolean(configKeys.LOTTERY_SYSTEM) then
		return true
	end
	
	if LOTTERY.days[os.date("%A")] then
		local hrs = tostring(os.date("%X")):sub(1, 5)
		if isInArray(LOTTERY.days[os.date("%A")], hrs) then
			LOTTERY:start()
		end
	end
	return true
end
