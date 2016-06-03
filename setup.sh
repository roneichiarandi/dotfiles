#!/usr/bin/env bash

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

DOTFILES=($(find ${DOTFILES_ROOT} -maxdepth 1 -type f -printf '%f '))

for dotfile in "${DOTFILES[@]}"
do
  if [[ "${dotfile}" != "setup.sh" ]] && [[ "${dotfile}" != "README.md" ]];
  then
    if [ -f ~/."${dotfile}" ]
    then
      printf "~/.${dotfile} exists\n"
    else
      ln -s "${DOTFILES_ROOT}"/"${dotfile}" ~/."${dotfile}"
      printf "~/.${dotfile} linked\n"
    fi
  fi
done

if [[ -d ~/.oh-my-zsh ]]; then
  rm ~/.oh-my-zsh/themes/agnoster.zsh-theme
  ln -s "${DOTFILES_ROOT}"/"oh-my-zsh/themes/agnoster.zsh-theme" ~/.oh-my-zsh/themes/agnoster.zsh-theme
  printf "\nAgnoster modified theme linked\n\n"
fi

printf "%s installation end\n" $DOTFILES_ROOT

