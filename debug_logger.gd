## Lightweight logger with colored console output and log level support.
## 
## Provides [member LogLevel.INFO], [member LogLevel.WARNING] and [member LogLevel.ERROR]
## levels with distinct colors. Supports an optional prefix and rich BBCode formatting
## via [method @GDScript.print_rich].
class_name DebugLogger
extends RefCounted

## Log severity levels.
enum LogLevel {
	## Informational message (cyan).
	INFO,
	## Warning message (yellow). Also triggers [method @GDScript.push_warning].
	WARNING,
	## Error message (red). Also triggers [method @GDScript.push_error].
	ERROR
}

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

## Prefix string shown in every log message (e.g. the channel/context name).
var prefix: String
## Whether the prefix is shown in the output. Defaults to [code]true[/code].
var show_prefix: bool = true  


## Creates a new logger with the given [param p_prefix].
func _init(p_prefix: String = "DEBUG") -> void:
	prefix = p_prefix


## Enables or disables the prefix in log output.
func set_prefix_visible(enabled: bool) -> void:
	show_prefix = enabled


## Logs an INFO level message (cyan). Accepts variadic arguments.
func info(...args: Array) -> void:
	_log(LogLevel.INFO, args)


## Logs a WARNING level message (yellow). Also calls [method @GDScript.push_warning].
func warning(...args: Array) -> void:
	_log(LogLevel.WARNING, args)


## Logs an ERROR level message (red). Also calls [method @GDScript.push_error].
func error(...args: Array) -> void:
	_log(LogLevel.ERROR, args)

## Logs a plain message without log level label. No prefix, no push_warning/push_error.
func simple(...args: Array) -> void:
	var message := _join_args(args)
	print_rich(message)

## Internal method: formats the message and prints it with the appropriate color and prefix.
## Also calls [method @GDScript.push_warning] or [method @GDScript.push_error] as needed.
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


## Joins all arguments into a single string.
func _join_args(args: Array) -> String:
	var parts := PackedStringArray()
	for a in args:
		parts.append(str(a))
	return "".join(parts)
