manage_input = {}

function manage_input.check_keyboard_input()
	manage_input.check_escape_key()
	direction = manage_input.check_direction()
	return direction
end

function manage_input.check_escape_key()
	if (love.keyboard.isDown("escape")) then
		love.event.quit()
	end
end

function manage_input.check_direction()
	if (love.keyboard.isDown("up")) then
		return "up"
	elseif (love.keyboard.isDown("down")) then
		return "down"
	elseif (love.keyboard.isDown("left")) then
		return "left"
	elseif (love.keyboard.isDown("right")) then
		return "right"
	else
		--print(direction)
		if (player.direction == "left") then
			return "left_idle"
		elseif (player.direction == "right") then
			return "right_idle"
		else
			return player.direction
		end
	end

end

return manage_input