local thingy = { "1", 2, 3, 4, 5, 6, 7, 8, 9 }

for i = 1, #thingy, 1 do
	if tonumber(thingy[i]) == tonumber(" 1") then
		print("hi")
	end
end
