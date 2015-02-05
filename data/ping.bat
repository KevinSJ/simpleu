@echo off
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
(for /f %%i in (google.txt) do (
    for /f "skip=1 tokens=2 delims=[]" %%j in ('ping -n 1 %%i') do (
        echo %%j %%i
    )
))>grd.txt
pause&exit
taskkill /f /t /im pinginfoview.exe
taskkill /f /t /im ping.exe

(for /f %%i in (1list.txt) do (
    for /f "skip=1 tokens=2 delims=[]" %%j in ('ping -n 1 %%i') do (
        echo %%j %%i
    )
))>rd3rd.txt
pinginfoview.exe /loadfile google.txt /stab grd.txt

sed "/^#/d" google.txt>g1.txt
pinginfoview.exe /loadfile g1.txt /stab gg.txt
sed "/^#/d" 1list.txt>g2.txt
pinginfoview.exe /loadfile g2.txt /stab g3.txt
copy /a gg.txt + g3.txt rd3rd.txt
del /f g1.txt g2.txt g3.txt