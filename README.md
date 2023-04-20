<!-- Wet Codes for Roboshop
----------------------
CART
----
echo -e "\e[36m>>>>>>>>> Download NodeJS <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>>>> Copy Cart Service File <<<<<<<<<\e[0m"
cp cart.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create A App directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Cart File <<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Cart File <<<<<<<<<\e[0m"
unzip /tmp/cart.zip

# cd /app

echo -e "\e[36m>>>>>>>>> Install Cart Dependencies <<<<<<<<<\e[0m"
npm install 

# cp /home/centos/KoulteghDevOps/Roboshop/catalogue.service /etc/systemd/system/cart.service

echo -e "\e[36m>>>>>>>>> Start Cart Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable cart 
systemctl start cart

CATALOGUE
---------echo -e "\e[36m>>>>>>>>> Download nodejs <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install Nodejs <<<<<<<<<\e[0m"
yum install nodejs -y

# echo -e "\e[36m>>>>>>>>> Copy Catalogue System File <<<<<<<<<\e[0m"
# cp /home/centos/KoulteghDevOps/Roboshop/catalogue.service /etc/systemd/system/catalogue.service

# echo -e "\e[36m>>>>>>>>> Copy Mongo Repo File <<<<<<<<<\e[0m"
# cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Create a User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>>Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download App Content <<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip app Content <<<<<<<<<\e[0m"
unzip /tmp/catalogue.zip
# cd /app 

echo -e "\e[36m>>>>>>>>> Install NodeJS Dependencies <<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Copy Catalogue System File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>>>> Start Catalogue Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

echo -e "\e[36m>>>>>>>>> Copy Mongo Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Install Mongo Shell <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Update DNS Record <<<<<<<<<\e[0m"
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/catalogue.js

echo -e "\e[36m>>>>>>>>> Restart Catalogue Service <<<<<<<<<\e[0m"
systemctl restart catalogue

FRONTEND
--------
echo -e "\e[36m>>>>>>>>> Install Nginx <<<<<<<<<<<\e[0m"
dnf install nginx -y 

echo -e "\e[36m>>>>>>>>> Copy App Config File <<<<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf
# cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m>>>>>>>>> Empty the HTML Location <<<<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/* 

echo -e "\e[36m>>>>>>>>> Download Frontend File <<<<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip 

echo -e "\e[36m>>>>>>>>> Change Directory to Nginx HTML <<<<<<<<<<<\e[0m"
cd /usr/share/nginx/html 

echo -e "\e[36m>>>>>>>>> Unzip App File <<<<<<<<<<<\e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m>>>>>>>>> Start Nginx <<<<<<<<<<<\e[0m"
systemctl enable nginx 
systemctl start nginx

DISPATCH
--------
echo -e "\e[36m>>>>>>>>> Install Golang <<<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Dispatch File <<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Dispatch File <<<<<<<<<\e[0m"
unzip /tmp/dispatch.zip

# cd /app 

echo -e "\e[36m>>>>>>>>> Build Dispatch File <<<<<<<<<\e[0m"
go mod init dispatch
go get 
go build

echo -e "\e[36m>>>>>>>>> Copy Dispatch Service File <<<<<<<<<\e[0m"
# cp dispatch.service /etc/systemd/system/dispatch.service
cp /home/centos/KoulteghDevOps/Roboshop/dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[36m>>>>>>>>> Start Dispatch Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable dispatch 
systemctl start dispatch

MONGODB
-------
echo -e "\e[36m>>>>>>>>> Copy Mongo Repo <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Install MongoDB <<<<<<<<<\e[0m"
yum install mongodb-org -y 

echo -e "\e[36m>>>>>>>>> Start MongoDB Service <<<<<<<<<\e[0m"
systemctl enable mongod 
systemctl start mongod 

echo -e "\e[36m>>>>>>>>> Replace Listenig IP for MongoDB <<<<<<<<<\e[0m"
sed -i -e 's/127\.0\.0\.1/0.0.0.0/g' /etc/mongod.conf

echo -e "\e[36m>>>>>>>>> Restart Mongodb <<<<<<<<<\e[0m"
systemctl restart mongod

MYSQL
-----
echo -e "\e[36m>>>>>>>>> Disable MySQL 8 Version <<<<<<<<<\e[0m"
dnf module disable mysql -y 

echo -e "\e[36m>>>>>>>>> Copy MySQL Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mysql.repo /etc/yum.repos.d/mysql.repo

echo -e "\e[36m>>>>>>>>> Install MySQL <<<<<<<<<\e[0m"
yum install mysql-community-server -y

echo -e "\e[36m>>>>>>>>> Start MySQL <<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld 

echo -e "\e[36m>>>>>>>>> Reset Mysql Password <<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1

PAYMENT
-------
echo -e "\e[36m>>>>>>>>> Install Python36 <<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>>> Create User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Payment File <<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Payment File <<<<<<<<<\e[0m"
unzip /tmp/payment.zip
# cd /app 

echo -e "\e[36m>>>>>>>>> Install Python Dependencies <<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m>>>>>>>>> Copy Payment Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/payment.service /etc/systemd/system/payment.service
# cp payment.service /etc/systemd/system/payment.service

echo -e "\e[36m>>>>>>>>> Start Payment Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable payment 
systemctl start payment

RABBITMQ
--------
echo -e "\e[36m>>>>>>>>> Install RabbitMQ Repo <<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[36m>>>>>>>>> Install Erland <<<<<<<<<\e[0m"
yum install erlang -y

echo -e "\e[36m>>>>>>>>> Download RabbitMQ File <<<<<<<<<\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m>>>>>>>>> Install RabbitMQ Server <<<<<<<<<\e[0m"
yum install rabbitmq-server -y 

echo -e "\e[36m>>>>>>>>> Start RabbitMQ <<<<<<<<<\e[0m"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 

echo -e "\e[36m>>>>>>>>> Set User Password <<<<<<<<<\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

REDIS
-----
echo -e "\e[36m>>>>>>>>> Install Redis Repo <<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m>>>>>>>>> Enable Redis Repo <<<<<<<<<\e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[36m>>>>>>>>> Install Redis <<<<<<<<<\e[0m"
yum install redis -y 

echo -e "\e[36m>>>>>>>>> Substitute the IP Address <<<<<<<<<\e[0m"
sed -1 -e 's/127\.0\.0\.1/0.0.0.0/g' /etc/redis.conf /etc/redis/redis.conf

echo -e "\e[36m>>>>>>>>> Start Redis <<<<<<<<<\e[0m"
systemctl enable redis 
systemctl start redis 

SHIPPING
--------
echo -e "\e[36m>>>>>>>>> Install Maven <<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download Shipping File <<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip Shipping File <<<<<<<<<\e[0m"
unzip /tmp/shipping.zip

# cd /app 

echo -e "\e[36m>>>>>>>>> Package Maven <<<<<<<<<\e[0m"
mvn clean package 

echo -e "\e[36m>>>>>>>>> Move Sippinig Jars to New Location <<<<<<<<<\e[0m"
mv target/shipping-1.0.jar shipping.jar 

echo -e "\e[36m>>>>>>>>> Copy Shipping File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/shipping.service /etc/systemd/system/shipping.service
# cp shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>>>> Start Shipping Service <<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping 
systemctl start shipping

echo -e "\e[36m>>>>>>>>> Install MySQL <<<<<<<<<\e[0m"
yum install mysql -y 

echo -e "\e[36m>>>>>>>>> Update DNS Record <<<<<<<<<\e[0m"
mysql -h mysql-dev.gilbraltar.co.uk -uroot -pRoboShop@1 < /app/schema/shipping.sql 

echo -e "\e[36m>>>>>>>>> Restart Shipping Service <<<<<<<<<\e[0m"
systemctl restart shipping

USER
----
echo -e "\e[36m>>>>>>>>> Download NodeJS <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

# echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
# cp user.service /etc/systemd/system/user.service

# echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
# cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download User File <<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip User File <<<<<<<<<\e[0m"
unzip /tmp/user.zip

# cd /app

echo -e "\e[36m>>>>>>>>> Install User Dependencies <<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>> Reload Daemon <<<<<<<<<\e[0m"
systemctl daemon-reload
# systemctl enable user 
# systemctl start user

echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Installing MongoDB Shell <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Updating the DNS <<<<<<<<<\e[0m"
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/user.js

# systemctl restart uWet Codes for Roboshop
----------------------
CART
----
echo -e "\e[36m>>>>>>>>> Download NodeJS <<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>>>> Install NodeJS <<<<<<<<<\e[0m"
yum install nodejs -y

# echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
# cp user.service /etc/systemd/system/user.service

# echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
# cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Create A User <<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>>>> Create App Directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>>> Download User File <<<<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 

echo -e "\e[36m>>>>>>>>> Unzip User File <<<<<<<<<\e[0m"
unzip /tmp/user.zip

# cd /app

echo -e "\e[36m>>>>>>>>> Install User Dependencies <<<<<<<<<\e[0m"
npm install 

echo -e "\e[36m>>>>>>>>> Copy User Service File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>>>> Reload Daemon <<<<<<<<<\e[0m"
systemctl daemon-reload
# systemctl enable user 
# systemctl start user

echo -e "\e[36m>>>>>>>>> Copy MongoDB Repo File <<<<<<<<<\e[0m"
cp /home/centos/KoulteghDevOps/Roboshop/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>> Installing MongoDB Shell <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>> Updating the DNS <<<<<<<<<\e[0m"
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/user.js

# systemctl restart user

echo -e "\e[36m>>>>>>>>> Start User Service <<<<<<<<<\e[0m"
systemctl enable user 
systemctl start user

echo -e "\e[36m>>>>>>>>> Start User Service <<<<<<<<<\e[0m"
systemctl enable user 
systemctl start user -->

