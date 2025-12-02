# My dotfiles


## Stealth Mode

```./stealth-mode [on|off]```

Ao habilitar o modo stealth, você impede que qualquer máquina da mesma rede, possa realizar uma varredura em seu sistema a procura de portas da rede que estejam em uso no seu sistema operacional, essa varredura de portas você pode fazer através da CLI nmap (que existe para Linux, Unix ou Mac), inclusive já publiquei anos atrás um post sobre isso:
Visualizando portas da rede com nmap.

Dica do [@crp_underground](https://medium.com/@crp_underground/habilitando-stealth-mode-no-macos-8efee4e2e9d6)



## ch57x - version 1.4.4

github: [Documentação](https://github.com/kriomant/ch57x-keyboard-tool?tab=readme-ov-file#3x1-keys--1-knob-keyboard-limitations)

command
```
$ lsusb -v

$ ./ch57x upload mini-keyboard.yaml
```

## ./bin/mic

```bash
$ sudo apt update && sudo apt install pulseaudio

$ /usr/bin/pactl list | grep alsa_input #buscar o nome do microfone

$ crontab -e

 ```
# * * * * * ( sleep 15; /home/$(whoami)/dotfiles/bin/mic )