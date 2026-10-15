@echo off
setlocal
cd /d "%~dp0"
set "GIT_BASH="
if exist "%ProgramFiles%\Git\bin\bash.exe" set "GIT_BASH=%ProgramFiles%\Git\bin\bash.exe"
if not defined GIT_BASH if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "GIT_BASH=%ProgramFiles(x86)%\Git\bin\bash.exe"
if not defined GIT_BASH if exist "%LocalAppData%\Programs\Git\bin\bash.exe" set "GIT_BASH=%LocalAppData%\Programs\Git\bin\bash.exe"
if not defined GIT_BASH (
  echo Git Bash est introuvable. Installez Git pour Windows.
  pause
  exit /b 1
)
"%GIT_BASH%" --login "./lancer-pirate.sh"
if errorlevel 1 pause
