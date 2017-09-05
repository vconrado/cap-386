#/bin/bash

# ##############################################################################
#
# Author: Vitor Gomes
# Created at: 2017-08-25
# Last update: 2017-08-25
#
# Sources: https://paradigm4.atlassian.net/wiki/spaces/ESD169/pages/50856123/Pre-Installation+Tasks
#
# ##############################################################################

# ##############################################################################
# Configuration variables

HOST_IP=150.163.2.217
NET_MASK=$HOST_IP/8
SCIDB_USR=scidb
DEV_DIR=/home/$SCIDB_USR/mydevel16.9

# ##############################################################################

# ##############################################################################
# Creating scidb user
#groupadd $SCIDB_USR
#useradd $SCIDB_USR -s /bin/bash -m -g $SCIDB_USR
# Defining SciDB credential to connect
#echo $SCIDB_USR:$SCIDB_PASS | chpasswd


# ##############################################################################
# Setting up DEV DIR
mkdir -p $DEV_DIR
chown $SCIDB_USR:$SCIDB_USR $DEV_DIR

# ##############################################################################
# https://unix.stackexchange.com/a/36687
# para Funcionar ssh sem senha
chmod g-w /home/$SCIDB_USR

# ##############################################################################
# Instaling dependencies
#apt-get update
#apt-get install -y  wget apt-transport-https software-properties-common

# ##############################################################################
# Downloading SciDB
cd $DEV_DIR
#https://doc-14-b4-docs.googleusercontent.com/docs/securesc/o2lvm8jdsn2q4huk2hk91f3fv8134d81/1dgh8mughe1ndhpcbm3ivpdnq6u429g9/1503691200000/10873567126623341227/13083423369119719658/0BzNaZtoQsmy2OG1WcXhiai1rak0?e=download&nonce=hv7qurfmn9mqc&user=13083423369119719658&hash=b9cigl6q3kp9smhu5i3f9pe1sm75k9mr
#https://doc-0c-6k-docs.googleusercontent.com/docs/securesc/o2lvm8jdsn2q4huk2hk91f3fv8134d81/45jm3gjgt73kmvqbq605pgh64qmbl42f/1503691200000/01409786538484071242/13083423369119719658/0B7yt0n33Us0raWtCYmNlZWRxWG8?e=download
SCIDB_URL="https://docs.google.com/uc?id=0BzNaZtoQsmy2OG1WcXhiai1rak0&export=download"
wget --no-verbose --output-document scidb-16.9.0.db1a98f.tgz \
        --load-cookies cookies.txt \
        "$SCIDB_URL&`wget --no-verbose --output-document - \
            --save-cookies cookies.txt "$SCIDB_URL" | \
            grep --only-matching 'confirm=[^&]*'`"


mkdir scidbtrunk
tar -xzf scidb-16.9.0.db1a98f.tgz -C scidbtrunk
cd scidbtrunk

# ##############################################################################
# Installing Expect, and SSH Packages
#apt-get install -y expect openssh-server openssh-client git wget vim

#apt-get autoremove
#apt-get clean


# ##############################################################################
# Providing Passwordless SSH
#ssh-keygen -f /root/.ssh/id_rsa -N ''
#chmod 755 /root
#chmod 755 /root/.ssh

#mkdir /home/$SCIDB_USR/.ssh
#ssh-keygen -f /home/$SCIDB_USR/.ssh/id_rsa -N ''
#chmod 755 /home/$SCIDB_USR
#chmod 755 /home/$SCIDB_USR/.ssh

# ##############################################################################
# Avoid setting password and providing it to "deploy.sh access"
#cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
#cat /root/.ssh/id_rsa.pub >> /home/$SCIDB_USR/.ssh/authorized_keys

cat /home/$SCIDB_USR/.ssh/id_rsa.pub >> /home/$SCIDB_USR/.ssh/authorized_keys

# ##############################################################################
# Set correct ownership
#chown -R $SCIDB_USR:$SCIDB_USR /home/$SCIDB_USR

# ##############################################################################
# Starting ssh-server
#service ssh restart

# ##############################################################################
# Deploying SciDB acess root and scidb user
./deployment/deploy.sh access root NA "" $HOST_IP
./deployment/deploy.sh access $SCIDB_USR NA "" $HOST_IP
ssh $HOST_IP date


# ##############################################################################
## Installing Postgres
# Nao rodei
#./deployment/deploy.sh prepare_postgresql postgres postgres $NET_MASK $HOST_IP

