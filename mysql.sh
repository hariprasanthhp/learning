#!/usr/bin/bash
sudo apt update
#remove old mysql
#echo'removuing old mysql server'
#echosudo apt purge mysql-server* && sudo rm -r /etc/mysql /var/lib/mysql && sudo rm -r /var/log/mysql && sudo apt remove --purge mysql-server && sudo apt purge mysql-server && sudo apt remove dbconfig-mysql && sudo systemctl stop mysql && sudo apt purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-* && sudo apt autoremove && sudo apt autoclean
# reinstall mysql
#Step 1: Add MySQL APT repository
# Install MySQL Server
#Ubuntu 22.04 already comes with MySQL 8.0 packages. You can skip repository addition on Ubuntu 22.04, only perform the operation on Ubuntu 20.04.
sudo apt update
sudo apt install wget -y
#Download the repository using the below command:
wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb
#Once downloaded, install the repository by running the command below:
sudo dpkg -i mysql-apt-config_0.8.12-1_all.deb
#Choose MySQL ubuntu focal if OS is not detected.
#The next prompt shows MySQL 8.0 chosen by default. Choose the first option and click OK
#In the next prompt, select MySQL 8.0 server and click OK.
#The next prompt selects MySQL8 by default. Choose the last option Ok and click OK.
#Step 2: Update MySQL Repository
sudo apt-get update
#Now search for MySQL 8.0 using apt cache as shown below:
sudo apt-cache policy mysql-server
#Step #3: Install MySQL 5.7 on Ubuntu 22.04 LTS
#Before Installing MySQL 5.7 you need to run this command:
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29
#Update your system package:
sudo apt update
#we are going to install MySQL 5.7 client, MySQL 5.7 server with the below command:
sudo apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*
#Enter and re-enter root password:
#Step #4: Secure MySQL 5.7 Installation on Ubuntu 22.04LTS:
#Run the following commands
sudo mysql_secure_installation
#Provide the root password set above and you will have output like this:
# Prompt for username and password
read -p "Enter MySQL username: " usrnm
read -s -p "Enter MySQL password: " passwd
echo
# Create a new MySQL user and grant privileges
sudo mysql -u root -p <<EOF
CREATE USER '$usrnm'@'%' IDENTIFIED BY '$passwd';
GRANT ALL PRIVILEGES ON mydb.* TO 'usrnm'@'%';
FLUSH PRIVILEGES;
exit;
EOF
#Step #7: Enable MySQL remote access
#By default, In MySQL database server remote access is disabled for security reason.
#To enable remote connections of MySQL Server, we have to change bind-address in MySQL configuration file.
#Open the /etc/mysql/mysql.conf.d/mysqld.cnf file
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf
#Save the file and restart mysql
sudo systemctl restart mysql
sudo systemctl status mysql

