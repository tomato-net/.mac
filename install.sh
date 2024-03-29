#! /bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

xcode-select --install

brew bundle install --no-lock --file <(curl -fsSL https://raw.githubusercontent.com/tomato-net/.mac/master/Brewfile)

read -p 'Generate new key? [y/N]: ' shouldGenerateKey

shouldGenerateKey=${shouldGenerateKey:-"N"}

if [ $shouldGenerateKey == 'y' ]; then # failed
  ssh-keygen -t ed25519 -C "thomas.flack@skybettingandgaming.com"
fi

read -p 'Path to key [~/.ssh/id_ed25519]: ' keypathvar
keypathvar=${keypathvar:-"${HOME}/.ssh/id_ed25519"}

eval "$(ssh-agent -s)"

touch ~/.ssh/config

ssh-add -K "${keypathvar}"

pubkey="${keypathvar}.pub"

pbcopy < $pubkey # need to be .pub

read -p 'Continue once uploaded key to Github [y]: ' contvar

mkdir -p ~/code/github.com/tomato-net

cd ~/code/github.com/tomato-net

git clone git@github.com:tomato-net/.vim.git

git clone git@github.com:tomato-net/.tmux.git

git clone git@github.com:tomato-net/.ssh.git

git clone git@github.com:tomato-net/.zsh.git

git clone git@github.com:tomato-net/.gitconfig.git

gpg --full-generate-key
# pass init "GPG KEY ID"

cd /tmp && go install golang.org/x/tools/gopls@latest

ssh-keyscan -t rsa stash.skybet.net >> ~/.ssh/known_hosts

mkdir -p ~/tmp/.ssh

ln -s ~/code/github.com/tomato-net/.zshenv ~/.zshenv
[ -d "~/.tmux" ] && rm -rf ~/.tmux
ln -s ~/code/github.com/tomato-net/.tmux ~/.tmux
[ -d "~/.vim" ] && rm -rf ~/.vim
ln -s ~/code/github.com/tomato-net/.vim ~/.vim
ln -s ~/code/github.com/tomato-net/.ssh/assh.yml ~/.ssh/assh.yml


git config --global user.name "Thomas Flack"
git config --global user.email "thomas.flack@skybettingandgaming.com"

~/.vim/install.sh

/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # took me into seperate shell

# tmux insstall run prefix + I