# ##############################################################################
# Providing the postgres user Access to SciDB Code
#usermod -G $SCIDB_USR -a postgres
#chmod g+rx $DEV_DIR
#/usr/bin/sudo -u postgres ls $DEV_DIR


# ##############################################################################
## Installing SciDB Community Edition
## https://paradigm4.atlassian.net/wiki/display/ESD/Installing+SciDB+Community+Edition

# ##############################################################################
# Configuring Environment Variables
export SCIDB_VER=16.9
export SCIDB_INSTALL_PATH=/opt/scidb/${SCIDB_VER}
export SCIDB_BUILD_TYPE=RelWithDebInfo
export SCIDB_SOURCE_PATH=/home/scidb/mydevel16.9/scidbtrunk
export SCIDB_BUILD_PATH=${SCIDB_SOURCE_PATH}/stage/build
export PATH=$SCIDB_INSTALL_PATH/bin:$PATH


# ##############################################################################
# Installing Build Tools
./deployment/deploy.sh prepare_toolchain $HOST_IP


# ##############################################################################
# Configuring Environment Variables in bashrc files
echo "\
export SCIDB_VER=16.9\n
export SCIDB_INSTALL_PATH=/opt/scidb/${SCIDB_VER}\n
export SCIDB_BUILD_TYPE=RelWithDebInfo\n
export SCIDB_SOURCE_PATH=/home/scidb/mydevel16.9/scidbtrunk\n
export SCIDB_BUILD_PATH=${SCIDB_SOURCE_PATH}/stage/build\n
export PATH=$SCIDB_INSTALL_PATH/bin:$PATH\n" | tee -a /root/.bashrc /home/$SCIDB_USR/.bashrc



# ##############################################################################
# Activating and Verifying the New .bashrc File
echo $SCIDB_VER
echo $SCIDB_INSTALL_PATH
echo $PATH

# ##############################################################################
# Building SciDB CE
./run.py setup --force
./run.py make -j4

# ##############################################################################
# Installing SciDB CE
service postgresql restart
# senha mydb
echo "\n\ny" | ./run.py install --force


# ##############################################################################
# Starting and Stopping SciDB
# https://paradigm4.atlassian.net/wiki/display/ESD/Starting+and+Stopping+SciDB

echo "#!/bin/bash\n\
service ssh start\n\
service postgresql start\n\
scidb.py startall mydb\n\
trap \"scidb.py stopall mydb; service postgresql stop\" EXIT HUP INT QUIT TERM\n\
bash" > /docker-entrypoint.sh
chmod +x /docker-entrypoint.sh




# instalar e configurar ntp
apt-get install ntp








# ##############################################################################
# Setting ssh passwordless for root user
yes | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
echo "StrictHostKeyChecking no" ~/.ssh/config
sed -i 's/PermitRootLogin.*/#PermitRootLogin/g' /etc/ssh/sshd_config
# Setting ssh passwordless for scidb user
su scidb -c "yes | ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''"
su scidb -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
su scidb -c "chmod 600 ~/.ssh/authorized_keys"
su scidb -c "echo \"StrictHostKeyChecking no\" >> ~/.ssh/config"
su scidb -c "chmod 755 ~ && chmod 755 ~/.ssh"

# ##############################################################################
# Creating directories
mkdir -p /opt/scidb && mkdir -p /opt/scidb/data
chown scidb:scidb -R /opt/scidb


# ##############################################################################
# Unpacking SciDB
cd /opt/scidb/install && tar -xf scidb-15.12.1.4cadab5.tar.gz && mv scidb-15.12.1.4cadab5 scidbtrunk && cd scidbtrunk

# ##############################################################################
# Preparing environmento to install SciDB
service ssh start
/opt/scidb/install/scidbtrunk/deployment/deploy.sh prepare_toolchain localhost
/opt/scidb/install/scidbtrunk/deployment/deploy.sh prepare_postgresql postgres postgres 172.17.0.0/24 localhost
usermod -G scidb -a postgres
chmod g+rw /opt/scidb/install

# ##############################################################################
# Installing SciDB
su - scidb
echo -e "export SCIDB_VER=15.12 \nexport SCIDB_INSTALL_PATH=/opt/scidb/install/scidbtrunk/stage/install \nexport SCIDB_BUILD_TYPE=RelWithDebInfo\nexport PATH=\$SCIDB_INSTALL_PATH/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

chown scidb:scidb -R /opt/scidb
cd /opt/scidb/install/scidbtrunk
yes | ./run.py setup
./run.py make -j4

/run.py install

# ##############################################################################
# Cleaning the house
rm /opt/scidb/install/scidb-15.12.1.4cadab5.tar.gz
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
