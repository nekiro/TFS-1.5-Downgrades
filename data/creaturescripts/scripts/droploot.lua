function onDeath(player, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
	if player:hasFlag(PlayerFlag_NotGenerateLoot) then
		return true
	end

	local amulet = player:getSlotItem(CONST_SLOT_NECKLACE)
	local isRedSkull = player:getSkull() == SKULL_RED
	if amulet and amulet.itemid == ITEM_AMULETOFLOSS and not isRedSkull then
		player:removeItem(ITEM_AMULETOFLOSS, 1, -1, false)
	else
		for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
			local item = player:getSlotItem(i)
			local lossPercent = 100
			if item then
				if isRedSkull or math.random(item:isContainer() and 100 or 1000) <= lossPercent then
					if (isRedSkull or lossPercent ~= 0) and not item:moveTo(corpse) then
						item:remove()
					end
				end
			end
		end
	end

	if not player:getSlotItem(CONST_SLOT_BACKPACK) then
		player:addItem(ITEM_BAG, 1, false, CONST_SLOT_BACKPACK)
	end
	return true
end
