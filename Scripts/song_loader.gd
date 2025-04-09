class_name SongLoader 
extends Node

static var hit_note_regex = r"^-?\d+(\.\d+)?$"
static var hold_note_regex = r"^-?\d+(\.\d+)?--?\d+(\.\d+)?$"

static func get_songs():
	var songs = {}
	
	var dir = DirAccess.open("res://octa-songlist/")
	
	var packs = dir.get_directories()
	
	for pack in packs:
		songs[pack] = []
		dir.change_dir("res://octa-songlist/" + pack + "/")
		var sub_dirs = dir.get_directories()
		for song in sub_dirs:
			dir.change_dir("res://octa-songlist/" + pack + "/" + song + "/")
			for file in dir.get_files():
				print(file)
				if file.ends_with(".octa"):
					var parsed_data = read_song_file("res://octa-songlist/" + pack + "/" + song + "/" + file)
					if parsed_data != null:
						songs[pack].append(parsed_data)
		
	return songs


static func read_song_file(filePath: String) -> SongData:
		
	var hit_note_regex_var = RegEx.new()
	var hold_note_regex_var = RegEx.new()

	hit_note_regex_var.compile(hit_note_regex)
	hold_note_regex_var.compile(hold_note_regex)
	
	var file = FileAccess.open(filePath, FileAccess.READ)
	if file == null:
		print("Failed to open beatmap file")
		return
	
	var data: SongData = SongData.new()
	var current_difficulty : MapData
	var reading_notes: bool
	
	data.path = filePath.get_base_dir() + "/"
		
	while file.eof_reached() == false:
		var line = file.get_line().strip_edges()
		print(line)
		# Skip empty lines and comments
		if line.is_empty():
			continue

		if line.begins_with("#TITLE:"):
			data.name = line.substr(7, line.length()).strip_edges() + str(randi_range(0, 1000))
			print("NAME FOUND: " + data.name)
		elif line.begins_with("#ARTIST:"):
			data.artist = line.substr(8, line.length()).strip_edges()
		elif line.begins_with("#BPM:"):
			data.bpm = line.substr(5, line.length()).strip_edges().to_float()
		elif line.begins_with("#PREVIEW:"):
			data.image_preview = line.substr(9, line.length()).strip_edges()
		elif line.begins_with("#AUDIO:"):
			data.audio_file = line.substr(7, line.length()).strip_edges()
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
			if note_data.size() == 3:
				var hitNote : NoteInfo
				if hit_note_regex_var.search(note_data[0]):
					hitNote = HitNote.new()
					hitNote.hitBeat = note_data[0].to_float()
				elif hold_note_regex_var.search(note_data[0]):
					hitNote = HoldNote.new()
					var data_split = note_data[0].split("-")
					hitNote.holdStart = data_split[0].to_float()
					hitNote.holdEnd = data_split[1].to_float()
					
				hitNote.direction = note_data[1].to_int()
				hitNote.hitButton = note_data[2].strip_edges()

				#var note = Note.new(time, direction, note_type, button_required)
				current_difficulty.notes.append(hitNote)

	file.close()
	return data
