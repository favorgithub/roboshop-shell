echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install nginx -y

echo -e "\e[33mRemoving Old App content\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[33mDownloading Frontend Contend\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip


echo -e "\e[33mExtracting Frontend Content\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[33mStarting Nginx Server\e[0m"
## we need to copy config file
systemctl enable nginx
systemctl restart nginx