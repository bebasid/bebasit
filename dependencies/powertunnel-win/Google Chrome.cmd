@ECHO off
TASKKILL /IM chrome.exe /F
cls
echo "Sedang membuka Google Chrome"
timeout /t 10
cls
start chrome www.netflix.com --proxy-server=http://127.0.0.1:6151 --proxy-bypass-list="<-loopback>"
echo "Aplikasi ini tidak dapat ditutup selama masih streaming"
echo "Untuk memberhentikan, cukup tekan [Enter]"
pause
TASKKILL /IM chrome.exe /F
TASKKILL /IM java.exe /F
TASKKILL /IM cmd.exe /F
TASKKILL /IM ConEmu.exe /F
TASKKILL /IM ConEmu64.exe /F
echo "Sukses memberhentikan"
exit