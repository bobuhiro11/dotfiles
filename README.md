# Dotfiles

## Installation

```bash
# dotfiles
cd $HOME
git init
git remote add origin git@github.com:bobuhiro11/dotfiles.git
git checkout -b main
git fetch --all
git reset --hard origin/main

# git
read -p 'mail address: ' email
cat <<EOF > $HOME/.gitconfig.local
[user]
  email = $email
EOF

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c PlugUpdate +quitall
```
