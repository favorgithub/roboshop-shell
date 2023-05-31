color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

app_presetup(){

    echo -e "${color} Add Application User ${nocolor}"
    useradd roboshop &>>$log_file
    echo$?

    echo -e "${color} Create Application Directory ${nocolor}"
    rm -rf ${app_path} &>>$log_file
    mkdir ${app_path}
    echo$?

    echo -e "${color} Download Application Content ${nocolor}"
    curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>$log_file
    cd ${app_path}
     echo$?

    echo -e "${color} Extract Application content ${nocolor}"
    cd ${app_path}
    unzip /tmp/$component.zip &>>$log_file
    echo$?
}

systemd_setup(){

    echo -e "${color} Setup SystemD Service ${nocolor}"
    cp /home/centos/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>$log_file
    echo$?

    echo -e "${color} Start User Service ${nocolor}"
    systemctl daemon-reload &>>$log_file
    systemctl enable $component &>>$log_file
    systemctl restart $component &>>$log_file
     echo$?
}

nodejs() {
  echo -e "${color} Configuring NodeJS Repos ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

  echo -e "${color} install NodeJS ${nocolor}"
  yum install nodejs -y &>>$log_file

  app_presetup

  echo -e "${color} Install NodeJS Dependencies ${nocolor}"
  npm install &>>$log_file

  systemd_setup

}

mongo_schema_setup() {

  echo -e "${color} Copy Mongodb.repo ${nocolor}"
  cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file

  echo -e "${color}Install Mongodb Client ${nocolor}"
  yum install mongodb-org-shell -y &>>$log_file

  echo -e "${color} Load Schema ${nocolor}"
  mongo --host mongodb-dev.devopsblessed.store <${app_path}/schema/${component}.js &>>$log_file

}

mysql_schema_setup(){

    echo -e "${color} Install Mysql Client ${nocolor}"
    yum install mysql -y &>>$log_file

    echo -e "${color} Load Schema ${nocolor}"
    mysql -h mysql-dev.devopsblessed.store -uroot -pRoboShop@1 < /home/centos/roboshop-shell/schema/${component}.sql &>>$log_file
}


maven(){
  
  echo -e "${color} Install Maven ${nocolor}"
  yum install maven -y  &>>$log_file
  
  app_presetup

  
  echo -e "${color} Download Maven Dependencies ${nocolor}"
  cd ${app_path}
  mvn clean package &>>$log_file
  mv target/${component}-1.0.jar ${component}.jar &>>$log_file

  
  mysql_schema_setup

  systemd_setup
  
}

python(){
 echo -e "${color}  Install Python36 ${nocolor}"
 yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

 echo$?

 app_presetup

 echo -e "${color} Install Application Dependencies ${nocolor}"
 cd /app
 pip3.6 install -r requirements.txt &>>/tmp/roboshop.log


systemd_setup
}