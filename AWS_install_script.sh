#!/bin/bash


sudo yum -y update
sudo yum install -y git redhat-rpm-config sqlite-devel


# Install RVM and Ruby

# Installing RVM
#https://rvm.io/rvm/install
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable
export rvmsudo_secure_path=1
source /home/ec2-user/.rvm/scripts/rvm


# Install Ruby
rvm install 2.3.4

# Extra Packages for Enterprise Linux (EPEL) for NodeJs and Postgres
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum-config-manager --enable epel
node -v
npm -v

# Rails required a Javascript Runtime because of of execjs
# Not in Amazon's repo so using epel to install
# https://github.com/rails/execjs
sudo yum install -y nodejs npm --enablerepo=epel


# Install CodeDeploy Agent
# https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-linux.html
sudo yum install ruby -y
wget https://aws-codedeploy-ca-central-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto

#Check Status CodeDeploy
sudo service codedeploy-agent start
sudo service codedeploy-agent status
# installing Postgres
