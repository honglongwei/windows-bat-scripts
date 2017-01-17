@ECHO OFF
net user Administrator 123456
SC CONFIG sshd OBJ= .\Administrator PASSWORD= 123456
net stop sshd
net start sshd
SC CONFIG cron OBJ= .\Administrator PASSWORD= 123456
net stop cron
net start cron
