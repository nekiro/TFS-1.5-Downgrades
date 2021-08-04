local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

combat:setArea(createCombatArea(AREA_CIRCLE6X6))

local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1)
addDamageCondition(condition, 2, 4000, -45)
addDamageCondition(condition, 2, 4000, -40)
addDamageCondition(condition, 2, 4000, -35)
addDamageCondition(condition, 2, 4000, -30)
addDamageCondition(condition, 3, 5000, -20)
addDamageCondition(condition, 3, 5000, -10)
addDamageCondition(condition, 3, 5000, -7)
addDamageCondition(condition, 3, 5000, -5)
addDamageCondition(condition, 4, 5000, -4)
addDamageCondition(condition, 6, 5000, -3)
addDamageCondition(condition, 9, 5000, -2)
addDamageCondition(condition, 12, 5000, -1)
addCombatCondition(combat, condition)

function onGetFormulaValues(player, level, magicLevel)
	min = -((level * 2) + (magicLevel * 3)) * 0.9
	max = -((level * 2) + (magicLevel * 3)) * 1.5
	return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
