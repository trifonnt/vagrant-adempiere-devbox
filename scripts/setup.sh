#!/bin/sh

# Update the system
apt-get update
apt-get upgrade

################################################################################
# Install the mandatory tools
################################################################################

export LANGUAGE='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
locale-gen en_US.UTF-8
dpkg-reconfigure locales

# Install utilities
apt-get -y install vim git zip bzip2 fontconfig curl language-pack-en

# @Trifon - Additional utilities (MidnightCommander, wget)
apt-get -y install mc wget

# @Trifon - Time zone(UTC+2)
ln -fs /usr/share/zoneinfo/Europe/Sofia /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Install Java 8
apt-get install default-jdk

################################################################################
# Install the graphical environment
################################################################################

# Force encoding
echo 'LANG=en_US.UTF-8' >> /etc/environment
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
echo 'LC_CTYPE=en_US.UTF-8' >> /etc/environment

# Run GUI as non-privileged user
echo 'allowed_users=anybody' > /etc/X11/Xwrapper.config

# Install Ubuntu desktop and VirtualBox guest tools
apt-get install -y xubuntu-desktop virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

# Remove light-locker (see https://github.com/jhipster/jhipster-devbox/issues/54)
apt-get remove -y light-locker --purge

# Change the default wallpaper
wget https://raw.githubusercontent.com/trifonnt/vagrant-adempiere-devbox/master/images/adempiere-wallpaper.png -O /usr/share/xfce4/backdrops/adempiere-wallpaper.png
sed -i -e 's/xubuntu-wallpaper.png/adempiere-wallpaper.png/' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml

################################################################################
# Install the development tools
################################################################################

# Install Ubuntu Make - see https://wiki.ubuntu.com/ubuntu-make

add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make

apt-get update
apt-get upgrade

apt install -y ubuntu-make

# Install Chromium Browser
apt-get install -y chromium-browser

# Install MySQL Workbench
apt-get install -y mysql-workbench

# Install PgAdmin
apt-get install -y pgadmin3

## Install Heroku toolbelt - COMMENTED
#wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install Guake
apt-get install -y guake
cp /usr/share/applications/guake.desktop /etc/xdg/autostart/

# Install adempiere-devbox
git clone git://github.com/trifonnt/vagrant-adempiere-devbox.git /home/vagrant/adempiere-devbox
chmod +x /home/vagrant/adempiere-devbox/tools/*.sh

# Install zsh
apt-get install -y zsh

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
chsh -s /bin/zsh vagrant
echo 'SHELL=/bin/zsh' >> /etc/environment

## Install Visual Studio Code - COMMENTED
#su -c 'umake ide visual-studio-code /home/vagrant/.local/share/umake/ide/visual-studio-code --accept-license' vagrant
## Fix links (see https://github.com/ubuntu/ubuntu-make/issues/343)
#sed -i -e 's/visual-studio-code\/code/visual-studio-code\/bin\/code/' /home/vagrant/.local/share/applications/visual-studio-code.desktop
## disable GPU (see https://code.visualstudio.com/docs/supporting/faq#_vs-code-main-window-is-blank)
#sed -i -e 's/"$CLI" "$@"/"$CLI" "--disable-gpu" "$@"/' /home/vagrant/.local/share/umake/ide/visual-studio-code/bin/code

## Install IDEA community edition - COMMENTED
##su -c 'umake ide idea /home/vagrant/.local/share/umake/ide/idea' vagrant

# Install Eclipse IDE
su -c 'umake ide eclipse /home/vagrant/.local/share/umake/ide/eclipse' vagrant

# Increase Inotify limit (see https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit)
echo "fs.inotify.max_user_watches = 524288" > /etc/sysctl.d/60-inotify.conf
sysctl -p --system

# Install latest Docker
curl -sL https://get.docker.io/ | sh

# Install latest docker-compose
curl -L "$(curl -s https://api.github.com/repos/docker/compose/releases | grep browser_download_url | head -n 4 | grep Linux | cut -d '"' -f 4)" > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Configure docker group (docker commands can be launched without sudo)
usermod -aG docker vagrant

# Fix ownership of home
chown -R vagrant:vagrant /home/vagrant/

# Clean the box
apt-get -y autoclean
apt-get -y clean
apt-get -y autoremove
dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1
rm -f /EMPTY
