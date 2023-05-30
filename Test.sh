echo -e "${color} Configuring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log_file}

echo -e "${color} install NodeJS\e[0m"
yum install nodejs -y  &>>${log_file}

echo -e "${color} Add Application User\e[0m"
useradd roboshop  &>>${log_file}

echo -e "${color} Create Application Directory${nocolor}"
rm -rf ${app_path}  &>>${log_file}
mkdir ${app_path}

echo -e "${color} Download Application Content${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path}

echo -e "${color} Extract Application content${nocolor}"
unzip /tmp/${component}.zip  &>>${log_file}
cd ${app_path}

echo -e "${color} Install NodeJS Dependencies${nocolor}"
npm install  &>>${log_file}

echo -e "${color} Setup SystemD Service${nocolor}"
cp /home/centos/roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>${log_file}

echo -e "${color} Start User Service ${nocolor}"
systemctl daemon-reload  &>>${log_file}
systemctl enable ${component}  &>>${log_file}
systemctl restart ${component} &>>${log_file}


##shipping

echo -e "\e[33m Install Maven \e[0m"
yum install maven -y  &>>/tmp/roboshop.log

echo -e "\e[33m Add Application User \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[33m Create Application Directory \e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33m Download Application Content \e[0m"
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract Application Content \e[0m"
cd /app
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m Download Maven Dependencies \e[0m"
cd /app
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33m Setup SystemD Service\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service  &>>/tmp/roboshop.log

echo -e "\e[33m Install Mysql Client \e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Load Schema \e[0m"
mysql -h mysql-dev.devopsblessed.store -uroot -pRoboShop@1 < /home/centos/roboshop-shell/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33m Start Shipping Service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log