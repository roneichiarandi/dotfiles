#!/usr/bin/env bash

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

DOTFILES=($(find ${DOTFILES_ROOT} -not -path '*/.*' -type f -mindepth 1 -maxdepth 1 -exec printf "%s\n" {} + |  awk -F/ '{print $NF}'))

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
  ln -s "${DOTFILES_ROOT}"/"oh-my-zsh/themes" ~/.oh-my-zsh/custom/themes
  printf "\nLinked custom themes path\n\n"
fi

printf "%s installation end\n" $DOTFILES_ROOT

