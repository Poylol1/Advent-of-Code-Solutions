
with open("../inputs/4P1") as file:
    lines = [line.rstrip() for line in file]
chars = [list(char) for char in lines]

acc = 0

def lookAround(x,y):
        #               <      ^          >                     v
    conditions = [x > 0, y > 0, x < len(chars[0]) -1 , y < len(chars) - 1,True]
    # -1 0 | 0 4
    if conditions[0] and conditions[4] and chars[y][x-1] == "M":
        followDirection(x,y,-1,0,0,4)

    # -1 -1 | 0 1
    if conditions[0] and conditions[1] and chars[y-1][x-1] =="M":
        followDirection(x,y,-1,-1,0,1)

    # 0 -1 | 4 1
    if conditions[1] and conditions[4] and chars[y-1][x] =="M":
        followDirection(x,y,0,-1,1,4)

    # 1 -1 | 
    if conditions[1] and conditions[2] and chars[y-1][x+1] == "M":
        followDirection(x,y,1,-1,1,2)

    # 1 0
    if conditions[2] and conditions[4] and chars[y][x+1] == "M":
        followDirection(x,y,1,0,2,4)

    # 1 1
    if conditions[2] and conditions[3] and chars[y+1][x+1] == "M":
        followDirection(x,y,1,1,2,3)
    # 0 1
    if conditions[3] and conditions[4] and chars[y+1][x] == "M":
        followDirection(x,y,0,1,3,4)

    # -1 1
    if conditions[3] and conditions[0] and chars[y+1][x-1] == "M":
        followDirection(x,y,-1,1,3,0)
        
def followDirection(nx,ny,modx,mody,condition_no1, condition_no2 ,c="M"):
    #print(f"{x},{y},{modx},{mody},{condition_no1},{condition_no2},{c}")
    x= nx + modx
    y = ny + mody
    global acc
    prox = ""
    conditions = [x > 0, y > 0, x < len(chars[0]) -1 , y < len(chars) - 1,True]
    print(f"{conditions} {x} {y}")
    if conditions[condition_no1] and conditions[condition_no2]:
        print(f"{chars[y][x]} expected {c} | {y+1}:{x+1} | Past {y-mody+1}:{x-modx+1} ")
    if c == "S" and chars[y][x] == c:
        acc +=1
        return
    if c == "A": prox = "S"
    if c == "M": prox = "A"
    if conditions[condition_no1] and conditions[condition_no2] and chars[y][x] == c: 
        #print(f" {x}, {y}, {c}, {chars[y+mody][x+modx]}")
        followDirection(x,y,modx,mody,condition_no1,condition_no2,prox)

print(len(chars),len(chars[0]))
for y in range(len(chars)):
    for x in range(len(chars[0])):
        if chars[y][x] == "X": lookAround(x,y)
print(acc)

