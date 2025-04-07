extends Control
class_name MainMenu

static var instance: MainMenu

# Main menu buttons
@onready var play_button: Button = $main_menu/play_button
@onready var options_button: Button = $main_menu/options_button
@onready var quit_button: Button = $main_menu/quit_button
@onready var menu_slide: Control = $"."
@onready var back_button: Button = $song_select/back_button

# Menu Sections
@onready var main_menu: Control = $main_menu
@onready var song_select: Control = $song_select

# Song Select Section
@onready var song_back_button: Button = $song_select/back_button

var targetPos: Vector2

var sub_menu : bool = false

func _ready() -> void:
	hide_all()
	main_menu.visible = true
	play_button.grab_focus()
	targetPos = Vector2(0, 0)
	instance = self

func _process(_delta):
	position = position.lerp(targetPos, 0.1)

func hide_all():
	main_menu.visible = false
	song_select.visible = false

func exit_to_song():
	GameReferee.instance.load_song()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	hide_all()
	song_select.visible = true
	sub_menu = true
	back_button.grab_focus()
	targetPos = Vector2(-1920, 0)

func _on_back_button_pressed() -> void:
	hide_all()
	main_menu.visible = true
	sub_menu = false
	play_button.grab_focus()
	targetPos = Vector2(0, 0)
