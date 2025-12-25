FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Register a Python kernel inside the container
RUN python -m ipykernel install --sys-prefix

# Trust the notebook (removes "not trusted" warnings; not required but nice)
RUN python -m jupyter trust badminton.ipynb || true

EXPOSE 10000

# IMPORTANT: bind to 0.0.0.0 and use Render's PORT
CMD ["sh", "-c", "voila badminton.ipynb --no-browser --Voila.ip=0.0.0.0 --port=${PORT}"]
