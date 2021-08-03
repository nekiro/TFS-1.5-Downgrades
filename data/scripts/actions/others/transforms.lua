local transformItems = {
	[1479] = 1480, [1480] = 1479, -- street lamp
	[1634] = 1635, [1635] = 1634, -- table
	[1636] = 1637, [1637] = 1636, -- table
	[1638] = 1639, [1639] = 1638, -- table
	[1640] = 1641, [1641] = 1640, -- table
	[1786] = 1787, [1787] = 1786, -- oven
	[1788] = 1789, [1789] = 1788, -- oven
	[1790] = 1791, [1791] = 1790, -- oven
	[1792] = 1793, [1793] = 1792, -- oven
	[1945] = 1946, [1946] = 1945, -- lever
	[2037] = 2038, [2038] = 2037, -- wall lamp
	[2039] = 2040, [2040] = 2039, -- wall lamp
	[2058] = 2059, [2059] = 2058, -- torch bearer
	[2060] = 2061, [2061] = 2060, -- torch bearer
	[2064] = 2065, [2065] = 2064, -- table lamp
	[2066] = 2067, [2067] = 2066, -- wall lamp
	[2068] = 2069, [2069] = 2068, -- wall lamp
	[2096] = 2097, [2097] = 2096, -- pumpkinhead
	[2578] = 2579, -- trap
	[3697] = 3698, [3698] = 3697, -- sacred statue
	[3699] = 3700, [3700] = 3699, -- sacred statue
	[3743] = 4404, [4404] = 3743, -- bamboo lamp
	[3943] = 3944, [3944] = 3943, -- torch bearer
	[3945] = 3946, [3946] = 3945, -- torch bearer
	[3947] = 3948, [3948] = 3947, -- wall lamp
	[3949] = 3950, [3950] = 3949, -- wall lamp
}

local transformTo = Action()

function transformTo.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local transformIds = transformItems[item:getId()]
	if not transformIds then
		return false
	end

	item:transform(transformIds)
	return true
end

for i, v in pairs(transformItems) do
	transformTo:id(i)
end

transformTo:register()
