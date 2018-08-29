# Monitor
The script displays such information about the system as:
  - Internet connection
  - OS
  - Architecture
  - Kernel Release
  - Hostname
  - Internal IP
  - External IP
  - Name Servers
  - Logged In users
  - Ram usage 
  - Disk Usages 
  - Load Average 
  - Uptime
  
 The script is run when you log on to the system or through the command "monitor".
 Works in such systems as CentOS 6 CentOS 7 Debian 8 Debian 9 Ubuntu 14 and higher.
# Preview:
![Start as command](https://github.com/flover97/monitor/blob/master/monitor.png)
![startup at session entry](https://github.com/flover97/monitor/blob/master/monitor2.png)


# For the script to work properly you need:
  - curl
  - wget

### Installation with git:
Please start script as root.
```sh
$ git clone https://github.com/flover97/monitor.git
$ cd monitor
$ chmod +x monitor-0.0.3.sh
# ./monitor-0.0.3.sh
```
### Installation with wget:
```sh
$ wget https://github.com/flover97/monitor/archive/master.zip
$ unzip master.zip
$ cd monitor-master
$ chmod +x monitor-0.0.3.sh
# ./monitor-0.0.3.sh
```
