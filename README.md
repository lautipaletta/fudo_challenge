# Fudo Challenge

Aplicación Flutter desarrollada con Clean Architecture, Riverpod y Hive.

## Requisitos

- Flutter SDK (versión 3.10.0 o superior)
- Dart SDK

## Instalación

1. Clonar el repositorio
2. Instalar dependencias:

```bash
flutter pub get
```

3. Generar archivos de código (mocks, serializadores, etc.):

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Configuración de Variables de Entorno

1. Crear el directorio `keys` en la raíz del proyecto:

```bash
mkdir keys
```

2. Crear el archivo `keys/development-keys.json` con el siguiente contenido:

```json
{
  "BASE_URL": "https://jsonplaceholder.typicode.com"
}
```

**Nota:** El directorio `keys/` está en `.gitignore` por seguridad.

## Ejecutar la Aplicación

### Desde la terminal

```bash
flutter run --dart-define-from-file=keys/development-keys.json
```

### Desde VS Code

Usa la configuración de launch incluida en `.vscode/launch.json` que ya tiene configurada la inyección de variables.

### Desde Android Studio / IntelliJ

Agrega `--dart-define-from-file=keys/development-keys.json` en las "Run configurations".

## Ejecutar Tests

```bash
# Generar mocks (si es necesario)
dart run build_runner build --delete-conflicting-outputs

# Ejecutar todos los tests
flutter test

# Ejecutar tests con cobertura
flutter test --coverage
```

## Credenciales de Login

- **Email:** `challenge@fudo`
- **Password:** `password`
