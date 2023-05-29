echo -e "\e[33m Install goland \e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33m Add Application User \e[0m" &>>/tmp/roboshop.log
useradd roboshop

echo -e "\e[33m Create Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download Application Content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m Unzip Application Content \e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33m download the dependencies \e[0m"
cd /app
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33m Setup SystemD Service\e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33m Start Dispatch Services \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log