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
HostsFile = WinDir & "\System32\Drivers\etc\Hosts"
Const hosts="https://raw.githubusercontent.com/vokins/simpleu/master/hosts"
download hosts,HostsFile