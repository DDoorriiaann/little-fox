grid = {}

function grid.printGrid()
	for i = 1, 10 do
		for j = 1, 10 do
			love.graphics.rectangle("line", i * 50, j * 50, 50, 50)
		end
	end
end

function grid.draw()
	love.graphics.setColor(1, 1, 1)
	grid.printGrid()
end

return grid