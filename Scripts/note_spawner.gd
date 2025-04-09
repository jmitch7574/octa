extends Node2D

const NOTE = preload("res://Resources/hit_note.tscn")
@onready var center: Node2D = $"../Center"

var spawned_notes : Array[Node2D]

func _ready() -> void:
	for note in GameReferee.CurrentSong.maps[GameReferee.CurrentDifficultyIndex].notes:
		var new_note = NOTE.instantiate()
		center.add_child(new_note)
		new_note.noteInfo = note
		print("Spawning Note")
