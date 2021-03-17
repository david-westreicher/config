#!/bin/bash

sudo apt-get install -y ansible
ansible-playbook -K install.yml
