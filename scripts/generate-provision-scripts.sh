#!/bin/bash

# CLIENT
echo "#!/bin/bash" > provision-client.sh
echo "sudo cp /etc/rsyslog.conf /etc/rsyslog.conf.bak" >> provision-client.sh
echo "sudo tee /etc/rsyslog.conf > /dev/null <<EOL" >> provision-client.sh
cat ../rsyslog/rsyslog-client.conf >> provision-client.sh
echo "EOL" >> provision-client.sh
echo "sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime" >> provision-client.sh
chmod +x provision-client.sh

# SERVER
echo "#!/bin/bash" > provision-server.sh
echo "sudo cp /etc/rsyslog.conf /etc/rsyslog.conf.bak" >> provision-server.sh
echo "sudo tee /etc/rsyslog.conf > /dev/null <<EOL" >> provision-server.sh
cat ../rsyslog/rsyslog-server.conf >> provision-server.sh
echo "EOL" >> provision-server.sh
echo "sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime" >> provision-server.sh
chmod +x provision-server.sh
