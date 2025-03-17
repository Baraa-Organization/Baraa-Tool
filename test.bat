@echo off
for %%i in (unnstall_onedrive.ps1) do (
    powershell -ExecutionPolicy Bypass -File "%%i"
)

pause