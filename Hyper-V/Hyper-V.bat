@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo "Please reboot when it asks"
pause

for %%f in ( %SystemRoot%\servicing\Packages\*Hyper-V*.mum) do dism /online /norestart /add-package:"%%f" 
dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL

echo "Done"
timeout 10