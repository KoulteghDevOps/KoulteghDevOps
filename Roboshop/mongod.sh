cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y 
systemctl enable mongod 
systemctl start mongod 
sed -i 's/127\.0\.0\.0/0.0.0.0/g' mongo.repo
systemctl restart mongod