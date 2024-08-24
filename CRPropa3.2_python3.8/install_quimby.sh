cd ${EXTLIBS}
git clone https://git.rwth-aachen.de/3pia/forge/quimby
cd quimby/
mkdir build
cd build
cmake .. -DQUIMBY_ENABLE_TESTING=ON
make
sudo make install