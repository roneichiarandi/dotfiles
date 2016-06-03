#!/usr/bin/env bash

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

DOTFILES= # verificar arquivos da pasta

for dotfile in "${DOTFILES[@]}"
do
  if [ -h ~/."${dotfile}" ]
  then
    printf "~/."${dotfile}" exists\n"
  else
    ln -s "${DOTFILES_ROOT}"/"${dotfile}" ~/."${dotfile}"
    printf "~/."${dotfile}" linked\n"
  fi
done

printf "%s installation end\n" $DOTFILES_ROOT

