local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
combat:setArea(createCombatArea(AREA_BEAM5, AREADIAGONAL_BEAM5))

function onGetFormulaValues(player, level, magicLevel)
	local base = 60
	local variation = 20

	local min = math.max((base - variation), ((3 * magicLevel + 2 * level) * (base - variation) / 100))
	local max = math.max((base + variation), ((3 * magicLevel + 2 * level) * (base + variation) / 100))

	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
