cd ${EXTLIBS}
git clone https://github.com/CRPropa/CRPropa3.git
cd CRPropa3
mkdir build/
cd build/
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/.local -DSIMD_EXTENSIONS:STRING=native -DFAST_WAVES=ON -DENABLE_COVERAGE=ON -DENABLE_QUIMBY=ON
make
make test
sudo make install