extends TabContainer

const SONG_BUTTON = preload("res://Resources/song_button.tscn")
const PACK_CONTAINER = preload("res://Resources/pack_container.tscn")

func _ready() -> void:
	var songs = SongLoader.get_songs()
	
	for pack in songs.keys():
		var new_pack_container = PACK_CONTAINER.instantiate()
		new_pack_container.name = pack
		add_child(new_pack_container)
		
		for song in songs[pack]:
			var new_song_item = SONG_BUTTON.instantiate()
			new_song_item.name = song.name
			new_pack_container.get_child(0).get_child(0).add_child(new_song_item)
			new_song_item.text = song.name
