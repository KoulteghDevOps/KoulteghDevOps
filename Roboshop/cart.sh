curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
cp catalogue.service /etc/systemd/system/cart.service
useradd roboshop
mkdir /app 
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 
unzip /tmp/cart.zip
cd /app 
npm install 
# cp catalogue.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart 
systemctl start cart