#!/bin/bash

if [ -e tmp ]; then
	rm -rf tmp
fi

mkdir tmp
cd tmp
dir=$(pwd)

check_error() {
	if [[ $? == 0 ]]; then
		echo '[+]'
	else
		echo '[-]'
		exit
	fi
}

install() {
	sudo apt-get install -q -y $1
}

echo "build essentials"
install build-essential
check_error

echo "git..."
install git
check_error

echo "i3..."
install i3
check_error

echo "dependencies..."
install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev
check_error

echo "lxappearance..."
install lxappearance
check_error

echo "rofi..."
install rofi
check_error

#echo "infinality..."
#sudo add-apt-repository -y ppa:no1wantdthisname/ppa
#sudo apt-get update
#install fontconfig-infinality
#check_error
#sudo bash /etc/fonts/infinality/infctl.sh setstyle osx
#sudo ppa-purge ppa:no1wantdthisname/ppa

echo "arc-theme..."
install arc-theme
check_error

echo "xcb-util-xrm..."
git clone https://github.com/Airblader/xcb-util-xrm xcb
cd xcb
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install
check_error
cd $dir
rm -rf xcb

echo "i3-gaps..."
git clone https://github.com/Airblader/i3 i3
cd i3
autoreconf --force --install
rm -rf build/
mkdir -p build
cd build/
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
check_error
cd $dir

cd ..
rm -rf tmp
