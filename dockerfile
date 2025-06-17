FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system packages and Tesseract (including Arabic)
RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-ara poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose the default FastAPI port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system packages and Tesseract (including Arabic)
RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-ara poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose the default FastAPI port
EXPOSE 8000

# Run the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
