extends Object
class_name SongData


var name: String
var artist: String
var image_preview: String
var audio_file: String
var bpm: float
var length: float
var offset: float
var path: String

var maps: Array[MapData]

# Constructor (optional, for ease of use)
func _init() -> void:
	maps = []
	pass
