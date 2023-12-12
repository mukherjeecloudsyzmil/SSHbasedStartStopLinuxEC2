#!/usr/bin/perl

use strict;
use warnings;
use Net::OpenSSH;

# Set the threshold for CPU usage
my $cpu_threshold = 90;

# Get the current CPU usage for MySQL
my $mysql_cpu = `ps aux | grep mysql | grep -v grep | awk '{print \$3}'`;

# Remove leading/trailing whitespaces
$mysql_cpu =~ s/^\s+|\s+$//g;

# Compare the CPU usage with the threshold
if ($mysql_cpu > $cpu_threshold) {
    print "MySQL CPU usage is over $cpu_threshold%. Restarting MySQL and Application Server.\n";

    # Replace 'your_mysql_password' with the actual password for your MySQL server
    my $mysql_password = 'Sandip@1997';
    
    # Connect to MySQL server
    my $ssh_mysql = Net::OpenSSH->new('ubuntu@13.234.36.120', password => $mysql_password);
    
    # Restart MySQL
    $ssh_mysql->system('systemctl restart mysql');

    # Replace 'your_app_server_password' with the actual password for your application server
    my $app_server_password = 'Sandip@@1997';

    # Connect to Application server
    my $ssh_app = Net::OpenSSH->new('ubuntu@65.0.249.242', password => $app_server_password);

    # Replace 'your_app_server_command' with the actual command to restart your application server on the remote machine
    $ssh_app->system('sudo reboot');
} else {
    print "MySQL CPU usage is below $cpu_threshold%. No action required.\n";
}
