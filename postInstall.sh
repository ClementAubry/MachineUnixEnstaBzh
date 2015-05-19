#!/bin/bash

#Please run this script as sudo!!!

# basic update
apt-get -y --force-yes update
apt-get -y --force-yes upgrade

#Install zsh with Clement Aubry config file, could be changed in ~/.zshrc
apt-get install zsh git
sudo -u ensta curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sudo -u ensta wget -O ~/.oh-my-zsh/themes/clemaubry.zsh-theme https://raw.githubusercontent.com/ClementAubry/MachineUnixEnstaBzh/master/clemaubry.zsh-theme
sudo -u ensta sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="clemaubry' ~/.zshrc

# install apps, may require some interactions... (wine and it's dependencies)
apt-get -y --force-yes install \
    ssh guake cmake cmake-qt-gui gcc g++ vlc \
    subversion gtkterm nautilus-open-terminal \
    filezilla cheese libmodbus5 libmodbus-dev \
    cifs-utils nfs-common valgrind audacity olsrd olsrd-gui \
    bison flex libgtkglext1-dev freeglut3-dev libplib-dev \
    libgtk2.0-dev libncurses-dev virtualbox gnome-session-fallback \
	xterm libfltk1.3-dev libpng12-dev libjpeg-dev libxft-dev libxinerama-dev libtiff4-dev \
    wine 

#Install Sublime Text 3
sudo -u ensta wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_i386.deb
dpkg -i sublime*.deb

#Install google earth
apt-get install googleearth-package
sudo -u ensta make-googleearth-package --force
dpkg -i googleearth*.deb
apt-get -f install

#Install moos and moos-ivp
svn co https://oceanai.mit.edu/svn/moos-ivp-aro/releases/moos-ivp-14.7.1 moos-ivp
cd moos-ivp
./build-moos.sh
./build-ivp.sh
cd


