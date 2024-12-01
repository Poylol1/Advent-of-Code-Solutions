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
local function is_in_other_list(index)
	local str = turner[1][index]
	local accumulator = 0
	for j = 1, #turner[2], 1 do
		if str == turner[2][j] then
			print(turner[2][j] .. " | " .. str)
			accumulator = accumulator + 1
		end
	end
	return (accumulator * str)
end
local acc = 0
for i = 1, #turner[1], 1 do
	acc = acc + is_in_other_list(i)
end
print(acc)
