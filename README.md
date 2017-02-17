# Zabbix Bind9 Statistics Collection (Zabbix-sender version)

[![Join the chat at https://gitter.im/Zabbix-Bind9-Statistics-Collection/Lobby](https://badges.gitter.im/Zabbix-Bind9-Statistics-Collection/Lobby.svg)](https://gitter.im/Zabbix-Bind9-Statistics-Collection/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This method utilises Bind 9s built in statistics export via HTTP/XML.

I am using it with Zabbix-Sender because my DNS has more than 200 zones, and it generates more than 11000 items. It is impossible to use the pooling method of Zabbix.

Most statistics available are collected, several aggregate graphs are defined.

[Forked from https://github.com/Pesticles/Zabbix-Bind9-Statistics-Collection](https://github.com/Pesticles/Zabbix-Bind9-Statistics-Collection)

## Requirements
* Zabbix 3.X.X
* Python 3


## To install:
* Configure Bind to export statistics via HTTP by adding the following to your bind.conf and restarting bind:
```
statistics-channels {
 	inet 127.0.0.1 port 8653 allow { 127.0.0.1; };
};
```
* Copy the userparameter_bind.conf into your zabbix agents include directory (/etc/zabbix/zabbix_agentd.d/ on Debian/Ubuntu)
* Copy the scripts "bind-stats.py" and "send_bindcounters_zabbix.sh" to /usr/local/bin/ (or anywhere else you like, but you will need to alter the contents of userparameter_bind.conf)
* Your server hostname must be the same of the Zabbix in frontend or you will need use the "-s \<hostname\>" zabbix-sender argument in the script "send_bindcounters_zabbix.sh"
* Configure the script "send_bindcounters_zabbix.sh" to your scenario
* Import the xml template into Zabbix (zbx_bind_statistics_trapper_template_v3.xml for Zabbix 3.X.X)
* Configure crontab to run the "send_bitcounters_zabbix.sh"
```
*/2 * * * *     root  /usr/local/bin/send_bindcounters_zabbix.sh >/dev/null 2>&1
```
## Note:

You can enable per-zone statistics (which will be automatically discovered) by adding the following clause to each zone definition in your bind.conf:
`zone-statistics yes;`
