FROM python:3.13-slim

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY badminton.ipynb .
# Copy database if it exists (will be created if not)
COPY badminton_customer.db* ./

# Expose port (Render will set PORT env var)
EXPOSE 10000

# Run Voila (use PORT env var that Render provides)
CMD ["sh", "-c", "voila badminton.ipynb --no-browser --Voila.ip=0.0.0.0 --port=${PORT}"]

