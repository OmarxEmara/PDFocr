from fastapi import FastAPI, File, UploadFile
from fastapi.responses import JSONResponse
import pytesseract
from pdf2image import convert_from_bytes
from PIL import Image
import tempfile
import os

app = FastAPI()

# Set Arabic language and ensure Tesseract is configured
TESSERACT_LANG = "ara"  # for Arabic

@app.post("/ocr")
async def ocr_pdf(file: UploadFile = File(...)):
    if file.content_type != "application/pdf":
        return JSONResponse(status_code=400, content={"error": "Only PDF files are supported."})

    try:
        pdf_bytes = await file.read()
        images = convert_from_bytes(pdf_bytes)

        text_output = []
        for i, image in enumerate(images):
            # OCR each page image with Arabic support
            text = pytesseract.image_to_string(image, lang=TESSERACT_LANG)
            text_output.append(text)

        return {"text": "\n\n".join(text_output)}

    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})
