#/bin/sh

# install some tools
sudo yum install -y git vim gcc glibc-static telnet wget 

# install docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# start docker service
sudo groupadd docker
sudo gpasswd -a vagrant docker
sudo systemctl start docker

rm -rf get-docker.sh

#set proxy
sudo mkdir -p /etc/systemd/system/docker.service.d

cat > /etc/systemd/system/docker.service.d/http-proxy.conf <<- "EOF"
[Service]
Environment="HTTP_PROXY=http://10.144.1.10:8080/"
EOF

cat > /etc/systemd/system/docker.service.d/https-proxy.conf <<- "EOF"
[Service]
Environment="HTTP_PROXY=http://10.144.1.10:8080/"
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker


# Docker-compose Install
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose