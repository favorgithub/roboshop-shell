source common.sh

echo -e "${color}Installing redis repos${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log
stat_check $?


echo -e "${color} Enable Redis 6Version ${nocolor}"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log
stat_check $?


echo -e "${color} Install Redis${nocolor}"
yum install redis -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color} Update Redis Listen Address${nocolor}"
sed -i 's/127.0.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf
stat_check $?



echo -e "${color} Start Redis Service${nocolor}"
systemctl enable redis &>>/tmp/roboshop.log &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log &>>/tmp/roboshop.log
stat_check $?

