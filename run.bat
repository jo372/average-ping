@echo off
SET PING_IP=8.8.8.8
SET MAX_REQUESTS=10
powershell -ExecutionPolicy Bypass -File .\average-ping.ps1 %PING_IP% %MAX_REQUESTS%
pause
