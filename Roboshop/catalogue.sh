curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 
unzip /tmp/catalogue.zip
cd /app 
npm install 
# cp catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue
# cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.gilbraltar.co.uk </app/schema/catalogue.js
systemctl restart catalogue