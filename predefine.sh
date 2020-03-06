sudo apt-get -y update
sudo apt-get -y install curl patch gawk g++ make patch libyaml-dev libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev automake libtool bison pkg-config libffi-dev libgmp-dev zlib1g-dev liblzma-dev mc
sudo apt-get -y install libsqlite3-dev git nodejs
sudo apt-get -y install imagemagick libmagickwand-dev libmysqlclient-dev

sudo apt-get -y install build-essential module-assistant

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
sudo apt-get -y install mysql-server