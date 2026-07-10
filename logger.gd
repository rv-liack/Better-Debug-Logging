extends Node

enum LogLevel {
	INFO,
	WARNING,
	ERROR
}

var _prefix: String = "DEBUG"

const _LEVEL_COLOR := {
	LogLevel.INFO: "cyan",
	LogLevel.WARNING: "yellow",
	LogLevel.ERROR: "red"
}

const _LEVEL_NAME := {
	LogLevel.INFO: "INFO",
	LogLevel.WARNING: "WARNING",
	LogLevel.ERROR: "ERROR"
}


func set_prefix(new_prefix: String) -> void:
	_prefix = new_prefix


func get_prefix() -> String:
	return _prefix


func info(message: String) -> void:
	_log(LogLevel.INFO, message)


func warning(message: String) -> void:
	_log(LogLevel.WARNING, message)


func error(message: String) -> void:
	_log(LogLevel.ERROR, message)


func _log(level: LogLevel, message: String) -> void:
	var level_name: String = _LEVEL_NAME[level]
	var color: String = _LEVEL_COLOR[level]
	var formatted := "[b][%s][/b]-[color=%s]%s[/color] %s" % [_prefix, color, level_name, message]
	print_rich(formatted)


	match level:
		LogLevel.WARNING:
			push_warning(message)
		LogLevel.ERROR:
			push_error(message)
