
with open("../inputs/4P1") as file:
    lines = [line.rstrip() for line in file]
chars = [list(char) for char in lines]

acc = 0

def lookAround(x,y):
        #               <      ^          >                     v
    conditions = [x > 0, y > 0, x < len(chars[0]) -1 , y < len(chars) - 1]
    corner = [conditions[0] and conditions[1],
              conditions[1] and conditions[2],
              conditions[2] and conditions[3],
              conditions[3] and conditions[0] ]
    totalBool = corner[0] and corner[1] and corner[2] and corner[3]
    if totalBool:
        followDirection(x,y)
 
def followDirection(x,y):
    global acc
    p= [
        [x+1,y-1],# ur
        [x+1,y+1],# dr
        [x-1,y+1],# dl
        [x-1,y-1],# ul
    ]
    l = []
    for i in range(len(p)):
        if chars[p[i][1]][p[i][0]] == "M": 
            l.append(i)
    if len(l) != 2: return
    if (l[0] == 0 and l[1] == 2) or (l[0] == 1 and l[1] == 3): return
    f = [(l[0]+2) % 4, (l[1]+2)%4]
    if chars[p[f[0]][1]][p[f[0]][0]] == "S" and chars[p[f[1]][1]][p[f[1]][0]] == "S":
        print(f"{l} {f}")
        acc += 1



for y in range(len(chars)):
    for x in range(len(chars[0])):
        if chars[y][x] == "A": lookAround(x,y)
print(acc)

