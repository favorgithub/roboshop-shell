echo -e "\e[33m Disable mysql default Version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Copy mysql Repos\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log


echo -e "\e[33m Installing mysql community Server \e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33m Start mysql Service \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33m Setup  Mysql Password \e[0m"
mysql_secure_installation --set-root-pass $1 &>>/tmp/roboshop.log

