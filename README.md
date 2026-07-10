# Better Debug Loggin

Plugin para Godot 4 que extiende el sistema de depuración en consola con mensajes con formato, colores y niveles de log.

## Características

- Mensajes formateados con colores en la consola del editor (`print_rich`)
- Tres niveles de log: `INFO`, `WARNING`, `ERROR`
- Los niveles `WARNING` y `ERROR` también se registran con `push_warning()` / `push_error()`
- Sistema de canales (loggers independientes con prefijos personalizados)
- Registro global (`LoggerRegistry`) disponible como autoload singleton
- Dos implementaciones: `DebugLogger` (RefCounted) y `Logger` (Node)

## Instalación

1. Copia la carpeta `better_debug_logging` en `res://addons/` de tu proyecto.
2. Habilita el plugin en **Proyecto > Configuración del proyecto > Plugins**.

El plugin registrará automáticamente el singleton `LoggerRegistry`.

## Uso

### LoggerRegistry (autoload global)

```gdscript
# Logger por defecto con prefijo "DEBUG"
LoggerRegistry.get_default().info("Juego iniciado")
LoggerRegistry.get_default().warning("Poca memoria disponible")
LoggerRegistry.get_default().error("No se pudo cargar el recurso")

# Canales con prefijo personalizado
var combat_logger = LoggerRegistry.channel("COMBAT")
combat_logger.info("Jugador ataca con 50 de daño")
```

### DebugLogger (instancia directa)

```gdscript
var log = DebugLogger.new("MI_MODULO")
log.info("Esto es un mensaje informativo")
log.warning("Esto es una advertencia")
log.error("Esto es un error")

# Mostrar mensaje sin prefijo ni nivel
log.simple("Mensaje plano sin formato")

# Ocultar el prefijo
log.set_prefix_visible(false)
```

### Logger (alternativa basada en Node)

```gdscript
var log = Logger.new()
log.set_prefix("MODULO")
log.info("Mensaje")
log.warning("Advertencia")
log.error("Error")
```

## API

### DebugLogger

| Método | Descripción |
|--------|-------------|
| `info(...args)` | Log nivel INFO (cian) |
| `warning(...args)` | Log nivel WARNING (amarillo) + `push_warning()` |
| `error(...args)` | Log nivel ERROR (rojo) + `push_error()` |
| `simple(...args)` | Mensaje plano sin formato |
| `set_prefix_visible(enabled)` | Muestra/oculta el prefijo |

### LoggerRegistry

| Método | Descripción |
|--------|-------------|
| `get_default()` | Devuelve el logger por defecto (`DEBUG`) |
| `channel(name)` | Obtiene o crea un logger con el prefijo dado |

## Colores por nivel

- **INFO** → cian
- **WARNING** → amarillo
- **ERROR** → rojo

## Licencia

MIT - Ver [LICENSE](LICENSE).
