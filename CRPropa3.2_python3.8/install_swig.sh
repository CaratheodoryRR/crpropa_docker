cd ${EXTLIBS}
wget https://downloads.sourceforge.net/swig/swig-4.2.1.tar.gz
tar zxvf swig-4.2.1.tar.gz
cd swig-4.2.1
wget https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.gz
./Tools/pcre-build.sh
./configure --prefix=/usr --without-maximum-compile-warnings
make
sudo make install &&
sudo install -v -m755 -d /usr/share/doc/swig-4.2.1 &&
sudo cp -v -R Doc/* /usr/share/doc/swig-4.2.1