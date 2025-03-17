@echo off
color 0a
:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)
:: Admin-only commands go here
echo Running as Administrator!

cls

echo Download/Upgrade wnget
winget install Microsoft.AppInstaller

:main

cls
color 0a

echo ------------------------------------
echo "---------| Baraa Tool |-------------"
echo ------------------------------------
echo 1 - Upgrade all installed apps
echo 2 - Install Applications
echo 3 - Uninstall Applications
echo 4 - Scan/Cleanup
echo 5 - onedrive/edge
echo 0 - Exit
echo.
set /p program=Choose an option: 

if "%program%"=="1" goto :upgrade
if "%program%"=="2" goto :install
if "%program%"=="3" goto :uninstall
if "%program%"=="4" goto :scan
if "%program%"=="5" goto :onedrive/edge
if "%program%"=="0" goto :end
goto :main

:upgrade
cls

winget upgrade --all
if %errorLevel% neq 0 echo Winget upgrade failed.
echo Installed application list:
winget list
pause
goto :main

:scan
cls
color 0a

cleanmgr /sageset:1
echo Check it all for smoother expierence ";)"
pause

sfc /scannow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth 
pause
goto :main

:install
cls
color 0a

echo -------- Install Applications --------
echo 1 - Discord
echo 2 - Logitech G HUB
echo 3 - ProtonVPN
echo 4 - Java 8
echo 5 - NVIDIA PhysX System
echo 6 - Brave
echo 7 - PowerShell 7
echo 8 - Google Chrome
echo 9 - OBS Studio
echo 10 - Steam
echo 11 - VisualStudio 2022
echo 12 - VisualStudio code
echo 13 - AnyDesk
echo 14 - LibreOffice 
echo 15 - Revo Uninstaller
echo 16 - WinRAR
echo 17 - GitHub Desktop
echo 18 - Oracle VirtualBox
echo 100 - Install All (not recommended)
echo 0 - Back to menu
echo --------------------------------------
set /p input=Enter option: 
if "%input%"=="0" goto :main
if "%input%"=="100" goto :install_all
call :install_app "%input%"
pause
goto :install

:install_app
setlocal EnableDelayedExpansion
set app=
if "%~1"=="1" set app=Discord.Discord
if "%~1"=="2" set app=Logitech.GHUB
if "%~1"=="3" set app=Proton.ProtonVPN
if "%~1"=="4" set app=Oracle.JavaRuntimeEnvironment
if "%~1"=="5" set app=Nvidia.PhysX
if "%~1"=="6" set app=Brave.Brave
if "%~1"=="7" set app=Microsoft.PowerShell
if "%~1"=="8" set app=Google.Chrome
if "%~1"=="9" set app=OBSProject.OBSStudio
if "%~1"=="10" set app=Valve.Steam
if "%~1"=="11" set app=Microsoft.VisualStudio.2022.Community
if "%~1"=="12" set app=Microsoft.VisualStudioCode
if "%~1"=="13" set app=AnyDeskSoftwareGmbH.AnyDesk
if "%~1"=="14" set app=TheDocumentFoundation.LibreOffice
if "%~1"=="15" set app=RevoUninstaller.RevoUninstaller
if "%~1"=="16" set app=RARLab.WinRAR
if "%~1"=="17" set app=GitHub.GitHubDesktop
if "%~1"=="18" set app=Oracle.VirtualBox
if not "%app%"=="" (
    echo Installing !app!
    winget install -e --id !app!
    if %errorLevel% neq 0 echo Installation of !app! failed.
)
exit /b

:install_all
for %%A in (Discord.Discord Logitech.GHUB Proton.ProtonVPN Oracle.JavaRuntimeEnvironment Nvidia.PhysX Brave.Brave Microsoft.PowerShell Google.Chrome OBSProject.OBSStudio Valve.Steam Microsoft.VisualStudio.2022.Community Microsoft.VisualStudioCode TheDocumentFoundation.LibreOffice RevoUninstaller.RevoUninstaller) do (
    echo Installing %%A
    winget install -e --id %%A
    if %errorLevel% neq 0 echo Installation of %%A failed.
    timeout /t 3
)
pause
goto :main

:uninstall
cls
color 0a

echo -------- Uninstall Applications --------
echo 1 - Discord
echo 2 - Logitech G HUB
echo 3 - ProtonVPN
echo 4 - Java 8
echo 5 - NVIDIA PhysX System
echo 6 - Brave
echo 7 - PowerShell 7
echo 8 - Google Chrome
echo 9 - OBS Studio
echo 10 - Steam
echo 11 - VisualStudio 2022
echo 12 - VisualStudio code
echo 13 - AnyDesk
echo 14 - LibreOffice 
echo 15 - Revo Uninstaller
echo 16 - WinRAR
echo 17 - GitHub Desktop
echo 18 - Oracle VirtualBox
echo 100 - Uninstall All (not recommended)
echo 0 - Back to menu
echo --------------------------------------
set /p input=Enter option: 
if "%input%"=="0" goto :main
if "%input%"=="100" goto :uninstall_all
call :uninstall_app "%input%"
pause
goto :uninstall

:uninstall_app
setlocal EnableDelayedExpansion
set app=
if "%~1"=="1" set app=Discord.Discord
if "%~1"=="2" set app=Logitech.GHUB
if "%~1"=="3" set app=Proton.ProtonVPN
if "%~1"=="4" set app=Oracle.JavaRuntimeEnvironment
if "%~1"=="5" set app=Nvidia.PhysX
if "%~1"=="6" set app=Brave.Brave
if "%~1"=="7" set app=Microsoft.PowerShell
if "%~1"=="8" set app=Google.Chrome
if "%~1"=="9" set app=OBSProject.OBSStudio
if "%~1"=="10" set app=Valve.Steam
if "%~1"=="11" set app=Microsoft.VisualStudio.2022.Community
if "%~1"=="12" set app=Microsoft.VisualStudioCode
if "%~1"=="13" set app=AnyDeskSoftwareGmbH.AnyDesk
if "%~1"=="14" set app=TheDocumentFoundation.LibreOffice
if "%~1"=="15" set app=RevoUninstaller.RevoUninstaller
if "%~1"=="16" set app=RARLab.WinRAR
if "%~1"=="17" set app=GitHub.GitHubDesktop
if "%~1"=="18" set app=Oracle.VirtualBox
if not "%app%"=="" (
    echo Uninstalling !app!
    winget uninstall -e --id !app!
    if %errorLevel% neq 0 echo Uninstallation of !app! failed.
)
exit /b

:uninstall_all
for %%A in (Discord.Discord Logitech.GHUB Proton.ProtonVPN Oracle.JavaRuntimeEnvironment Nvidia.PhysX Brave.Brave Microsoft.PowerShell Google.Chrome OBSProject.OBSStudio Valve.Steam Microsoft.VisualStudio.2022.Community Microsoft.VisualStudioCode TheDocumentFoundation.LibreOffice RevoUninstaller.RevoUninstaller) do (
    echo Uninstalling %%A
    winget uninstall -e --id %%A
    if %errorLevel% neq 0 echo Uninstallation of %%A failed.
    timeout /t 3
)
pause
goto :main

:onedrive/edge

for %%i in (unnstall_onedrive.ps1) do (
    powershell -ExecutionPolicy Bypass -File "%%i"
)




:end
echo Press Enter to exit
pause
exit

