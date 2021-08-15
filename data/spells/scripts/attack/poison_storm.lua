local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_EARTHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GREEN_RINGS)

combat:setArea(createCombatArea(AREA_CIRCLE6X6))

local condition = createConditionObject(CONDITION_POISON)
condition:setParameter(CONDITION_PARAM_DELAYED, 1)
condition:addDamage(2, 4000, -45)
condition:addDamage(2, 4000, -40)
condition:addDamage(2, 4000, -35)
condition:addDamage(2, 4000, -30)
condition:addDamage(3, 5000, -20)
condition:addDamage(3, 5000, -10)
condition:addDamage(3, 5000, -7)
condition:addDamage(3, 5000, -5)
condition:addDamage(4, 5000, -4)
condition:addDamage(6, 5000, -3)
condition:addDamage(9, 5000, -2)
condition:addDamage(12, 5000, -1)
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
