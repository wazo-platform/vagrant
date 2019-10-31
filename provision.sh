#!/bin/bash
# Will install Wazo localy
set -xe

ANSIBLE_VERSION=2.7.9
BRANCH=wazo-19.14
DISTRIBUTION=pelican-buster

# Requirements
# coreutils = tee
sudo apt-get update
sudo apt-get install -y -q virtualenv python3-pip git coreutils
# Confort
sudo apt-get install -y -q bash-completion curl mlocate netcat nmap strace tmux tree vim-nox wget virt-what dh-autoreconf ca-certificates silversearcher-ag

# Enforce valid locale
echo en_US.UTF-8 UTF-8 | sudo tee /etc/locale.gen
echo LANG=en_US.UTF-8 | sudo tee /etc/default/locale
sudo locale-gen

# Install Ansible, get Wazo's playbooks and their requirements
virtualenv venv
source venv/bin/activate
pip install "ansible==$ANSIBLE_VERSION"
# pip install psycopg2 # BUGFIX
if [ ! -d wazo-ansible ]; then
git clone https://github.com/wazo-platform/wazo-ansible.git
fi
cd wazo-ansible || exit 1
git checkout "$BRANCH"
ansible-galaxy install -r requirements-postgresql.yml -p roles

# Configuration
sed -i 's;^# \[uc-ui:children\];[uc-ui:children];' inventories/uc-engine
sed -i 's;^# uc-engine-host;uc-engine-host;' inventories/uc-engine
echo "wazo_distribution = $DISTRIBUTION" >> inventories/uc-engine
echo "wazo_distribution_upgrade = $DISTRIBUTION" >> inventories/uc-engine
echo "engine_api_configure_wizard = true" >> inventories/uc-engine
echo "engine_api_root_password = wazo" >> inventories/uc-engine
# sudo mkdir -p /root/.config/wazo-auth-cli # BUGFIX
# sudo mkdir -p /var/www/html # BUGFIX
# sudo chown -R www-data:www-data /var/www/html # BUGFIX

# Install Wazo
ansible-playbook -i inventories/uc-engine uc-engine.yml
