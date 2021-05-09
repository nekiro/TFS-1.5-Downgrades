local config = {
	[5908] = {
		-- Minotaurs
		[3090] = {chance = 7000, newItem = 5878, after = 2831}, -- minotaur
		[5969] = {chance = 7000, newItem = 5878, after = 2831}, -- minotaur, after being killed
		[2871] = {chance = 7000, newItem = 5878, after = 2872}, -- minotaur archer
		[5982] = {chance = 7000, newItem = 5878, after = 2872}, -- minotaur archer, after being killed
		[2866] = {chance = 7000, newItem = 5878, after = 2867}, -- minotaur mage
		[5981] = {chance = 7000, newItem = 5878, after = 2867}, -- minotaur mage, after being killed
		[2876] = {chance = 7000, newItem = 5878, after = 2877}, -- minotaur guard
		[5983] = {chance = 7000, newItem = 5878, after = 2877}, -- minotaur guard, after being killed

		-- Low Class Lizards
		[4259] = {chance = 6000, newItem = 5876, after = 4260}, -- lizard sentinel
		[6040] = {chance = 6000, newItem = 5876, after = 4260}, -- lizard sentinel, after being killed
		[4262] = {chance = 6000, newItem = 5876, after = 4263}, -- lizard snakecharmer
		[6041] = {chance = 6000, newItem = 5876, after = 4263}, -- lizard snakecharmer, after being killed
		[4256] = {chance = 6000, newItem = 5876, after = 4257}, -- lizard templar
		[4251] = {chance = 6000, newItem = 5876, after = 4257}, -- lizard templar, after being killed

		-- High Class Lizards
		[11285] = {chance = 10000, newItem = 5876, after = 11286}, -- lizard chosen,
		[11288] = {chance = 10000, newItem = 5876, after = 11286}, -- lizard chosen, after being killed
		[11277] = {chance = 10000, newItem = 5876, after = 11278}, -- lizard dragon priest
		[11280] = {chance = 10000, newItem = 5876, after = 11278}, -- lizard dragon priest, after being killed
		[11269] = {chance = 10000, newItem = 5876, after = 11270}, -- lizard high guard
		[11272] = {chance = 10000, newItem = 5876, after = 11270}, -- lizard high guard, after being killed
		[11281] = {chance = 10000, newItem = 5876, after = 11282}, -- lizard zaogun
		[11284] = {chance = 10000, newItem = 5876, after = 11282}, -- lizard zaogun, after being killed

		-- Dragon
		[3104] = {chance = 5000, newItem = 5877, after = 3105},
		[5973] = {chance = 5000, newItem = 5877, after = 3105}, -- after being killed

		-- Dragon Lord
		[2881] = {chance = 5000, newItem = 5948, after = 2882},
		[5984] = {chance = 5000, newItem = 5948, after = 2882}, -- after being killed

		-- Behemoth
		[2931] = {chance = 10000, newItem = 5893, after = 2932},
		[5999] = {chance = 10000, newItem = 5893, after = 2932}, -- after being killed

		-- Bone Beast
		[3031] = {chance = 6000, newItem = 5925, after = 3032},
		[6030] = {chance = 6000, newItem = 5925, after = 3032}, -- after being killed

		-- Piece of Marble Rock
		[11343] = {
			{chance = 530, newItem = 11346, desc = "This little figurine of a goddess was masterfully sculpted by |PLAYERNAME|."},
			{chance = 9600, newItem = 11345, desc = "This little figurine made by |PLAYERNAME| has some room for improvement."},
			{chance = 24000, newItem = 11344, desc = "This shoddy work was made by |PLAYERNAME|."}
		},

		-- Ice Cube
		[7441] = {chance = 22000, newItem = 7442},
		[7442] = {chance = 4800, newItem = 7444},
		[7444] = {chance = 900, newItem = 7445},
		[7445] = {chance = 40, newItem = 7446},
	},
	[5942] = {
		-- Demon
		[2916] = {chance = 3000, newItem = 5906, after = 2917},
		[5995] = {chance = 3000, newItem = 5906, after = 2917}, -- after being killed

		-- Vampires
		[2956] = {chance = 6000, newItem = 5905, after = 2957}, -- vampire
		[6006] = {chance = 6000, newItem = 5905, after = 2957}, -- vampire, after being killed
		[9654] = {chance = 6000, newItem = 5905, after = 9658}, -- vampire bride
		[9660] = {chance = 6000, newItem = 5905, after = 9658}, -- vampire bride, after being killed
	}
}

local skinning = Action()

function skinning.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local skin = config[item.itemid][target.itemid]
	if not skin then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end
	local randomChance = math.random(1, 100000)
	local effect = CONST_ME_MAGIC_GREEN
	local transform = true
	if type(skin[1]) == "table" then
		local added = false
		for _, skinChild in ipairs(skin) do
			if randomChance <= skinChild.chance then
				if target.itemid == 11343 then
					local marble = player:addItem(skinChild.newItem, skinChild.amount or 1)
					if marble then
						marble:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, skinChild.desc:gsub("|PLAYERNAME|", player:getName()))
					end
					if skinChild.newItem == 11346 then
						player:addAchievement("Marblelous")
						player:addAchievementProgress("Marble Madness", 5)
					end
					effect = CONST_ME_HITAREA
					target:remove()
					added = true
				else
					target:transform(skinChild.newItem, skinChild.amount or 1)
					effect = CONST_ME_HITAREA
					added = true
				end
				break
			end
		end

		if not added and target.itemid == 11343 then
			effect = CONST_ME_HITAREA
			player:say("Your attempt at shaping that marble rock failed miserably.", TALKTYPE_MONSTER_SAY)
			transform = false
			target:remove()
		end
	elseif randomChance <= skin.chance then
		if table.contains({7441, 7442, 7444, 7445}, target.itemid) then
			if skin.newItem == 7446 then
				player:addAchievement("Ice Sculptor")
				player:addAchievementProgress("Cold as Ice", 10)
			end
			target:transform(skin.newItem, 1)
			effect = CONST_ME_HITAREA
		else
			if table.contains({5906, 5905}, skin.newItem) then
				player:addAchievementProgress("Ashes to Dust", 500)
			else
				player:addAchievementProgress("Skin-Deep", 500)
			end
			player:addItem(skin.newItem, skin.amount or 1)
		end
	else
		if table.contains({7441, 7442, 7444, 7445}, target.itemid) then
			player:say("The attempt of sculpting failed miserably.", TALKTYPE_MONSTER_SAY)
			effect = CONST_ME_HITAREA
			target:remove()
		else
			effect = CONST_ME_BLOCKHIT
		end
	end
	if transform then
		target:transform(skin.after or target:getType():getDecayId() or target.itemid + 1)
	else
		target:remove()
	end
	if toPosition.x == CONTAINER_POSITION then
		toPosition = player:getPosition()
	end
	toPosition:sendMagicEffect(effect)
	return true
end

skinning:id(5908, 5942)
skinning:register()
