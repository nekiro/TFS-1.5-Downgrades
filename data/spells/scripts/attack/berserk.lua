local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, true)
combat:setParameter(COMBAT_PARAM_USECHARGES, true)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor)
	local min = (player:getLevel() / 5) + (skill * attack * 0.03) + 7
	local max = (player:getLevel() / 5) + (skill * attack * 0.05) + 11
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	local manaCost = creature:getLevel() * 4
	if creature:getMana() < manaCost and not creature:hasFlag(PlayerFlag_HasInfiniteMana) then
		creature:sendCancelMessage(RETURNVALUE_NOTENOUGHMANA)
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	creature:addManaSpent(manaCost)
	creature:addMana(-manaCost)

	return combat:execute(creature, variant)
end
