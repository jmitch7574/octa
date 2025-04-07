extends Node
class_name GameReferee

static var instance: GameReferee

static var CurrentSong : SongData
static var CurrentDifficultyIndex : int

@onready var loading_screen: ColorRect = $FadeBar

var loadingScreenOpacity:float = 0

# Scenes
const MAIN_MENU = preload("res://Scenes/main_menu.tscn")
const SONG_PLAY = preload("res://Scenes/song_play.tscn")

func _ready() -> void:
	instance = self
	load_main_menu()

func _process(delta: float) -> void:
	loading_screen.modulate.a = lerp(loading_screen.modulate.a, loadingScreenOpacity, 0.1)

func delete_all_children():
	for child in get_children():
		if not child.has_meta("dontDestroy"):
			child.queue_free()

func transition(item: PackedScene):
	loadingScreenOpacity = 1
	delete_all_children()
	await get_tree().create_timer(2).timeout
	var new_item = item.instantiate()
	add_child(new_item)
	loading_screen.move_to_front()
	loadingScreenOpacity = 0
	

func load_main_menu():
	transition(MAIN_MENU)

func load_song():
	transition(SONG_PLAY)
	
