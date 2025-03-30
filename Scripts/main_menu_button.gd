extends Button

var targetPos
var basePos

@onready var particles: CPUParticles2D = $CPUParticles2D

func _ready() -> void:
	basePos = position
	targetPos = position
	exit()

func _process(delta):
	position = position.lerp(targetPos, 0.1)

func enter():
	particles.emitting = true
	targetPos = basePos + Vector2(100, -3)

func exit():
	particles.emitting = false
	targetPos = basePos

func _on_focus_entered() -> void:
	enter()

func _on_focus_exited() -> void:
	exit()

func _on_mouse_entered() -> void:
	grab_focus()
