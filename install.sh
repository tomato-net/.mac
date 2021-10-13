#! /bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install vim go thefuck rbenv pass keychain node rg tmux java jenv python assh zsh gnupg openjdk

pip3 install pygments

ssh-keygen -t ed25519 -C "thomas@flack.it"

read -p 'Path to key [~/.ssh/id_ed25519]: ' keypathvar
keypathvar=${keypathvar:-"~/.ssh/id_ed25519"}

eval "$(ssh-agent -s)"

touch ~/.ssh/config

ssh-add -K $keypathvar

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s $(which zsh)

read -p 'Continue once uploaded key to Github [y]: ' contvar

mkdir -p ~/code/github.com/nonki

cd ~/code/github.com/nonki

git clone git@github.com:nonki/.vim.git

git clone git@github.com:nonki/.tmux.git

git clone git@github.com:nonki/.ssh.git

git clone git@github.com:nonki/.zsh.git

sh -c "$(cat .vim/link.sh)"
sh -c "$(cat .tmux/link.sh)"
sh -c "$(cat .ssh/link.sh)"
sh -c "$(cat .zsh/link.sh)"
