echo "${yellow}Checking for INSTALL directory${reset}"
if [ ! -d "$INSTALL_DIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "${cyan}Creating directory: ${INSTALL_DIR}"
  mkdir $INSTALL_DIR
fi

cd $INSTALL_DIR
echo "${green}Downloading OpenCV Source${reset}"
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

echo "${green}BUILD${reset}"
cd $INSTALL_DIR/opencv
mkdir build && cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON ..

echo "${green}MAKE${reset}"
make -j8
sudo make install

echo "${green}Testing OpenCV Install${reset}"
echo "${magenta}OpenCV Version:{cyan}"
pkg-config --modversion opencv4
