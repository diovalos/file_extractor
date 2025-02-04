@echo off
setlocal enableDelayedExpansion

:: Move all files to the current directory
for /r %%F in (*) do (
    if "%%~dpF" neq "%cd%\" (
        move "%%F" "%cd%"
    )
)

:: Delete empty directories
for /d %%D in (*) do (
    call :CheckEmpty "%%D"
)

echo All files have been moved to the current directory and empty folders have been removed.
pause

goto :eof

:CheckEmpty
set "folder=%~1"
dir /a /b "%folder%" | findstr . >nul
if %errorlevel% neq 0 (
    rmdir "%folder%"
    echo Removed empty folder: %folder%
) else (
    for /d %%E in ("%folder%*") do call :CheckEmpty "%%E"
)
goto :eof