#!/bin/bash
# Setup script for Anchore instance
set -x

# Install latest Docker CE
apt update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt update
apt install -y docker-ce

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Install Anchore using docker-compose as detailed in:
# https://anchore.freshdesk.com/support/solutions/articles/36000020729-install-with-docker-compose
mkdir /home/ubuntu/aevolume
mkdir /home/ubuntu/aevolume/config
mkdir /home/ubuntu/aevolume/db
curl https://raw.githubusercontent.com/anchore/anchore-engine/master/scripts/docker-compose/docker-compose.yaml -o /home/ubuntu/aevolume/docker-compose.yaml
curl https://raw.githubusercontent.com/anchore/anchore-engine/master/scripts/docker-compose/config.yaml -o /home/ubuntu/aevolume/config/config.yaml
sed -i '1s/^/allow_awsecr_iam_auto: True\n/' /home/ubuntu/aevolume/config/config.yaml
cd /home/ubuntu/aevolume && docker-compose pull && docker-compose up -d
