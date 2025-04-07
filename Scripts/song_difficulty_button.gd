extends Button

var song_select_area_ref : Control
var song_data: SongData
var map_index: int

func _process(delta: float) -> void:
	if get_index() == 0:
		focus_neighbor_top = "None"

func _on_pressed() -> void:
	GameReferee.CurrentSong = song_data
	GameReferee.CurrentDifficultyIndex = map_index
	MainMenu.instance.exit_to_song()
