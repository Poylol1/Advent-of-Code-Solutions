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
function checkValidity(currAr, n)::Bool
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
function isOrderValid(n)
  valid::Bool = true
  currAr = []
  for no in n
    valid = checkValidity(currAr, no)
    push!(currAr, no)
    if !valid
      return n
    end
  end
  return nothing
end

badUpt = []
for order in orders
  global badUpt
  t = isOrderValid(order)
  if t !== nothing
    push!(badUpt, t)
  end
end

function createValidity(no::Int64, currAr, n)::Vector{Int}
  turner = [-1, -1]
  if !haskey(d, no)
    return [-1, -1]
  end
  for bases in d[no]
    if bases in currAr
      turner = [findfirst(y -> y == no, n), findfirst(x -> x == bases, n)]
    end
  end
  return turner
end
function corrections!(n)
  currAr = []
  for no in n
    valid = createValidity(no, currAr, n)
    push!(currAr, no)
    if valid[1] != -1
      moveComponents!(n, valid[2], valid[1] + 1)
      corrections!(n)
      return
    end

  end

end
# This function assumes that index_1 < index_2
function moveComponents!(arr, index_1, index_2)
  insert!(arr, index_2, arr[index_1])
  deleteat!(arr, index_1)
end

for i in badUpt
  corrections!(i)
end
acc = 0
for i in badUpt
  global acc
  acc += i[trunc(Int, length(i) / 2 + 0.5)]
end
print(acc)
