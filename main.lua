-- i love love noobspharius ontop
-- now i am become snake destroyer of apples

local snake = {}
local food = {}
local direction = "right"
local grid_size = 20
local screen_width, screen_height = 800, 600
local moveInterval = 0.1
local timeElapsed = 0

function love.load()
    love.window.setMode(screen_width, screen_height)
    resetGame()
end

function resetGame()
    snake = {{x = 100, y = 100}, {x = 80, y = 100}, {x = 60, y = 100}}
    direction = "right"
    spawnFood()
end

function love.update(dt)
    -- time track
    timeElapsed = timeElapsed + dt

    if timeElapsed >= moveInterval then
        timeElapsed = 0
        moveSnake()

        -- checks if u ate the food
        if snake[1].x == food.x and snake[1].y == food.y then
            table.insert(snake, 1, {x = food.x, y = food.y}) 
            spawnFood() -- make new food appear
        end
    end

    -- input
    if love.keyboard.isDown("right") and direction ~= "left" then
        direction = "right"
    elseif love.keyboard.isDown("left") and direction ~= "right" then
        direction = "left"
    elseif love.keyboard.isDown("down") and direction ~= "up" then
        direction = "down"
    elseif love.keyboard.isDown("up") and direction ~= "down" then
        direction = "up"
    end
end

function love.draw()
    -- make the snake
    for i, segment in ipairs(snake) do
        love.graphics.setColor(0, 1, 0)
        love.graphics.rectangle("fill", segment.x, segment.y, grid_size, grid_size)
    end

    -- make the food
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", food.x, food.y, grid_size, grid_size)
end

function moveSnake()
    -- new head based on direction
    local head = {x = snake[1].x, y = snake[1].y}

    if direction == "right" then
        head.x = head.x + grid_size
    elseif direction == "left" then
        head.x = head.x - grid_size
    elseif direction == "down" then
        head.y = head.y + grid_size
    elseif direction == "up" then
        head.y = head.y - grid_size
    end

    -- add part of a snake if he ate
    table.insert(snake, 1, head)

    -- remove part of the snake if he didnt eat
    table.remove(snake)
end

function spawnFood()
    food = {
        x = math.random(0, (screen_width - grid_size) / grid_size) * grid_size,
        y = math.random(0, (screen_height - grid_size) / grid_size) * grid_size
    }
end
