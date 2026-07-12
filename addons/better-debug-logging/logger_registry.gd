## Singleton registry that manages a default logger and named channel loggers.
##
## Registered as an autoload by the plugin so it is accessible globally as
## [code]LoggerRegistry[/code].
extends Node

## The default logger instance (prefix: [code]DEBUG[/code]).
var _default: DebugLogger = DebugLogger.new("DEBUG")
## Cache of named channel loggers.
var _channels: Dictionary = {}

## Returns the global default [DebugLogger] instance.
func get_default() -> DebugLogger:
	return _default

## Returns (or creates) a [DebugLogger] for the given [param name].
##
## Each channel is created once and then reused on subsequent calls.
func channel(name: String) -> DebugLogger:
	if not _channels.has(name):
		_channels[name] = DebugLogger.new(name)
	return _channels[name]
