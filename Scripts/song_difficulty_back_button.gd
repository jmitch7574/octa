extends Button

var song_select_area_ref : Control

func _on_pressed() -> void:
	song_select_area_ref.difficulty_back_pressed()
