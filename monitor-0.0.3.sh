#!/bin/bash
#========================================================
#Variables
#========================================================
script=/usr/bin/monitor
tdir=$(mktemp -d /tmp/monitor.XXXXXXXXX)
#========================================================
#===Clear old versions===================================
#========================================================
if [ -e "$script" ]; then

        </etc/passwd grep /bash | cut -d: -f6 >> "$tdir/home-rm.tmp"

        while read -r home
        do
                find "$home"  -iname ".*hrc" >> "$tdir/hrc-rm.tmp"
                find "$home"  -iname ".*profile" >> "$tdir/profile-rm.tmp"
        done <"$tdir/home-rm.tmp"

        while read -r hrc
        do
                sed -i 's@alias monitor="sh /usr/bin/monitor"@@' "$hrc"
        done <"$tdir/hrc-rm.tmp"

        while read -r profile
        do
                sed -i 's@/usr/bin/monitor@@' "$profile"
        done <"$tdir/profile-rm.tmp"
        rm -rf /tmp/monitor.*/*

fi
#========================================================
#===Instalation==========================================
#========================================================
</etc/passwd grep /bash | cut -d: -f6 >> "$tdir/home.tmp"

while read -r home
do
        find "$home"  -iname ".*hrc" >> "$tdir/hrc.tmp"
        find "$home"  -iname ".*profile" >> "$tdir/profile.tmp"
done <"$tdir/home.tmp"


while read -r hrc
do
        echo 'alias monitor="sh /usr/bin/monitor"' >>"$hrc"
done <"$tdir/hrc.tmp"


while read -r profile
do
        echo '/usr/bin/monitor' >>"$profile"
done <"$tdir/profile.tmp"
#============================================================


cat  << "EOF" > $script

#Script body==============
#!/bin/bash

script=/usr/bin/monitor
tdir=$(mktemp -d /tmp/monitor.XXXXXXXXX)




echo "==============================================================================="
if ! wget -q --spider http://google.com
then
        echo  "Internet:  Disconnected"
else
        echo  "Internet:  Connected"
fi

# Check OS Release Version and Name
echo "==============================================================================="
name=$(</etc/os-release grep 'PRETTY_NAME=' | cut -f2 -d\")
echo "OS :" "$name"

# Check Architecture
echo "==============================================================================="
architecture=$(uname -m)
echo "Architecture :"  "$architecture"

# Check Kernel Release
echo "==============================================================================="
kernelrelease=$(uname -r)
echo "Kernel Release :"  "$kernelrelease"

# Check Hostname
echo "==============================================================================="
hostname=$(hostname)
echo "Hostname :"  "$hostname"

# Check Internal IP
echo "==============================================================================="
internalip=$(hostname -I)
echo "Internal IP :"  "$internalip"

# Check External IP
echo "==============================================================================="
externalip=$(curl -s ipecho.net/plain;echo)
echo "External IP :" "$externalip"

# Check DNS
echo "==============================================================================="
nameservers=$(</etc/resolv.conf grep "nameserver" | awk '{print $2}')
echo "Name Servers :"
echo "$nameservers"

# Check Logged In Users
echo "==============================================================================="
echo "Logged In users :"
who

# Check RAM and SWAP Usages
echo "==============================================================================="
echo "Ram usage :"
free -h | head -n1 -n2

# Check Disk Usages
echo "==============================================================================="
df -h| grep 'Filesystem\|/dev/sda*\|/dev/mapper*\|/dev/dm*' >> "$tdir/diskusage.tmp"
echo "Disk Usages :"
cat "$tdir/diskusage.tmp"

# Check Load Average
echo "==============================================================================="
loadaverage=$(/proc/loadavg <awk '{print $1,$2,$3}')
echo "Load Average :"  "$loadaverage"

# Check System Uptime
echo "==============================================================================="
uptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo "System Uptime Days/(HH:MM) :"  "$uptime"
echo "==============================================================================="

EOF

chmod +x $script
rm -rf /tmp/monitor.*

echo "==============================================================================="
echo  "Job Done つ◕◡◕つ"
echo  Instalation directory: $script
echo  "To call script enter: monitor"
echo "==============================================================================="
