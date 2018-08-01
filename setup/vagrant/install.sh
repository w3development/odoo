#!/bin/bash

echo "=============================================" > /dev/stderr
echo "[INFO] Updating ubuntu packages." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo apt-get update && sudo apt-get -y upgrade


echo "=============================================" > /dev/stderr
echo "[INFO] Installing Python Pip3." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo apt-get install -y python3-pip


echo "=============================================" > /dev/stderr
echo "[INFO] Installing Odoo Dependencies." > /dev/stderr
echo "=============================================" > /dev/stderr
pip3 install --upgrade pip
pip3 install Babel decorator docutils ebaysdk feedparser \
gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock \
num2words ofxparse passlib Pillow psutil psycogreen psycopg2 \
pydot pyparsing PyPDF2 pyserial python-dateutil python-openid \
pytz pyusb PyYAML qrcode reportlab requests six suds-jurko \
vatnumber vobject Werkzeug XlsxWriter xlwt xlrd

echo "=============================================" > /dev/stderr
echo "[INFO] Installing web dependecies." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo apt-get install -y npm

if [ ! -f /usr/bin/node ]; then
  sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

sudo npm install -g less less-plugin-clean-css
sudo apt-get install -y node-less

echo "=============================================" > /dev/stderr
echo "[INFO] Installing postgresql." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo apt-get install -y python-software-properties

# sudo sh -c 'echo "[some repository]" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get -y update

sudo apt-get install -y postgresql-9.6

echo "=============================================" > /dev/stderr
echo "[INFO] Creating a postgresql user & database." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo -u postgres createuser odoo
sudo -u postgres createuser vagrant

sudo adduser --system --home=/opt/odoo/odoo/ --group odoo

echo "=============================================" > /dev/stderr
echo "[INFO] Installing GData." > /dev/stderr
echo "=============================================" > /dev/stderr
sudo tar zxvf /opt/odoo/data/resources/gdata-2.0.18.tar.gz
sudo chown -R odoo: gdata-2.0.18
python gdata-2.0.18/setup.py install

echo "[INFO] Done." > /dev/stderr
