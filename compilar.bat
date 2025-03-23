
@echo off
echo Ejecutando comandos de Flutter...

rem Navegar al directorio del proyecto
@REM cd ruta\del\directorio\del\proyecto

rem Ejecutar comandos de Flutter
call flutter pub run flutter_launcher_icons:main
call flutter build apk --release --no-sound-null-safety

echo Comandos de Flutter completados.
pause