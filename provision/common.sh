echo Provisioning common...

sudo -H -u vagrant bash -c 'yes y | ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'
cp /vagrant/provision/vagrant ~/.ssh/id_rsa
cp /vagrant/provision/vagrant.pub ~/.ssh/id_rsa.pub
cat /vagrant/provision/vagrant.pub >> ~/.ssh/authorized_keys
sudo chmod 0600 ~/.ssh/*
sudo cp -f /vagrant/provision/hosts /etc

# Docker
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo usermod -aG docker vagrant
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Docker Compose
sudo yum upgrade python*
sudo yum install -y python-pip
sudo pip install --upgrade --force-reinstall pip==9.0.3
sudo pip install docker-compose
