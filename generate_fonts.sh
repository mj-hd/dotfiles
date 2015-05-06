#!/bin/bash

echo -e "\e[31m>> Checking fontforge...\e[m"
if [ ! type  "fontforge" > /dev/null 2>&1 ]; then
  echo "Fontforge command not found!!"
  echo "You need to install fontforge before this installation!"
  echo "Don't forget to compile with --with-python option."
  if [ `uname` = "Darwin" ]; then
    echo "brew install fontforge --with-python"
  elif [ `uname` = "Linux" ]; then
    echo "aptitude install fontforge"
    echo "pacman -S fontforge"
    echo "yum install fontforge"
    echo "..."
  fi
  exit 1
fi

echo ""

echo -e "\e[31m>> Starting to generate Ricty fonts...\e[m"
pushd ~/dotfiles/fonts
curl -o Inconsolata.otf "http://levien.com/type/myfonts/Inconsolata.otf"
curl -o migu-1m.zip -L "http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2Fmigu-1m-20130617.zip" && unzip migu-1m.zip -d ./ && rm migu-1m.zip
mv migu-1m*/migu-1m-regular.ttf migu-1m*/migu-1m-bold.ttf ./
rm -r migu-1m-*/

git clone https://github.com/yascentur/Ricty
./Ricty/ricty_generator.sh -f `which fontforge` auto
rm -rf Ricty

git clone https://github.com/Lokaltog/vim-powerline
fontforge -lang=py -script ./vim-powerline/fontpatcher/fontpatcher ./Ricty*.ttf
rm -rf vim-powerline

popd

echo ""

echo -e "\e[31mPlease install generated fonts manually!"
echo ""
echo "You need to donwload Solarized from http://ethanschoonover.com/solarized after this linking."
echo -e "And you need to run ':NeoBundleInstall' command in your vim.\e[m"
echo ""


