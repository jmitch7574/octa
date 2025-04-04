extends Button

var song_menu_script
var song_data


func _on_focus_entered() -> void:
	song_menu_script.song_focused(song_data, self)

func _on_pressed() -> void:
	song_menu_script.song_pressed(song_data, self)
