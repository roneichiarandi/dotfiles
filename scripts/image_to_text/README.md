# image_to_text Project

This project captures a screenshot from the clipboard, converts the text from the image using Optical Character Recognition (OCR), and adds the extracted text back to the clipboard.

## Project Structure

```
image_to_text
├── src
│   ├── main.py
│   ├── utils.py
│   └── __init__.py
├── requirements.txt
└── README.md
```

## Installation

To set up the project, follow these steps:

1. Clone the repository or download the project files.
2. Navigate to the project directory.
3. Create a virtual environment (optional but recommended):
   ```
   python -m venv venv
   ```
4. Activate the virtual environment:
   - On Windows:
     ```
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```
     source venv/bin/activate
     ```
5. Install the required dependencies:
   ```
   pip install -r requirements.txt
   ```


## Usage

To run a partir do código fonte:
```
python src/main.py
```

### Gerar executável nativo (Linux)
Para compilar o projeto como um executável, utilize o PyInstaller:
```
pyinstaller --onefile src/main.py
```
O executável será gerado na pasta `dist/`.

Ao executar, ele irá capturar a imagem do clipboard, extrair o texto e atualizar o clipboard com o texto extraído.


## Dependencies

### Python libraries
- Pillow: For image processing
- pytesseract: For Optical Character Recognition
- pyperclip: For clipboard operations

Install with:
```
pip install -r requirements.txt
```

### System dependencies (Linux)
- tesseract-ocr (and tesseract-ocr-por for Portuguese language)
- maim (screenshot tool)
- slop (area selection tool)
- xclip (clipboard image support)

Install with:
```
sudo apt-get install tesseract-ocr tesseract-ocr-por maim slop xclip
```

These system packages are required for multi-monitor area selection and OCR to work correctly.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.