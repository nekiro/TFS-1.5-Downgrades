local groundIds = {354, 355}
local MUD_HOLE = 392

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 11227 then -- shiny stone refining
		local chance = math.random(1, 100)
		if chance == 1 then
			player:addItem(ITEM_CRYSTAL_COIN) -- 1% chance of getting crystal coin
		elseif chance <= 6 then
			player:addItem(ITEM_GOLD_COIN) -- 5% chance of getting gold coin
		elseif chance <= 51 then
			player:addItem(ITEM_PLATINUM_COIN) -- 45% chance of getting platinum coin
		else
			player:addItem(2145) -- 49% chance of getting small diamond
		end
		target:getPosition():sendMagicEffect(CONST_ME_BLOCKHIT)
		target:remove(1)
		return true
	end

	local tile = Tile(toPosition)
	if not tile then
		return false
	end

	local ground = tile:getGround()
	if not ground then
		return false
	end

	if (ground.actionid == actionIds.pickHole and table.contains(groundIds, ground.itemid)) then
		ground:transform(MUD_HOLE)
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		ground:decay()

		toPosition.z = toPosition.z + 1
		tile:relocateTo(toPosition)
		return true
	end
	return false
end
