extends Button

var song_select_area_ref : Control

func _ready() -> void:
	focus_neighbor_bottom = "None"

func _on_pressed() -> void:
	song_select_area_ref.difficulty_back_pressed()
