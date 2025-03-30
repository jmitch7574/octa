class_name SongLoader 
extends Node

static func get_songs():
	var songs = {}
	
	var dir = DirAccess.open("user://Songs/")
	
	var packs = dir.get_directories()
	
	for pack in packs:
		songs[pack] = []
		dir.change_dir("user://Songs/" + pack + "/")
		var sub_dirs = dir.get_directories()
		for song in sub_dirs:
			dir.change_dir("user://Songs/" + pack + "/" + song + "/")
			for file in dir.get_files():
				print(file)
				if file.ends_with(".octa"):
					var parsed_data = read_song_file("user://Songs/" + pack + "/" + song + "/" + file)
					if parsed_data != null:
						songs[pack].append(parsed_data)
		
	return songs


static func read_song_file(filePath: String) -> SongData:
	var file = FileAccess.open(filePath, FileAccess.READ)
	if file == null:
		print("Failed to open beatmap file")
		return
	
	var data: SongData = SongData.new()
	var current_difficulty : MapData
	var reading_notes: bool
		
	while file.eof_reached() == false:
		var line = file.get_line().strip_edges()
		print(line)
		# Skip empty lines and comments
		if line.is_empty():
			continue

		if line.begins_with("#TITLE:"):
			data.name = line.substr(7, line.length()).strip_edges()
			print("NAME FOUND: " + data.name)
		elif line.begins_with("#ARTIST:"):
			data.artist = line.substr(8, line.length()).strip_edges()
		elif line.begins_with("#BPM:"):
			data.bpm = line.substr(5, line.length()).strip_edges().to_float()
		elif line.begins_with("#DIFFICULTY:"):
			var difficulty_name = line.substr(12, line.length()).strip_edges()
			current_difficulty = MapData.new()
			data.maps.append(current_difficulty)
			current_difficulty.name = difficulty_name
		elif line.begins_with("#RATING:"):
			current_difficulty.rating = line.substr(8, line.length()).strip_edges().to_int()
		elif line.begins_with("#NOTES:"):
			reading_notes = true
		elif line.begins_with("#ENDNOTES"):
			reading_notes = false
		elif reading_notes:
			# Parse the notes for the current difficulty
			var note_data = line.split(",")
			if note_data.size() == 4:
				var time = note_data[0].to_float()
				var direction = note_data[1].to_int()
				var note_type = note_data[2]
				var button_required = note_data[3].strip_edges()

				#var note = Note.new(time, direction, note_type, button_required)
				#current_difficulty.notes.append(note)

	file.close()
	return data
