cd /tmp
git clone https://github.com/barnumbirr/alacritty-debian
cd /tmp/alacritty-debian
./build.sh
dpkg -i /tmp/alacritty-debian/target/alacritty_0.10.1-1_amd64.deb
