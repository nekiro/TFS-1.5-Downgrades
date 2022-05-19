function Player:onLook(thing, position, distance)
	local description = ""
	if EventCallback.onLook then
		description = EventCallback.onLook(self, thing, position, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
	local description = ""
	if EventCallback.onLookInBattleList then
		description = EventCallback.onLookInBattleList(self, creature, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
	local description = "You see " .. item:getDescription(distance)
	if EventCallback.onLookInTrade then
		description = EventCallback.onLookInTrade(self, partner, item, distance, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInShop(itemType, count)
	local description = "You see "
	if EventCallback.onLookInShop then
		description = EventCallback.onLookInShop(self, itemType, count, description)
	end
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if EventCallback.onMoveItem then
		return EventCallback.onMoveItem(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
	return RETURNVALUE_NOERROR
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	if EventCallback.onItemMoved then
		EventCallback.onItemMoved(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	if EventCallback.onMoveCreature then
		return EventCallback.onMoveCreature(self, creature, fromPosition, toPosition)
	end
	return true
end

function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
	if EventCallback.onReportRuleViolation then
		EventCallback.onReportRuleViolation(self, targetName, reportType, reportReason, comment, translation)
	end
end

function Player:onReportBug(message, position, category)
	if EventCallback.onReportBug then
		return EventCallback.onReportBug(self, message, position, category)
	end
	return true
end

function Player:onTurn(direction)
	if EventCallback.onTurn then
		return EventCallback.onTurn(self, direction)
	end
	return true
end

function Player:onTradeRequest(target, item)
	if EventCallback.onTradeRequest then
		return EventCallback.onTradeRequest(self, target, item)
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	if EventCallback.onTradeAccept then
		return EventCallback.onTradeAccept(self, target, item, targetItem)
	end
	return true
end

function Player:onTradeCompleted(target, item, targetItem, isSuccess)
	if EventCallback.onTradeCompleted then
		EventCallback.onTradeCompleted(self, target, item, targetItem, isSuccess)
	end
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

local function useStamina(player)
	local staminaMinutes = player:getStamina()
	if staminaMinutes == 0 then
		return
	end

	local playerId = player:getId()
	if not nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = 0
	end

	local currentTime = os.time()
	local timePassed = currentTime - nextUseStaminaTime[playerId]
	if timePassed <= 0 then
		return
	end

	if timePassed > 60 then
		if staminaMinutes > 2 then
			staminaMinutes = staminaMinutes - 2
		else
			staminaMinutes = 0
		end
		nextUseStaminaTime[playerId] = currentTime + 120
	else
		staminaMinutes = staminaMinutes - 1
		nextUseStaminaTime[playerId] = currentTime + 60
	end
	player:setStamina(staminaMinutes)
end

function Player:onGainExperience(source, exp, rawExp)
	if not source or source:isPlayer() then
		return exp
	end

	-- Soul regeneration
	local vocation = self:getVocation()
	if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
		soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
		self:addCondition(soulCondition)
	end

	-- Apply experience stage multiplier
	exp = exp * Game.getExperienceStage(self:getLevel())

	-- Stamina modifier
	if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
		useStamina(self)

		local staminaMinutes = self:getStamina()
		if staminaMinutes > 2400 and self:isPremium() then
			exp = exp * 1.5
		elseif staminaMinutes <= 840 then
			exp = exp * 0.5
		end
	end

	return EventCallback.onGainExperience and EventCallback.onGainExperience(self, source, exp, rawExp) or exp
end

function Player:onLoseExperience(exp)
	return EventCallback.onLoseExperience and EventCallback.onLoseExperience(self, exp) or exp
end

function Player:onGainSkillTries(skill, tries)
	if not APPLY_SKILL_MULTIPLIER then
		return EventCallback.onGainSkillTries and EventCallback.onGainSkillTries(self, skill, tries) or tries
	end

	if skill == SKILL_MAGLEVEL then
		tries = tries * configManager.getNumber(configKeys.RATE_MAGIC)
		return EventCallback.onGainSkillTries and EventCallback.onGainSkillTries(self, skill, tries) or tries
	end
	tries = tries * configManager.getNumber(configKeys.RATE_SKILL)
	return EventCallback.onGainSkillTries and EventCallback.onGainSkillTries(self, skill, tries) or tries
end
