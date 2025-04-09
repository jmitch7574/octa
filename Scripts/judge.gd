extends Node2D
class_name Judge

func get_current_direction():
	return Vector2(
		int(Input.is_action_pressed("direction_right")) - int(Input.is_action_pressed("direction_left")),
		int(Input.is_action_pressed("direction_down")) - int(Input.is_action_pressed("direction_up"))
	)
