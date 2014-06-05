#!/bin/bash

if [ ! -d ~/.oh-my-zsh ]; then
  echo ">>Starting to install oh-my-zsh..."
  curl -L http://install.ohmyz.sh | sh
fi

echo ">>Checking fontforge..."
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

echo ">>Patching agnoster.theme to adapt to old powerline font..."
pushd ~/.oh-my-zsh/
pushd themes
patch < ~/dotfiles/agnoster.patch
popd
git stash
popd

echo ">>Starting to generate Ricty fonts..."
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

echo "Please install generated fonts manually!"
echo ""
echo "You need to donwload Solarized from http://ethanschoonover.com/solarized after this linking."
echo "And you need to run ':NeoBundleInstall' command in your vim."

ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmux-powerline ~/.tmux-powerline
ln -s ~/dotfiles/.tmux-powerlinerc ~/.tmux-powerlinerc
