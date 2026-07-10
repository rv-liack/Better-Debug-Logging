extends Node

var _default: DebugLogger = DebugLogger.new("DEBUG")
var _channels: Dictionary = {}

func get_default() -> DebugLogger:
	return _default

func channel(name: String) -> DebugLogger:
	if not _channels.has(name):
		_channels[name] = DebugLogger.new(name)
	return _channels[name]
