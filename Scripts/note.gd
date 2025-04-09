extends Node2D
class_name NoteObject

@onready var metronome: Metronome = $"../../Metronome"
@onready var octagon: Line2D = $Octagon

var noteInfo: HitNote


func _process(delta: float) -> void:
	var hue = (int(ceil(noteInfo.hitBeat * 4)) % 360) / 360.0
	octagon.default_color = Color.from_hsv(hue, 1, 1)
	var posVector:Vector2
	
	if noteInfo.direction == 0:
		posVector = Vector2(0, -1)
	if noteInfo.direction == 1:
		posVector = Vector2(1, -1)
	if noteInfo.direction == 2:
		posVector = Vector2(1, 0)
	if noteInfo.direction == 3:
		posVector = Vector2(1, 1)
	if noteInfo.direction == 4:
		posVector = Vector2(0, 1)
	if noteInfo.direction == 5:
		posVector = Vector2(-1, 1)
	if noteInfo.direction == 6:
		posVector = Vector2(-1, 0)
	if noteInfo.direction == 7:
		posVector = Vector2(-1, -1)

	position = posVector * metronome.get_distance(noteInfo.hitBeat)
