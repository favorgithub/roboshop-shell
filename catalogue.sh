source common.sh
component=catalogue

nodejs

echo -e "${color} Copy Mongodb.repo ${nocolor}"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file

echo -e "${color}Install Mongodb Client ${nocolor}"
yum install mongodb-org-shell -y &>>$log_file

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.devopsblessed.store <${app_path}/schema/$component.js &>>$log_file