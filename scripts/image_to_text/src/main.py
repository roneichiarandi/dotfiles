#!/usr/bin/env python3

from utils import capture_area_to_clipboard, get_clipboard_image, extract_text_from_image
import pyperclip

def main():
    # Captura área selecionada pelo usuário e coloca no clipboard (multi-monitor, overlay opaco)
    if capture_area_to_clipboard():
        screenshot = get_clipboard_image()
        if screenshot is not None:
            text = extract_text_from_image(screenshot)
            pyperclip.copy(text)
            print("Texto extraído e copiado para o clipboard. " + text)
        else:
            print("Falha ao obter imagem do clipboard.")
    else:
        print("Falha ao capturar seleção da tela.")

if __name__ == "__main__":
    main()