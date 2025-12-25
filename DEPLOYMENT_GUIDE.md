# Deployment Guide for Badminton App

## How Voila Works

Voila converts your Jupyter notebook into a **standalone web application**:

1. **Renders your notebook** - Executes the notebook and shows only the output (no code cells visible)
2. **Interactive widgets** - Your ipywidgets (comboboxes, buttons, etc.) work in the browser
3. **Web server** - Creates a web server that serves your app via HTTP
4. **Real-time updates** - Widget interactions update the app in real-time

## Quick Start - Run Locally

### Method 1: Simple Run
```bash
cd "/Users/sjsurupashi/Badminton copy"
source venv/bin/activate
voila badminton.ipynb
```

This will:
- Start a server (usually on http://localhost:8866)
- Open automatically in your browser
- Show your app with all widgets working

### Method 2: Custom Port
```bash
voila badminton.ipynb --port=8080
```

### Method 3: Accessible on Network
```bash
voila badminton.ipynb --port=8866 --host=0.0.0.0
```
Then access from other devices: `http://YOUR_IP:8866`

## Deployment Options

### Option 1: Local Network (Simple)
**Use case:** Share with people on your local network (home/office)

```bash
# Find your IP address
ifconfig | grep "inet " | grep -v 127.0.0.1

# Run Voila accessible on network
voila badminton.ipynb --port=8866 --host=0.0.0.0 --no-browser
```

**Pros:**
- ✅ Simple setup
- ✅ No external services needed
- ✅ Fast and private

**Cons:**
- ❌ Only works when your computer is on
- ❌ Only accessible on same network
- ❌ Not accessible from internet

---

### Option 2: Cloud VM (AWS/GCP/Azure)
**Use case:** Deploy to a cloud server for internet access

**Steps:**
1. Create a VM (Ubuntu/Debian)
2. Install Python and dependencies
3. Copy your notebook and database
4. Run Voila as a service

**Example setup script:**
```bash
# On your VM
sudo apt update
sudo apt install python3 python3-pip python3-venv

# Create project directory
mkdir -p ~/badminton-app
cd ~/badminton-app

# Upload your files (use scp, git, etc.)
# badminton.ipynb
# badminton_customer.db

# Setup virtual environment
python3 -m venv venv
source venv/bin/activate
pip install voila ipywidgets sqlalchemy

# Run Voila
voila badminton.ipynb --port=8866 --host=0.0.0.0 --no-browser
```

**Run as systemd service:**
Create `/etc/systemd/system/voila.service`:
```ini
[Unit]
Description=Voila Badminton App
After=network.target

[Service]
Type=simple
User=your-username
WorkingDirectory=/home/your-username/badminton-app
Environment="PATH=/home/your-username/badminton-app/venv/bin"
ExecStart=/home/your-username/badminton-app/venv/bin/voila badminton.ipynb --port=8866 --host=0.0.0.0 --no-browser
Restart=always

[Install]
WantedBy=multi-user.target
```

Then:
```bash
sudo systemctl enable voila
sudo systemctl start voila
```

**Pros:**
- ✅ Accessible from anywhere
- ✅ Professional deployment
- ✅ Can run 24/7

**Cons:**
- ❌ Costs money (VM fees)
- ❌ Requires server management
- ❌ More complex setup

---

### Option 3: Docker (Recommended for Production)
**Use case:** Consistent deployment across environments

**Create `Dockerfile`:**
```dockerfile
FROM python:3.13-slim

WORKDIR /app

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY badminton.ipynb .
COPY badminton_customer.db .

# Expose port
EXPOSE 8866

# Run Voila
CMD ["voila", "badminton.ipynb", "--port=8866", "--host=0.0.0.0", "--no-browser"]
```

**Create `requirements.txt`:**
```
voila
ipywidgets
sqlalchemy
```

**Build and run:**
```bash
docker build -t badminton-app .
docker run -p 8866:8866 badminton-app
```

**Deploy to cloud:**
- AWS ECS/Fargate
- Google Cloud Run
- Azure Container Instances
- DigitalOcean App Platform

**Pros:**
- ✅ Consistent environment
- ✅ Easy to scale
- ✅ Works anywhere Docker runs

**Cons:**
- ❌ Need to learn Docker basics
- ❌ Need to handle database persistence

---

### Option 4: Binder (Free, Easy)
**Use case:** Quick sharing and demos

1. Push your notebook to GitHub
2. Go to https://mybinder.org
3. Enter your GitHub repo URL
4. Click "launch"

**Pros:**
- ✅ Free
- ✅ No setup needed
- ✅ Great for demos/sharing

**Cons:**
- ❌ Sessions timeout (inactive after 10 min)
- ❌ Not persistent (data resets)
- ❌ Limited resources

---

### Option 5: Heroku/Railway/Render (Platform as a Service)
**Use case:** Easy deployment without server management

**For Render.com example:**

1. Create `render.yaml`:
```yaml
services:
  - type: web
    name: badminton-app
    env: docker
    dockerfilePath: ./Dockerfile
    dockerContext: .
    plan: free
    envVars:
      - key: PORT
        value: 8866
```

2. Push to GitHub
3. Connect to Render
4. Deploy automatically

**Pros:**
- ✅ Easy setup
- ✅ Free tiers available
- ✅ Automatic HTTPS
- ✅ Auto-deploy from Git

**Cons:**
- ❌ Free tiers have limitations
- ❌ May need to adapt for platform

---

## Security Considerations

### For Production:

1. **Add authentication:**
```bash
voila badminton.ipynb --Voila.password_required=True
```

2. **Use HTTPS:**
   - Use reverse proxy (nginx) with SSL
   - Or use platform-provided HTTPS (Render, Heroku, etc.)

3. **Restrict access:**
   - Use firewall rules
   - Use VPN for private networks

4. **Database backup:**
   - Regularly backup `badminton_customer.db`
   - Consider using managed database services

## Recommended Deployment Path

**For personal use:**
→ Option 1 (Local Network) or Option 4 (Binder for sharing)

**For business/serious use:**
→ Option 3 (Docker) or Option 5 (PaaS like Render)

**For learning/testing:**
→ Option 4 (Binder) or local development

## Testing Your Deployment

After deployment, test:
1. ✅ App loads in browser
2. ✅ Combobox autocomplete works
3. ✅ Can create new customers
4. ✅ Can add rackets
5. ✅ Can update counts/completed
6. ✅ Database persists data

## Troubleshooting

**Port already in use:**
```bash
voila badminton.ipynb --port=8888  # Use different port
```

**Can't access from other devices:**
- Check firewall settings
- Use `--host=0.0.0.0` flag
- Verify IP address

**Widgets not working:**
- Ensure you're accessing via browser (not PyCharm)
- Check browser console for errors
- Verify all dependencies installed

## Next Steps

1. **Test locally first** - Make sure everything works
2. **Choose deployment option** - Based on your needs
3. **Set up backup** - For your database
4. **Monitor** - Check logs and usage

