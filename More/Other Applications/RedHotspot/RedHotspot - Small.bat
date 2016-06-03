@echo off
netsh wlan start hostednetwork>"%temp%\RedHotspot_Log"||goto :ErrorSetup
exit