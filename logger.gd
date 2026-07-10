## Legacy logger with colored console output.
##
## Provides [enum LogLevel]-based logging with a configurable prefix.
## Prefer [DebugLogger] for new code (supports variadic arguments and prefix toggle).
extends Node

## Log severity levels.
enum LogLevel {
	## Informational message (cyan).
	INFO,
	## Warning message (yellow). Also triggers [method @GDScript.push_warning].
	WARNING,
	## Error message (red). Also triggers [method @GDScript.push_error].
	ERROR
}

## Prefix shown at the start of every log message.
var _prefix: String = "DEBUG"

## Maps each [enum LogLevel] to its BBCode color tag.
const _LEVEL_COLOR := {
	LogLevel.INFO: "cyan",
	LogLevel.WARNING: "yellow",
	LogLevel.ERROR: "red"
}

## Maps each [enum LogLevel] to its human-readable name.
const _LEVEL_NAME := {
	LogLevel.INFO: "INFO",
	LogLevel.WARNING: "WARNING",
	LogLevel.ERROR: "ERROR"
}


## Sets the prefix displayed in log messages.
func set_prefix(new_prefix: String) -> void:
	_prefix = new_prefix


## Returns the current prefix.
func get_prefix() -> String:
	return _prefix


## Logs an INFO level message (cyan).
func info(message: String) -> void:
	_log(LogLevel.INFO, message)


## Logs a WARNING level message (yellow). Also calls [method @GDScript.push_warning].
func warning(message: String) -> void:
	_log(LogLevel.WARNING, message)


## Logs an ERROR level message (red). Also calls [method @GDScript.push_error].
func error(message: String) -> void:
	_log(LogLevel.ERROR, message)


## Internal method: formats the message with prefix, level, and color, then prints it.
## Also calls [method @GDScript.push_warning] or [method @GDScript.push_error] as needed.
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
