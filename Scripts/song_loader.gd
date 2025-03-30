class_name SongLoader 
extends Node

static func get_songs():
	var songs = {}
	
	var dir = DirAccess.open("user://Songs/")
	
	var packs = dir.get_directories()
	
	for pack in packs:
		dir.change_dir("user://Songs/" + pack + "/")
		songs[pack] = dir.get_directories()
		
	return songs
