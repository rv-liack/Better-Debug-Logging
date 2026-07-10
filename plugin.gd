@tool
extends EditorPlugin

const AUTOLOAD_NAME = "LoggerRegistry"

func _enter_tree() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/better_debug_logging/logger_registry.gd")

func _exit_tree() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
