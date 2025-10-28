# Captura área selecionada pelo usuário (multi-monitor) e coloca no clipboard
def capture_area_to_clipboard():
    import subprocess
    result = subprocess.run(
        "maim -s | xclip -selection clipboard -t image/png",
        shell=True
    )
    return result.returncode == 0

# Obtém imagem do clipboard (PNG)
def get_clipboard_image():
    import subprocess
    from PIL import Image
    import io
    try:
        result = subprocess.run(
            ["xclip", "-selection", "clipboard", "-t", "image/png", "-o"],
            stdout=subprocess.PIPE, 
            stderr=subprocess.PIPE
        )
        if result.returncode == 0 and result.stdout:
            return Image.open(io.BytesIO(result.stdout))
    except Exception as e:
        print("Erro ao acessar o clipboard:", e)
    return None

def extract_text_from_image(image):
    import pytesseract
    image = preprocess_image(image)
    text = pytesseract.image_to_string(image, lang='por')
    return text.strip()

# Detecta se o fundo da imagem é escuro

def is_dark_background(img):
    gray = img.convert('L')
    mean_brightness = sum(gray.getdata()) / (gray.width * gray.height)
    return mean_brightness < 128

# Pré-processa imagem para OCR, só inverte se fundo for escuro

def preprocess_image(img):
    from PIL import ImageOps, ImageEnhance
    img = img.convert('L')
    if is_dark_background(img):
        print("dark")
        img = ImageOps.invert(img)
    enhancer = ImageEnhance.Contrast(img)
    img = enhancer.enhance(2)
    img = img.point(lambda x: 0 if x < 128 else 255, '1')
    return img