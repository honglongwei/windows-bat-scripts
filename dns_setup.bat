netsh interface ip set dnsservers "本地连接 4" static 10.1.1.2 both
netsh interface ip add dns "本地连接 4" 100.123.23.56
netsh interface ip add dns "本地连接 4" 100.123.23.136
