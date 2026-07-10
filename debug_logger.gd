class_name DebugLogger
extends RefCounted

enum LogLevel {
	INFO,
	WARNING,
	ERROR
}

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

var prefix: String
var show_prefix: bool = true  


func _init(p_prefix: String = "DEBUG") -> void:
	prefix = p_prefix


func set_prefix_visible(enabled: bool) -> void:
	show_prefix = enabled


func info(...args: Array) -> void:
	_log(LogLevel.INFO, args)


func warning(...args: Array) -> void:
	_log(LogLevel.WARNING, args)


func error(...args: Array) -> void:
	_log(LogLevel.ERROR, args)

func simple(...args: Array) -> void:
	var message := _join_args(args)
	print_rich(message)

func _log(level: LogLevel, args: Array) -> void:
	var message := _join_args(args)
	var level_name: String = _LEVEL_NAME[level]
	var color: String = _LEVEL_COLOR[level]

	var formatted: String
	if show_prefix:
		formatted = "[b][%s][/b]-[color=%s]%s[/color] %s" % [prefix, color, level_name, message]
	else:
		formatted = "[color=%s]%s[/color] %s" % [color, level_name, message]

	print_rich(formatted)

	match level:
		LogLevel.WARNING:
			push_warning(message)
		LogLevel.ERROR:
			push_error(message)


func _join_args(args: Array) -> String:
	var parts := PackedStringArray()
	for a in args:
		parts.append(str(a))
	return "".join(parts)
