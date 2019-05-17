#!/bin/sh

mkdir -p .build
pushd .build

# install xyzsh 
#   depends on gcc, GNU make, libc, libm, ncurses(w), editline, oniguruma, iconv
git clone https://github.com/ab25cq/xyzsh.git xyzsh 
pushd xyzsh

./configure --with-optimize
make
sudo make install

popd

# install mfiler4
#   depends on gcc, GNU make, libc, libm, libncurses(w), libreadline, libxyzsh
git clone https://github.com/ab25cq/mfiler4 mfiler4
pushd mfiler4

./configure --with-optimize
make
sudo make install

popd

popd
