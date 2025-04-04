extends Control

@onready var back_button: Button = $back_button

@onready var songs: TabContainer = $songs
@onready var difficulties: TabContainer = $difficulties
@onready var song_info: TabContainer = $songInfo

@onready var h_flow_container: HFlowContainer = $Difficulties/Difficulty/HFlowContainer
const SONG_DIFFICULTY_BUTTON = preload("res://Resources/song_difficulty_button.tscn")
const SONG_DIFFICULTY_BACK_BUTTON = preload("res://Resources/song_difficulty_back_button.tscn")
var current_diff_buttons: Array[Button] = []

@onready var song_name: Label = $"Song Info/titles_flow/song_name"
@onready var song_artist: Label = $"Song Info/titles_flow/song_artist"
@onready var song_bpm: Label = $"Song Info/titles_flow/song_bpm"
@onready var texture_rect: TextureRect = $"Song Info/TextureRect"


var song_picked_ref : Button

func _process(_delta):
	var active_tab = songs.get_tab_bar()
	if active_tab:
		back_button.focus_neighbor_bottom = active_tab.get_path()  # Set focus to this element

func song_focused(song_data: SongData, called_button : Button):
	for button in current_diff_buttons:
		button.queue_free()
	
	current_diff_buttons = []
	
	for map_index in range(len(song_data.maps)):
		var map = song_data.maps[map_index]
		var new_button = SONG_DIFFICULTY_BUTTON.instantiate()
		h_flow_container.add_child(new_button)
		current_diff_buttons.append(new_button)
		new_button.text = map.name + " | "
		for i in range(map.rating):
			new_button.text = new_button.text + "★"
		new_button.song_select_area_ref = self
		new_button.song_data = song_data
		new_button.map_index = map_index
		
	
	song_name.text = song_data.name
	song_artist.text = "ARTIST: " + song_data.artist
	song_bpm.text = "BPM: " + str(song_data.bpm)

	
	var back_button = SONG_DIFFICULTY_BACK_BUTTON.instantiate()
	h_flow_container.add_child(back_button)
	current_diff_buttons.append(back_button)
	back_button.text = "BACK"
	back_button.song_select_area_ref = self
	print(song_data.image_preview)
	
	var image = Image.new()
	if image.load(song_data.path + song_data.image_preview) == OK:
		var texture = ImageTexture.new()
		texture.set_image(image)
		texture_rect.texture = texture  # Example: apply texture to a Sprite2D
	else:
		texture_rect.texture = null
	
	song_picked_ref = called_button

func song_pressed(song_data: SongData, called_button : Button):
	current_diff_buttons[0].grab_focus()
	song_picked_ref = called_button

func difficulty_pressed(song_data: SongData, map_index: int):
	pass

func difficulty_back_pressed():
	song_picked_ref.grab_focus()
