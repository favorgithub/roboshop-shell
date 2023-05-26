echo -e "\e[33mCopy MongoDB Repo file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongo.repo
echo -e "\e[33mInstalling MongoDb Server\e[0m"
yum install mongodb-org -y
## Modify the config file
echo -e "\e[33mStart Mongdb Service\e[0m"
systemctl enable mongod
systemctl restart mongod