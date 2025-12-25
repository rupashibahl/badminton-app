# Running the Badminton App with Voila

## Quick Start

### Option 1: Using the script (easiest)
```bash
./run_voila.sh
```

### Option 2: Manual command
```bash
source venv/bin/activate
voila badminton.ipynb --port=8866
```

### Option 3: Run in background
```bash
source venv/bin/activate
voila badminton.ipynb --port=8866 &
```

## Access the App

Once Voila is running, open your browser and go to:
- **http://localhost:8866**

The combobox autocomplete will work perfectly in the browser!

## Features

- ✅ Combobox autocomplete works in browser
- ✅ Case-insensitive matching
- ✅ Names stored and displayed in title case
- ✅ Real-time updates
- ✅ Auto-reload on notebook changes (with --autoreload flag)

## Stopping Voila

Press `Ctrl+C` in the terminal, or if running in background:
```bash
pkill -f voila
```

## Deployment Options

### Local Network Access
To access from other devices on your network:
```bash
voila badminton.ipynb --port=8866 --host=0.0.0.0
```
Then access via: `http://YOUR_IP_ADDRESS:8866`

### Production Deployment
For production, consider:
- **Voila GridStack** - Better layout options
- **JupyterHub** - Multi-user deployment
- **Docker** - Containerized deployment
- **Cloud platforms** - AWS, GCP, Azure with Jupyter services

