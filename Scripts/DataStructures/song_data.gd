extends Object
class_name SongData


var name: String
var artist: String
var audio_file: String
var bpm: int
var length: float
var offset: float

var maps: Array[MapData]

# Constructor (optional, for ease of use)
func _init() -> void:
	maps = []
	pass
