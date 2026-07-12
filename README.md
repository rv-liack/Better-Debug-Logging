# Better Debug Logging

Godot 4 plugin that extends the console debugging system with formatted messages, colors, and log levels.

## Features

- Formatted messages with colors in the editor console (`print_rich`)
- Three log levels: `INFO`, `WARNING`, `ERROR`
- `WARNING` and `ERROR` levels also log via `push_warning()` / `push_error()`
- Channel system (independent loggers with custom prefixes)
- Global registry (`LoggerRegistry`) available as an autoload singleton
- Two implementations: `DebugLogger` (RefCounted) and `Logger` (Node)

## Installation

1. Copy the `better_debug_logging` folder into your project's `res://addons/`.
2. Enable the plugin in **Project > Project Settings > Plugins**.

The plugin will automatically register the `LoggerRegistry` singleton.

## Usage

### LoggerRegistry (global autoload)

```gdscript
# Default logger with "DEBUG" prefix
LoggerRegistry.get_default().info("Game started")
LoggerRegistry.get_default().warning("Low memory available")
LoggerRegistry.get_default().error("Failed to load resource")

# Channels with custom prefix
var combat_logger = LoggerRegistry.channel("COMBAT")
combat_logger.info("Player attacks for 50 damage")
```

### DebugLogger (direct instance)

```gdscript
var log = DebugLogger.new("MY_MODULE")
log.info("This is an informational message")
log.warning("This is a warning")
log.error("This is an error")

# Print a message without prefix or level
log.simple("Plain unformatted message")

# Hide the prefix
log.set_prefix_visible(false)
```

### Logger (Node-based alternative)

```gdscript
var log = Logger.new()
log.set_prefix("MODULE")
log.info("Message")
log.warning("Warning")
log.error("Error")
```

## API

### DebugLogger

| Method | Description |
|--------|-------------|
| `info(...args)` | INFO level log (cyan) |
| `warning(...args)` | WARNING level log (yellow) + `push_warning()` |
| `error(...args)` | ERROR level log (red) + `push_error()` |
| `simple(...args)` | Plain unformatted message |
| `set_prefix_visible(enabled)` | Show/hide the prefix |

### LoggerRegistry

| Method | Description |
|--------|-------------|
| `get_default()` | Returns the default logger (`DEBUG`) |
| `channel(name)` | Gets or creates a logger with the given prefix |

## Colors by level

- **INFO** → cyan
- **WARNING** → yellow
- **ERROR** → red

## License

MIT - See [LICENSE](LICENSE).
