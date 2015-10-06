del /f 360.txt Mwsl.txt 1.txt 2.txt rd3rd.txt
rem wget -q -O- http://webscan.360.cn/url | gawk "BEGIN {print \"#360 MTPL\"};/\.html/{print $0=gensub(/.*url\/(.+)\.html.*/,\"127.0.0.1 \\1\",\"1\")}">1.txt
rem gawk "!a[$0]++" 1.txt >360.txt
rem wget -q -O- http://www.mwsl.org.cn/hosts/hosts | gawk "NR>10{print \"127.0.0.1\",$2}">2.txt
rem gawk "!a[$0]++" 2.txt >mwsl.txt
rem sed -i "1i\#MWSL Lists" mwsl.txt
set p1=http://serve.netsh.org/pub/ping.php
set p2=http://tools.pingdom.com/ping/
set p3=http://ping.eu/ping
rem http://www.360kb.com/kb/2_139.html http://www.360kb.com/kb/2_143.html
rem http://bbs.a9vg.com/thread-4549081-1-1.html
set s1=https://raw.githubusercontent.com/racaljk/hosts/master/hosts
set s2=https://raw.githubusercontent.com/txthinking/google-hosts/master/hosts
set s3=http://yu2n.sinaapp.com/wp/?p=367
set s4=http://code.taobao.org/svn/gargoyle/hosts
set s5=http://code.taobao.org/svn/dd-wrt/hosts
wget -c --no-check-certificate -O grd.txt %s1%
sed -i "1,18d" grd.txt
sed -i "s/\t/ /g" grd.txt
sed -i "s/[ ]\{2,\}/ /g" grd.txt
sed -i "/googlesyndication/d" grd.txt
sed -i "/google-analytics/d" grd.txt
sed -i "/googleadservices/d" grd.txt
sed -i "/127.0.0.1/d" grd.txt
sed -i "/^$/d" grd.txt
sed -i "/^#/d" grd.txt
sed -i "1i\#redirect" grd.txt
gawk "!a[$0]++" grd.txt >rd3rd.txt
del /f grd.txt
@echo off
ver=0.2.7.5
SetLocal EnableExtensions
SetLocal EnableDelayedExpansion
set str=%date:~0,4%%date:~5,2%00
call :del
call :bat
call :Version
call :Xunlei
call :SDall
ping -n 3 127.0.0.1
ping -n 3 127.0.0.1
copy 1A.txt 0.txt
sed -i "s/127.0.0.1/0.0.0.0/g" 0.txt
start vblf.vbs
ping -n 5 127.0.0.1
copy hosts "%~dp0..\hosts"
call :Android
call :del
cd %~dp0..\tools
7z.bat
exit

:Android
echo 7z x hosts.zip -y -oandroid>"%~dp0..\tools\7z.bat"
echo del %~dp0..\tools\hosts.zip>>"%~dp0..\tools\7z.bat"
echo copy "%~dp0..\hosts" "android\system\etc">>"%~dp0..\tools\7z.bat"
echo 7z a -tzip android.zip %~dp0..\tools\android\META-INF>>"%~dp0..\tools\7z.bat"
echo 7z a -tzip android.zip %~dp0..\tools\android\sdcard>>"%~dp0..\tools\7z.bat"
echo 7z a -tzip android.zip %~dp0..\tools\android\system>>"%~dp0..\tools\7z.bat"
echo rd /s /q android>>"%~dp0..\tools\7z.bat"
echo java -jar signapk.jar -w testkey.x509.pem testkey.pk8 android.zip %~dp0..\tools\hosts.zip>>"%~dp0..\tools\7z.bat"
echo del %~dp0..\tools\android.zip>>"%~dp0..\tools\7z.bat"
echo del %%0 >>"%~dp0..\tools\7z.bat"
goto :eof

:SDall
set files=bat.txt Version.txt redirect.txt grd.txt rd3rd.txt mobile.txt xunlei.txt game.txt active.txt soft.txt site.txt sitecn.txt sitecbs.txt union.txt unioncn.txt cps.txt down.txt porn.txt email.txt operators.txt popups.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
goto :eof

:bat
echo title SimpleU Hosts >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
goto :eof

:del
del /f hosts smart.txt Version.txt Xunlei.txt SDall.txt Android.txt bat.txt 0.txt 1.txt 1A.txt
goto :eof

:Version
echo.>Version.txt
echo ;version=%date:~0,4%%date:~5,2%%date:~8,2%%TIME:~0,2%%TIME:~3,2%>>Version.txt
rem echo ;version=%time% %date%>>Version.txt
echo ;Contributors=KwokTree.OrzFly.jason_jiang.Felix Hsu.linjimmy.ZephyR.atmouse.Ehosts.zhqjsh.JayXon>>Version.txt
echo ;Description=Smart.Clean.Useful.Safe. Hosts-files.>>Version.txt
echo ;Vision=Better Internet Experience and Thanks 4 Every1.>>Version.txt
echo ;Down=https://raw.githubusercontent.com/vokins/simpleu/master/hosts >>Version.txt
goto :eof

:Xunlei
set /a str+=1
echo 0.0.0.0 %str%.biz5.sandai.net >>xunlei.txt
echo 0.0.0.0 %str%.float.sandai.net >>xunlei.txt
echo 0.0.0.0 %str%.logic.cpm.cm.sandai.net >>xunlei.txt
if not %str%==%date:~0,4%%date:~5,2%31 (goto Xunlei)
goto :eof

:mac
rem http://sourceforge.net/projects/dos2unix/
mac2unix -ascii -n Apple.txt out.txt
unix2dos -n out.txt Applenew.txt 
set files=Version.txt Rd.txt Applenew.txt Mobile.txt SiteCN.txt Active.txt Game.txt Soft.txt UnionJP.txt UnionCN.txt Hijack.txt Virus.txt Popups.txt
for %%a in (%files%) do (type "%%a">>hosts.txt)
sed -e "s/0.0.0.0/127.0.0.1/g" hosts.txt > hosts
move /y hosts "%~dp0..\"
goto :eof

:nslookup
(for /f "delims=" %%i in (nslookup.txt) do (
  call :action %%i
))>1n.txt
goto :eof

:action
for /f "skip=4 tokens=1* delims=:" %%j in ('nslookup %1') do (
    echo,%%k   %%i&goto :eof
)
goto :eof

:ping
(for /f %%i in (mysite.txt) do (
    for /f "skip=1 tokens=2 delims=[]" %%j in ('ping -n 1 %%i') do (
        echo %%j %%i
    )
))>ping.txt
goto :eof

sed -i "1,55d" hosts
sed -i "/^$/d" hosts
sed -i "/^#/d" hosts
sed -i "/.c.youtube.com/d" hosts
sed -i "/multiupload.com/d" hosts
sed -i "/5isotoi5.org/d" hosts
sed -i "/.sandai.net/d" hosts
sed -i "/flashget.com/d" hosts
sed -i "s/\t/ /g" hosts
sed -i "s/\t/ /g" gg.txt
sed -i "s/[ ]\{2,\}/ /g" gg.txt
goto :eof
