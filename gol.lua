local component = require("component")
local gpu = component.gpu -- get primary gpu component
local w, h = gpu.getResolution()

world = {}
sx = math.floor(w/2)
sy = math.floor(h/2)
turn_counter = 5
direction = 0
function reset()
    for y = 1,h,1
    do  
        world[y] = {}
        for x = 1,w,1
        do  
            world[y][x] = 0
            if (world[y][x] == 1)
            then
                gpu.set(x,y,"O")
            else
                gpu.set(x,y," ")
            end
        end
    end
end

function update()
    gpu.set(sx,sy,"S")
    if turn_counter == 0
    then
        turn_counter = 3 + math.random(5)
        old_direction = direction
        direction = math.random(4)
        while direction == ((old_direction + 2) % 4)
        do
            direction = math.random(4)
        end
    end
    if direction == 1.0
            then
                sy = sy - 1
            end
        if direction == 2.0
            then
                sx = sx + 1
            end
        if direction == 3.0
            then
                sy = sy + 1
            end
        if direction == 4.0
            then
                sx = sx - 1
            end
    if (sx > w)
    then
        sx = 0
    end
    if (sx < 0)
    then
        sx = w
    end
    if (sy > h)
    then
        sy = 0
    end
    if (sx < 0)
    then
        sy = h
    end 
    gpu.set(sx,sy,"O")
    turn_counter = turn_counter - 1
end

while(true)
do
    update()
    os.sleep(0.1)
end