extends Button

var targetPos
var basePos

@onready var particles: Array[CPUParticles2D] = [$CPUParticles2D, $CPUParticles2D2]

func _ready() -> void:
	basePos = scale
	targetPos = scale
	exit()

func _process(_delta):
	scale = scale.lerp(targetPos, 0.1)

func enter():
	for particle in particles:
		particle.emitting = true
	targetPos = basePos * 1.1

func exit():
	for particle in particles:
		particle.emitting = false
	targetPos = basePos

func _on_focus_entered() -> void:
	enter()

func _on_focus_exited() -> void:
	exit()

func _on_mouse_entered() -> void:
	grab_focus()
