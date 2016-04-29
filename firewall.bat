@echo off
echo 正在创建防火墙安全策略 mrdTomcat
echo ipsec static delete all > c:/temp.ips

rem 创建安全策略mrdTomcat
echo ipsec static add policy name = mrdTomcat >> c:/temp.ips

rem 创建筛选器操作
echo ipsec static add filteraction name = allow action = permit >> c:/temp.ips
echo ipsec static add filteraction name = deny action = block  >> c:/temp.ips

rem 自身连接
echo ipsec static add filterlist name = allow_me >> c:/temp.ips
echo ipsec static add filter filterlist = allow_me srcaddr = me dstaddr = 10.0.0.0 dstmask = 255.0.0.0  protocol = any  mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = allow_me srcaddr = me dstaddr = 100.0.0.0 dstmask = 255.0.0.0  protocol = any  mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = allow_me srcaddr = me dstaddr = 127.0.0.1 protocol = any  mirrored = yes  >> c:/temp.ips
echo ipsec static add filter filterlist = allow_me srcaddr = me dstaddr = 1.1.1.1  protocol = any  mirrored = yes  >> c:/temp.ips

rem 中控连接22
echo ipsec  static add filterlist name = allow_22 >> c:/temp.ips
echo ipsec static add filter filterlist = allow_22 srcaddr = 1.1.1.1 dstaddr = me dstport = 22 description = cc_access protocol = TCP mirrored = yes >> c:/temp.ips

rem 连接3389
echo ipsec  static add filterlist name = allow_3389 >> c:/temp.ips
echo ipsec static add filter filterlist = allow_3389 srcaddr = 1.1.1.1 dstaddr = me dstport = 3389 description = cc_access protocol = TCP mirrored = yes >> c:/temp.ips

rem 连接日志备份机
echo ipsec  static add filterlist name = allow_logback >> c:/temp.ips
echo ipsec static add filter filterlist = allow_logback srcaddr = me  dstaddr = any dstport = 873 description = gs_to_logback protocol = TCP mirrored = yes >> c:/temp.ips

rem zabbix
echo ipsec  static add filterlist name = allow_zabbix >> c:/temp.ips
echo ipsec static add filter filterlist = allow_zabbix srcaddr = 1.1.1.1  dstaddr = me dstport = 10050 description = zabbix_to_me protocol = TCP mirrored = yes >> c:/temp.ips

rem axis
echo ipsec  static add filterlist name = allow_axis >> c:/temp.ips
echo ipsec static add filter filterlist = allow_axis srcaddr = me  dstaddr = any dstport = 19677  description = me_to_axis protocol = TCP mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = allow_axis srcaddr = me  dstaddr = any dstport = 19577  description = me_to_axis protocol = TCP mirrored = yes >> c:/temp.ips

rem DNS
echo ipsec  static add filterlist name = allow_dns >> c:/temp.ips
echo ipsec static add filter filterlist = allow_dns srcaddr = me  dstaddr = any dstport = 53  description = me_to_dns  protocol = TCP mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = allow_dns srcaddr = me  dstaddr = any dstport = 53  description = me_to_dns  protocol = UDP mirrored = yes >> c:/temp.ips

rem ntp 
echo ipsec static add filterlist name = allow_ntp >> c:/temp.ips
echo ipsec static add filter filterlist = allow_ntp srcaddr = me  dstaddr = any dstport = 123  description = me_to_ntp  protocol = UDP mirrored = yes >> c:/temp.ips


rem 程序
echo ipsec  static add filterlist name = allow_gs >> c:/temp.ips
rem  10网段 内网出入信任
echo ipsec static add filter filterlist = allow_gs srcaddr = me  dstaddr = 10.0.0.0 dstmask = 255.0.0.0 description = to_inter protocol = TCP mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = allow_gs srcaddr = any dstaddr = me dstport = 10721  description = to_inter protocol = TCP mirrored = yes >>c:/temp.ips

rem SaltstackServer
echo ipsec static add filter filterlist = allow_me srcaddr = me dstaddr = 1.1.1.1  protocol = any  mirrored = yes  >> c:/temp.ips

rem BI
echo ipsec static add filter filterlist = allow_gs srcaddr = me dstaddr = 1.1.1.1 dstport = 9094  description = to_inter protocol = TCP mirrored = yes >>c:/temp.ips

rem puppet
echo ipsec static add filterlist name = allow_puppet >> c:/temp.ips
echo ipsec static add filter filterlist = allow_puppet srcaddr = me  dstaddr = 1.1.1.1 dstport = 55120 description = puppet protocol = TCP mirrored = yes >> c:/temp.ips

rem 拒绝其他所有ip
echo ipsec  static add filterlist name = deny_all >> c:/temp.ips
rem echo ipsec static add filter filterlist = deny_all srcaddr = me dstaddr = any dstport = 0  protocol = any mirrored = yes >> c:/temp.ips
echo ipsec static add filter filterlist = deny_all srcaddr = any dstaddr = me dstport = 0  protocol = any mirrored = yes >> c:/temp.ips

rem 创建安全策略mrdTomcat规则
echo ipsec static add rule name = allow_puppet Policy = mrdTomcat filterlist = allow_puppet  filteraction = allow >> c:/temp.ips
echo ipsec static add rule name = allow_me Policy = mrdTomcat filterlist = allow_me filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_22 Policy = mrdTomcat filterlist = allow_22 filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_3389  Policy = mrdTomcat filterlist = allow_3389  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_logback  Policy = mrdTomcat filterlist = allow_logback  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_zabbix  Policy = mrdTomcat filterlist = allow_zabbix  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_axis  Policy = mrdTomcat filterlist = allow_axis  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_dns  Policy = mrdTomcat filterlist = allow_dns  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_gs  Policy = mrdTomcat filterlist = allow_gs  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = allow_ntp  Policy = mrdTomcat filterlist = allow_ntp  filteraction = allow   >> c:/temp.ips
echo ipsec static add rule name = deny_all Policy = mrdTomcat filterlist = deny_all filteraction = deny  >> c:/temp.ips

rem 激活安全策略mrdTomcat
echo ipsec static set policy name = mrdTomcat assign = y >> c:/temp.ips

netsh -f "c:/temp.ips"
del "c:/temp.ips"
echo "创建mrdTomcat ok"