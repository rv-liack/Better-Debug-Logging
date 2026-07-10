## Editor plugin that registers [LoggerRegistry] as an autoload singleton on activation.
@tool
extends EditorPlugin

## Name used for the autoload singleton.
const AUTOLOAD_NAME = "LoggerRegistry"

func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/better_debug_logging/logger_registry.gd")

func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
