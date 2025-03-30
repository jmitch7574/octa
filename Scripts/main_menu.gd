extends Control

# Main menu buttons
@onready var play_button: Button = $main_menu/play_button
@onready var options_button: Button = $main_menu/options_button
@onready var quit_button: Button = $main_menu/quit_button

# Menu Sections
@onready var main_menu: Control = $main_menu
@onready var song_select: Control = $song_select

var sub_menu : bool = false

func _ready() -> void:
	hide_all()
	main_menu.visible = true
	play_button.grab_focus()

func _process(_delta):
	var targetPos =  Vector2(-1920, 0) if sub_menu else Vector2(0, 0) 
	position = position.lerp(targetPos, 0.1)

func hide_all():
	main_menu.visible = false
	song_select.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	hide_all()
	song_select.visible = true
	sub_menu = true
	for child in song_select.get_children():
		if child is Control:
			child.grab_focus()
