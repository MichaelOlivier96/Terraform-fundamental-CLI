#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

apt-get update -y
apt-get install -y apache2 php libapache2-mod-php mariadb-server
systemctl start apache2
systemctl enable apache2

cd /var/www/html
curl https://raw.githubusercontent.com/hashicorp/learn-terramino/master/index.php -O