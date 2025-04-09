extends Line2D


func get_current_direction():
	return Vector2(
		int(Input.is_action_pressed("direction_right")) - int(Input.is_action_pressed("direction_left")),
		int(Input.is_action_pressed("direction_down")) - int(Input.is_action_pressed("direction_up"))
	).normalized()
	
func _process(delta: float) -> void:
	position = position.lerp(get_current_direction() * 70, 0.5)
