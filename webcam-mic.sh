#!/usr/bin/env bash
set -e

# Identificação da webcam (valores padrão)
DEFAULT_VENDOR="1b17"
DEFAULT_PRODUCT="0211"

# Arquivo da regra udev
CONF_FILE="/etc/udev/rules.d/99-disable-webcam-audio.rules"

usage() {
    cat <<EOF
Uso: $0 <enable|disable> [VID] [PID]

Exemplos:
    $0 disable 1b17 0211    # desabilita mic da webcam 1b17:0211
    $0 enable 1b17 0211     # reabilita mic da mesma webcam
    $0 disable              # usa valores padrão 1b17:0211
    $0 enable               # usa valores padrão 1b17:0211

Parâmetros:
    enable|disable    - Ação a ser executada
    VID              - Vendor ID da webcam (opcional, padrão: $DEFAULT_VENDOR)
    PID              - Product ID da webcam (opcional, padrão: $DEFAULT_PRODUCT)
EOF
    exit 1
}

# Processa argumentos da linha de comando
ACTION="$1"
VENDOR="${2:-$DEFAULT_VENDOR}"
PRODUCT="${3:-$DEFAULT_PRODUCT}"

# Validação dos argumentos
if [[ -z "$ACTION" ]]; then
    echo "Erro: Ação não especificada"
    usage
fi

if [[ "$ACTION" != "enable" && "$ACTION" != "disable" ]]; then
    echo "Erro: Ação inválida '$ACTION'. Use 'enable' ou 'disable'"
    usage
fi

disable_webcam_mic() {
    local vid="$1"
    local pid="$2"
    
    echo "Desabilitando microfone da webcam ${vid}:${pid}..."
    
    # Cria a regra de configuração do módulo para desabilitar o microfone
    sudo tee "$CONF_FILE" > /dev/null <<EOF
# Regra gerada por webcam-mic.sh em $(date)
# Desabilita o microfone da webcam ${vid}:${pid}
options snd_usb_audio vid=0x${vid} pid=0x${pid} device_setup=0 enable=0
EOF
    
    # Recarrega o módulo de áudio USB
    echo "Recarregando módulo snd_usb_audio..."
    sudo modprobe -r snd_usb_audio 2>/dev/null || true
    sudo modprobe snd_usb_audio
    
    echo "Microfone da webcam ${vid}:${pid} desabilitado!"
    echo "Arquivo de configuração criado: $CONF_FILE"
}

enable_webcam_mic() {
    local vid="$1"
    local pid="$2"
    
    echo "Reabilitando microfone da webcam ${vid}:${pid}..."
    
    # Remove a regra de configuração se existir
    if [[ -f "$CONF_FILE" ]]; then
        sudo rm -f "$CONF_FILE"
        echo "Regra removida: $CONF_FILE"
        
        # Recarrega o módulo de áudio USB
        echo "Recarregando módulo snd_usb_audio..."
        sudo modprobe -r snd_usb_audio 2>/dev/null || true
        sudo modprobe snd_usb_audio
        
        echo "Microfone da webcam ${vid}:${pid} reabilitado!"
    else
        echo "Nenhuma regra encontrada em $CONF_FILE"
        echo "O microfone da webcam já deve estar habilitado."
    fi
}

# Executa a ação baseada no argumento
case "$ACTION" in
    "disable")
        disable_webcam_mic "$VENDOR" "$PRODUCT"
        ;;
    "enable")
        enable_webcam_mic "$VENDOR" "$PRODUCT"
        ;;
    *)
        echo "Erro: Ação '$ACTION' não reconhecida"
        usage
        ;;
esac
