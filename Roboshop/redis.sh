echo -e "\e[36m>>>>>>>>> Install Redis Repo <<<<<<<<<\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m>>>>>>>>> Enable Redis Repo <<<<<<<<<\e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[36m>>>>>>>>> Install Redis <<<<<<<<<\e[0m"
yum install redis -y 

echo -e "\e[36m>>>>>>>>> Substitute the IP Address <<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf /etc/redis/redis.conf

echo -e "\e[36m>>>>>>>>> Start Redis <<<<<<<<<\e[0m"
systemctl enable redis 
systemctl start redis 