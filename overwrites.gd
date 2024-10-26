extends Node


var vanilla_file_paths: Array[String] = [
	"res://src/ui/stats/runStats.tscn"
]
var overwrite_file_paths: Array[String] = [
	"res://mods-unpacked/kr1v-bettergameover/overwrites/src/ui/stats/runStats.tscn"
]

var overwrite_resources := []


func _init():
	for i in overwrite_file_paths.size():
		var vanilla_path := vanilla_file_paths[i]
		var overwrite_path := overwrite_file_paths[i]

		var overwrite_resource := load(overwrite_path)
		overwrite_resources.push_back(overwrite_resource)
		overwrite_resource.take_over_path(vanilla_path)
