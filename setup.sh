#!/bin/bash

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

DOTFILES=($(find ${DOTFILES_ROOT} -mindepth 1 -maxdepth 1 -not -path '*/.*' -type f -exec printf "%s\n" {} + |  awk -F/ '{print $NF}'))

DOTFILES_BIN_PATH=${DOTFILES_ROOT}/bin/

BIN_PATH=/usr/local/bin/

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


printf "Setup dotfiles (alias)\n"
for bin in "${DOTFILES_BIN_PATH}"*;
do
  file=$(basename $bin)
  if [[ "${file}" != "README.md" ]]
  then
    if [ -f ${BIN_PATH}"${bin}" ]
    then
      printf ${bin} exists\n
    else
      ln -s ${bin} ${BIN_PATH}${file}
      printf "${file} linked\n"
    fi
  fi
done

printf "%s installation end\n"

