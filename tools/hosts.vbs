Set objFSO = CreateObject("Scripting.FileSystemObject")
objFSO.DeleteFile("C:\WINDOWS\system32\drivers\etc\hosts"), True
Sub download(url,target)
        Const adTypeBinary = 1
        Const adTypeText = 2
        Const adSaveCreateOverWrite = 2
        Dim http,ado
        Set http = CreateObject("Msxml2.ServerXMLHTTP")
        http.SetOption 2,13056
        http.open "GET",url,False
        http.send
        Set ado = createobject("Adodb.Stream")
        ado.Type = adTypeBinary
        ado.Open
        ado.Write http.responseBody
        ado.SaveToFile target,adSaveCreateOverWrite
        ado.Close
End Sub
Set WshShell=CreateObject("WScript.Shell")
WinDir =WshShell.ExpandEnvironmentStrings("%WinDir%")
HostsFile = WinDir & "\System32\Drivers\etc\hosts"
Const hosts="https://raw.githubusercontent.com/vokins/simpleu/master/hosts"
download hosts,HostsFile
'wshshell.run "cmd /c sc config Dnscache start= auto",0  '启用DNSCache服务
'wshshell.run "cmd /c sc start DNSCache",0  '开启DNSCache服务
wshshell.run "cmd /c ipconfig /flushdns",0  '刷新DNS
MsgBox "hosts 数据已更新！", vbInformation, "SimpleU"
