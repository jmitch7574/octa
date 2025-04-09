extends Label

@onready var metronome: Metronome = $"../Metronome"

func _process(delta: float) -> void:
	text = str(metronome.currentBeat) + "\n" + str(metronome.current_elapsed)
