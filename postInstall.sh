#!/bin/bash

#Please run this script as sudo!!!

# basic update
apt-get update
apt-get -y --force-yes upgrade

#Install zsh with config file, could be changed in ~/.zshrc
apt-get install zsh git git-core
sudo -u ensta curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
sudo -u ensta wget -O ~/.oh-my-zsh/themes/clemaubry.zsh-theme https://raw.githubusercontent.com/ClementAubry/MachineUnixEnstaBzh/master/clemaubry.zsh-theme
sudo -u ensta sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="clemaubry' /home/ensta/.zshrc

# install apps, may require some interactions... (wine and it's dependencies)
apt-get -y --force-yes install \
    ssh guake cmake cmake-qt-gui gcc g++ vlc build-essential\
    subversion gtkterm nautilus-open-terminal libusb-1.0-0-dev\
    filezilla cheese libmodbus5 libmodbus-dev libtinyxml2-dev\
    cifs-utils nfs-common valgrind audacity olsrd olsrd-gui \
    bison flex libgtkglext1-dev freeglut3-dev libplib-dev \
    libgtk2.0-dev libncurses-dev virtualbox gnome-session-fallback \
	xterm libfltk1.3-dev libpng12-dev libjpeg-dev libxft-dev libxinerama-dev libtiff4-dev

#Install Sublime Text 3
sudo -u ensta wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_i386.deb
dpkg -i sublime*.deb

#Install google earth
apt-get install googleearth-package
sudo -u ensta make-googleearth-package --force
dpkg -i googleearth*.deb
apt-get -f install

#Labjack exodrivers
sudo -u ensta git clone git://github.com/labjack/exodriver.git
cd ./exodriver/
./install.sh
cd ../

#Install moos and moos-ivp

#reglages proxy pour svn : dans ~/.subversion/servers
#[global]
#http-proxy-host = 192.168.1.17
#http-proxy-port = 8080
# ou on met les options dans la commande => PAS TESTÉ

sudo -u ensta svn co --config-option servers:global:http-proxy-host=192.168.1.17 \
					 --config-option servers:global:http-proxy-port=8080 \
                    https://oceanai.mit.edu/svn/moos-ivp-aro/releases/moos-ivp-15.5 moos-ivp
cd ./moos-ivp
sudo -u ensta ./build-moos.sh -j8 # -j8 pour travailler sur 8 coeurs
sudo -u ensta ./build-ivp.sh -j8
cd ../

# TODO ajouter les modifications du PATH pour MOOS dans le .zshrc
sudo -u ensta sed -i '$a export PATH=$PATH:/home/ensta/moos-ivp/bin' /home/ensta/.zshrc
sudo -u ensta sed -i '$a export PATH=$PATH:/home/ensta/moos-ivp/lib' /home/ensta/.zshrc
sudo -u ensta sed -i '$a export PATH=$PATH:/home/ensta/moos-ivp-ensta/bin' /home/ensta/.zshrc
sudo -u ensta sed -i '$a export PATH=$PATH:/home/ensta/moos-ivp-ensta/lib' /home/ensta/.zshrc
sudo -u ensta sed -i '$a export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/ensta/moos-ivp-ensta/lib:/home/ensta/moos-ivp/lib' /home/ensta/.zshrc


#Droits sur les tty, manière propre!
addgroup ensta dialout #necessite un reboot

reboot