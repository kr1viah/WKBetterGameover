extends Node

const AUTHORNAME_MODNAME_DIR := "kr1v-bettergameover"
const AUTHORNAME_MODNAME_LOG_NAME := "kr1v-bettergameover:Main"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


# ! your _ready func.
func _init() -> void:
	ModLoaderLog.info("Init", AUTHORNAME_MODNAME_LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(AUTHORNAME_MODNAME_DIR)

	# Add extensions
	install_script_extensions()



func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.path_join("extensions")
	ModLoaderMod.install_script_extension(extensions_dir_path.path_join("src/ui/stats/runStats.gd"))




func _ready() -> void:
	ModLoaderLog.info("Ready", AUTHORNAME_MODNAME_LOG_NAME)



