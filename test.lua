local robot = require("robot")

print("Input side length of platform: (max = 32)")
side_length = io.read("*n")
if (side_length > 32)
then 
    side_length = 32
end
wait = true
while(wait)
do
    resources = 0
    for i = 1,16,1
    do
        resources = resources + robot.count(i)
    end
    print("Blocks: ",resources,"/",(side_length^2))
    if (resources >= (side_length^2))
    then
        wait = false
        print("Sufficent resources, proceeding!")
    end
    os.sleep(1)
end

robot.forward()
slot = 0
parity = 0
for i = 1,side_length,1
do
    for i = 1,side_length,1
    do
        while (robot.count() == 0)
            do
                slot = robot.select(((slot+1) % 17) +1)
            end
        robot.forward()
        robot.placeDown()
    end
    if (parity == 1)
    then
        robot.turnLeft()
        robot.forward()
        robot.turnLeft()
        parity = 0
    else
        robot.turnRight()
        robot.forward()
        robot.turnRight()
        parity = 1
    end
end
robot.turnLeft()
for i = 1,side_length,1
do
    robot.forward()
end
robot.turnRight()
robot.back()
print("Job's done.")