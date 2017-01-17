net start w32time
w32tm /config /manualpeerlist:8.8.8.8 /syncfromflags:MANUAL
w32tm /config /update
w32tm /resync
