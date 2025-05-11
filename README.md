# log_tool
1.修改权限
```bash
chmod +x archive log-archive.sh
```
2.执行
```bash
./log-archive.sh /var/log
```
3.定时
```bash
cron_line= "* * * 10 * /path:log-archive.sh"
(crontab -l 2>/dev/null; echo "$cron_line") | crontab -
```