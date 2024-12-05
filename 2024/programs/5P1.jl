file = readlines("../inputs/5P1")
patterns = [r"\d*\|\d*", r"(\d*\,)*"]
d = Dict()
orders = []
b::Bool = false

for line in file
  global b
  if match(patterns[1], line) !== nothing
    f = parse(Int, SubString(line, 1, 2))
    l = parse(Int, SubString(line, 4, 5))
    if haskey(d, f)
      push!(d[f], l)
    else
      d[f] = [l]
    end
  else
    b = true
  end
  if b && line != ""
    ar = parse.(Int, split(line, ","))
    push!(orders, ar)
  end
end
function checkValidity(currAr, n::Int)::Bool
  println("I got here")
  turner = true
  if !haskey(d, n)
    return true
  end
  for bases in d[n]
    if bases in currAr
      turner = false
    end
  end
  return turner
end
function isOrderValid(n)::Int
  valid::Bool = true
  currAr = []
  for no in n
    valid = checkValidity(currAr, no)
    push!(currAr, no)
    if !valid
      return 0
    end
  end
  # assumes the array has an odd number of elements
  return n[trunc(Int, length(n) / 2 + 0.5)]

end

acc = 0
for order in orders
  global acc
  acc += isOrderValid(order)
end
println(acc)
