#!/usr/bin/env bash

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

DOTFILES=($(find ${DOTFILES_ROOT} -mindepth 1 -maxdepth 1 -not -path '*/.*' -type f -exec printf "%s\n" {} + |  awk -F/ '{print $NF}'))

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
  if [ -L ~/.oh-my-zsh/custom/themes ]
  then
    printf "\nCustom theme path exists\n\n"
  else
    ln -s "${DOTFILES_ROOT}"/"oh-my-zsh/themes" ~/.oh-my-zsh/custom/themes
    printf "\nLinked custom themes path\n\n"
  fi
fi

printf "%s installation end\n" $DOTFILES_ROOT

