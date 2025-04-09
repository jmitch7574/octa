extends Node2D
class_name Metronome

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var songInfo : SongData

var currentBeat: float = 0
var start_timestamp: int = 0
var current_elapsed: int = 0

func _ready() -> void:
	songInfo  = GameReferee.CurrentSong
	audio_stream_player_2d.stream = load_song(songInfo.path + songInfo.audio_file)
	
	start_timestamp = Time.get_ticks_msec()
	audio_stream_player_2d.play()

func _process(delta: float) -> void:
	update_current_beat()

func update_current_beat():
	var seconds_elapsed = audio_stream_player_2d.get_playback_position() - songInfo.offset
	current_elapsed = seconds_elapsed
	
	currentBeat = seconds_elapsed * (songInfo.bpm / 60)

func beat_to_ms(beats : float):
	return beats * (songInfo.bpm / 60)

func load_song(path : String):
	if path.ends_with(".mp3"):
		return load_mp3(path)
	elif path.ends_with(".ogg"):
		return load_ogg(path)
	return null

func get_distance(hitBeat : float):
	return max((hitBeat - currentBeat) * (songInfo.bpm * 3), 0)

func load_ogg(path):
	return AudioStreamOggVorbis.load_from_file(path)

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound
