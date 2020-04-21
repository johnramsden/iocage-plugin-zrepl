#!/bin/sh

# Create the log file /var/log/zrepl.log
touch /var/log/zrepl.log && service newsyslog restart > /dev/null

# Tell syslogd to redirect facility local0 to the zrepl.log file
service syslogd reload > /dev/null

# Enable the service
sysrc -f /etc/rc.conf zrepl_enable="YES" > /dev/null

echo '
zrepl is now installed

A ZFS dataset must be delegated into the zrepl jail. Create a dataset on the
host if one was not delegated during jail creation, stop the plugin jail,
and set the following iocage property:

    jail_zfs_dataset=<delegated dataset>

The "<delegated dataset>" should not contain the pool name.

Then start the plugin.

Now the configuration file located at "/usr/local/etc/zrepl/zrepl.yml"
within the zrepl jail can be edited and zrepl can be used.

For zrepl documentation see https://zrepl.github.io/
' > /root/PLUGIN_INFO

cat /root/PLUGIN_INFO
