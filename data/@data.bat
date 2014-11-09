del /f 360.txt Mwsl.txt 1.txt 2.txt rd3rd.txt
wget -q -O- http://webscan.360.cn/url | gawk "BEGIN {print \"#360 MTPL\"};/\.html/{print $0=gensub(/.*url\/(.+)\.html.*/,\"127.0.0.1 \\1\",\"1\")}">1.txt
gawk "!a[$0]++" 1.txt >360.txt
wget -q -O- http://dn-mwsl-hosts.qbox.me/hosts | gawk "NR>10{print \"127.0.0.1\",$2}">2.txt
gawk "!a[$0]++" 2.txt >mwsl.txt
sed -i "1i\#MWSL Lists" mwsl.txt
rem https://www.dropbox.com/sh/lw0ljk3sllmimpz/sMifu8lErM https://www.dropbox.com/sh/lw0ljk3sllmimpz/AADvmg0wxOXHAtLQ9WhPlvAva/imouto.host.txt?dl=1
rem wget -c --no-check-certificate -O imouto.txt https://raw.githubusercontent.com/zxdrive/imouto.host/master/imouto.host.txt  https://raw.githubusercontent.com/txthinking/google-hosts/master/hosts sed -i "1i\#redirect (Powered by sundys)" grd.txt
wget -c --no-check-certificate -O grd.txt https://raw.githubusercontent.com/sundys/android/master/hosts
sed -i "s/\t/ /g" grd.txt
rem 将文件内的TAB替换为空格
sed -i "s/[ ]\{2,\}/ /g" grd.txt
rem 将文件内的三个空格替换为空格
sed -i "/googlesyndication/d" grd.txt
sed -i "/google-analytics/d" grd.txt
sed -i "/googleadservices/d" grd.txt
sed -i "/mtalk.google.com/d" grd.txt
sed -i "/127.0.0.1/d" grd.txt
sed -i "/^$/d" grd.txt
sed -i "/^#/d" grd.txt
gawk "!a[$0]++" grd.txt >rd3rd.txt
del /f grd.txt 2.txt
@echo off
ver=0.2.1.8
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
start hosts.vbs
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
set files=bat.txt Version.txt redirect.txt rd3rd.txt mobile.txt msoft.txt xunlei.txt game.txt active.txt soft.txt site.txt sitecn.txt sitecbs.txt down.txt porn.txt email.txt operators.txt popups.txt
for %%a in (%files%) do (type "%%a">>1A.txt)
goto :eof

:bat
echo title SimpleU Hosts >bat.txt
echo more +5 %%~fs0^>%%systemroot%%\system32\drivers\etc\hosts >>bat.txt
echo notepad %%windir%%\system32\drivers\etc\hosts >>bat.txt
echo goto :eof >>bat.txt
goto :eof

:del
del /f hosts google.txt smart.txt Facebook.txt Twitter.txt dropbox.txt flickr.txt wiki.txt wordpress.txt yfrog.txt Version.txt Xunlei.txt SDall.txt Android.txt bat.txt 0.txt 1.txt 1A.txt
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


:delete
wget -c -N --no-check-certificate https://raw.github.com/davidsun/HostsFile/master/hosts -O test.txt
sed -n -e "/flickr.com/w flickr.txt" smart.txt
sed -i "1i\#Flickr" flickr.txt
sed -n -e "/box.com/w dropbox.txt" -e "/dropbox.com/w dropbox.txt" hosts
sed -i "1i\#BoxMore" dropbox.txt
sed -n -e "/facebook./w Facebook.txt" -e "/fbcdn.net/w Facebook.txt" hosts
sed -i "/^#/d" Facebook.txt
sed -i "/127.0.0.1/d" Facebook.txt
sed -i "1i\#Facebook" Facebook.txt
sed -n -e "/www.g.cn/w google.txt"  -e "/gmail.com/w google.txt" -e "/google/w google.txt" -e "/appspot.com/w google.txt" -e "/ggpht.com/w google.txt" -e "/gstatic./w google.txt" -e "/youtube.com/w google.txt" -e "/panoramio.com/w google.txt" hosts
sed -i "1i\#Google Services" google.txt
sed -n -e "/twimg/w Twitter.txt" -e "/twitter./w Twitter.txt" -e "/.tinypic./w Twitter.txt" -e "/tweetdeck./w Twitter.txt" -e "/twitpic./w Twitter.txt" -e "/twitgoo./w Twitter.txt" -e "/mobilepicture.com/w Twitter.txt" -e "/bitly.com/w Twitter.txt" -e "/yfrog./w Twitter.txt" hosts
sed -i "/^#/d" Twitter.txt
sed -i "1i\#Twitter" Twitter.txt
sed -n -e "/wordpress.com/w wordpress.txt" -e "/.wp.com/w wordpress.txt" -e "/ccfox.info/w wordpress.txt" hosts
sed -i "1i\#Wordpress" wordpress.txt
sed -n -e "/wikibooks.org/w wiki.txt" -e "/wikidata.org/w wiki.txt" -e "/wikimedia.org/w wiki.txt" -e "/wikimediafoundation.org/w wiki.txt" -e "/wikinews.org/w wiki.txt" -e "/wikiquote.org/w wiki.txt" -e "/wikisource.org/w wiki.txt" -e "/wikiversity.org/w wiki.txt" -e "/wikivoyage.org/w wiki.txt" -e "/wiktionary.org/w wiki.txt" -e "/wikipedia.org/w wiki.txt" hosts
sed -i "1i\#Wiki" wiki.txt
set files=dropbox.txt Facebook.txt google.txt Twitter.txt wordpress.txt wiki.txt
for %%a in (%files%) do (type "%%a">>imouto.txt)

sed -i "1,55d" hosts
sed -i "/^$/d" hosts
sed -i "/^#/d" hosts
sed -i "/.c.youtube.com/d" hosts
sed -i "/multiupload.com/d" hosts
sed -i "/soutong./d" hosts
sed -i "/5isotoi5.org/d" hosts
sed -i "/.sandai.net/d" hosts
sed -i "/flashget.com/d" hosts
sed -i "/googlesyndication/d" hosts
sed -i "/google-analytics/d" hosts
sed -i "/googleadservices/d" hosts
sed -i "s/\t/ /g" hosts
rem 将文件内的TAB替换为空格
goto :eof

