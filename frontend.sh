source common.sh

echo -e "${color} Installing Nginx Server${nocolor}"
yum install nginx -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Removing Old App content${nocolor}"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Downloading Frontend Contend${nocolor}"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Extracting Frontend Content${nocolor}"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Update frontend configuration file${nocolor}"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}Starting Nginx Server${nocolor}"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
stat_check $?

