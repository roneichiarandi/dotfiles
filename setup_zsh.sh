#!/bin/bash

set -e

DOTFILES_ROOT=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

FONTS_PATH=~/.fonts

DOTFILES_CUSTOM_THEMES=${DOTFILES_ROOT}/oh-my-zsh/themes/
ZSH_CUSTOM_THEMES=~/.oh-my-zsh/custom/themes/
ZSH_CONFIG_FILE=~/.zshrc

main() {
  _install_font
  _install_zsh
  _install_oh_my_zsh
  _configure_theme_oh_my_zsh
  _enable_custom_theme
}

function _install_zsh(){
  if ! zsh --version &> /dev/null; then
    echo "Instalando ZSH" 
    sudo apt update && sudo apt install zsh -y

    chsh -s /bin/zsh
  else
    echo "ZSH já está instalado"
  fi
}

function _install_oh_my_zsh(){
  if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "oh my zsh já está instalado"
  fi
}

function _configure_theme_oh_my_zsh(){
  if [[ -d ~/.oh-my-zsh ]]; then
    if [[ -d ${DOTFILES_CUSTOM_THEMES} ]]; then
      for item in "${DOTFILES_CUSTOM_THEMES}"*; do
        if [[ -f "$item" ]]; then
          file=$(basename $item)
          ln -s ${item} ${ZSH_CUSTOM_THEMES}${file}
        fi
      done
      echo "\nLinked custom themes path\n\n"
    else
      echo "Error: '$path' is not a valid directory."
    fi
  fi
}

function _install_font(){
  if [ ! -d ${FONTS_PATH} ]; then
    mkdir ${FONTS_PATH}
  fi

  cp ${DOTFILES_ROOT}"/"oh-my-zsh/fonts/* ${FONTS_PATH}
  fc-cache -fv
}

function _enable_custom_theme(){
  echo ${ZSH_CONFIG_FILE}
  /bin/sed -i 's/ZSH_THEME=\".*/ZSH_THEME=\"agnoster-homer\"/g' ${ZSH_CONFIG_FILE}
  cat ${ZSH_CONFIG_FILE} | grep ZSH_THEME
}

main