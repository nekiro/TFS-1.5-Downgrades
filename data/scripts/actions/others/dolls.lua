local dollsTable = {
	[5080] = {"Hug me!"},
}

local dolls = Action()

function dolls.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local sounds = dollsTable[item.itemid]
	if not sounds then
		return false
	end

	if fromPosition.x == CONTAINER_POSITION then
		fromPosition = player:getPosition()
	end

	local chance = math.random(#sounds)
	local sound = sounds[chance]

	sound = sound:gsub('|PLAYERNAME|', player:getName())
	player:say(sound, TALKTYPE_MONSTER_SAY, false, 0, fromPosition)
	return true
end

for k, v in pairs(dollsTable) do
	dolls:id(k)
end
dolls:register()
