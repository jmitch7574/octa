extends Sprite2D

@onready var initialScale: Vector2

func _ready():
	initialScale = scale
	punch_loop()

func _process(delta):
	scale = scale.lerp(initialScale, 0.2)
	
func punch_loop():
	while false:
		scale = initialScale * 1.2
		await get_tree().create_timer(0.425).timeout  # Waits for 2 seconds
		scale = initialScale * 1.2
		await get_tree().create_timer(0.425).timeout  # Waits for 2 seconds
		scale = initialScale * 1.2
		await get_tree().create_timer(0.425).timeout  # Waits for 2 seconds
		scale = initialScale * 1.2
		await get_tree().create_timer(0.075).timeout  # Waits for 2 seconds
		scale = initialScale * 1.2
		await get_tree().create_timer(0.35).timeout  # Waits for 2 seconds
