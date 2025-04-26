
@echo off
echo Ejecutando comandos de Flutter...

setlocal enabledelayedexpansion

:: Ruta del proyecto Flutter
set PROJECT_DIR=D:\proyecto_flutter\system_cable_app_v2
:: Ruta donde se guardarán los APKs
set DEST_DIR=C:\xampp\htdocs\system-cable\downloads
:: Ruta al archivo settings.dart
set SETTINGS_FILE=%PROJECT_DIR%\lib\components\settings.dart

:: Navegar a la carpeta del proyecto
cd /d %PROJECT_DIR%

:: CAMBIAR app_sucursal a system_cable_hcv
echo =============================
echo Modificando settings.dart para system_cable_hcv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_hcv';\" | Set-Content '%SETTINGS_FILE%'"

:: PRIMER BUILD - system_cable_hcv
echo =============================
echo Building APK for system_cable_hcv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_hcv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_hcv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del build
    exit /b 1
)

:: CAMBIAR app_sucursal a system_cable_tcv
echo =============================
echo Modificando settings.dart para system_cable_tcv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_tcv';\" | Set-Content '%SETTINGS_FILE%'"

:: SEGUNDO BUILD - system_cable_tcv
echo =============================
echo Building APK for system_cable_tcv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_tcv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_tcv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del segundo build
    exit /b 1
)

:: CAMBIAR app_sucursal a system_cable_ycv
echo =============================
echo Modificando settings.dart para system_cable_ycv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_ycv';\" | Set-Content '%SETTINGS_FILE%'"

:: TERCER BUILD - system_cable_ycv
echo =============================
echo Building APK for system_cable_ycv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_ycv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_ycv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del segundo build
    exit /b 1
)

:: CAMBIAR app_sucursal a system_cable_spcv
echo =============================
echo Modificando settings.dart para system_cable_spcv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_spcv';\" | Set-Content '%SETTINGS_FILE%'"

:: CUARTO BUILD - system_cable_spcv
echo =============================
echo Building APK for system_cable_spcv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_spcv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_spcv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del segundo build
    exit /b 1
)

:: CAMBIAR app_sucursal a system_cable_chcv
echo =============================
echo Modificando settings.dart para system_cable_chcv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_chcv';\" | Set-Content '%SETTINGS_FILE%'"

:: QUINTO BUILD - system_cable_chcv
echo =============================
echo Building APK for system_cable_chcv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_chcv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_chcv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del segundo build
    exit /b 1
)


:: CAMBIAR app_sucursal a system_cable_scv
echo =============================
echo Modificando settings.dart para system_cable_scv...
echo =============================

:: Usamos powershell para reemplazar la línea
powershell -Command "(Get-Content -Raw '%SETTINGS_FILE%') -replace \"final app_sucursal = 'system_cable_hcv';\", \"final app_sucursal = 'system_cable_scv';\" | Set-Content '%SETTINGS_FILE%'"

:: SEXTO BUILD - system_cable_scv
echo =============================
echo Building APK for system_cable_scv...
echo =============================

call flutter build apk --release --no-sound-null-safety

if exist build\app\outputs\flutter-apk\app-release.apk (
    echo Copiando APK como system_cable_scv.apk
    copy /Y build\app\outputs\flutter-apk\app-release.apk "%DEST_DIR%\system_cable_scv.apk"
) else (
    echo ERROR: No se encontró el archivo APK después del segundo build
    exit /b 1
)

echo =============================
echo Versionando aplicaciones.
echo =============================

:: =============================
:: Git Commit + Push solo si hay cambios (formato fecha dd-MM-yyyy HH:mm)
:: =============================

:: Navegar al repositorio git
cd /d C:\xampp\htdocs\system-cable

:: Obtener fecha y hora actual
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set DIA=%%a
    set MES=%%b
    set ANIO=%%c
)
for /f "tokens=1-2 delims=:" %%h in ("%time%") do (
    set HORA=%%h
    set MINUTO=%%i
)

set FECHA=%DIA%-%MES%-%ANIO% %HORA%:%MINUTO%
set COMMIT_MESSAGE=Actualizar apk - %FECHA%

echo =============================
echo Chequeando cambios para hacer commit...
echo =============================

git add downloads\*.apk

:: Verificar si hay cambios para commitear
git diff --cached --exit-code >nul
if %errorlevel%==0 (
    echo No hay cambios para commitear. Saltando commit.
) else (
    echo Hay cambios. Haciendo commit...
    git commit -m "%COMMIT_MESSAGE%"
    git push
)

echo =============================
echo Script completado correctamente.
echo =============================

pause
exit