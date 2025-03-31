extends "res://Scripts/main_menu_button.gd"

func _process(_delta):
	super(_delta)
	var tab_container : TabContainer = get_parent().get_child(1)
	var active_tab_ind = tab_container.current_tab
	var active_tab = tab_container.get_tab_bar()
	if active_tab:
		focus_neighbor_bottom = active_tab.get_path()  # Set focus to this element
