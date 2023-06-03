source common.sh

echo -e "${color} Disable mysql default Version${nocolor}"
yum module disable mysql -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Copy mysql Repos${nocolor}"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log
stat_check $?


echo -e "${color} Installing mysql community Server ${nocolor}"
yum install mysql-community-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Start mysql Service ${nocolor}"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Setup  Mysql Password ${nocolor}"
mysql_secure_installation --set-root-pass $1 &>>/tmp/roboshop.log
stat_check $?

