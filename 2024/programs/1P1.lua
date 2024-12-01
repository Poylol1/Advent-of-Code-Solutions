local turner = { {}, {} }
local function makeIntoList(line)
	local limit1 = 0
	local limit2 = 0
	local sp = 0
	for i = 1, #line, 1 do
		local ch = line:sub(i, i)
		if ch == " " then
			sp = sp + 1
		end
		if sp == 2 then
			limit1 = i
		end
		if limit1 ~= 0 and ch ~= " " then
			limit2 = i - 4
		end
	end
	table.insert(turner[1], tonumber(line:sub(1, limit1)))
	table.insert(turner[2], tonumber(line:sub(limit2)))
end
for l in io.lines("../inputs/1P1") do
	makeIntoList(l)
end
table.sort(turner[1])
table.sort(turner[2])
local acumulator = 0
if turner[1] == nil then
	error("for some reason this is null")
end
if turner[2] == nil then
	error("for some reason this is null")
end
for i = 1, #turner[1], 1 do
	acumulator = acumulator + (turner[2][i] - turner[1][i])
end
print(acumulator)
