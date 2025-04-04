extends Button

var song_select_area_ref : Control
var song_data: SongData
var map_index: int

func _on_pressed() -> void:
	song_select_area_ref.difficulty_pressed(song_data, map_index)
