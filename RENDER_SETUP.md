# Render.com Deployment Setup Guide

## Step-by-Step Instructions

### Step 1: Create GitHub Repository

1. Go to https://github.com and sign in
2. Click the "+" icon → "New repository"
3. Name it: `badminton-app` (or any name you prefer)
4. Make it **Public** or **Private** (your choice)
5. **DO NOT** initialize with README, .gitignore, or license
6. Click "Create repository"

### Step 2: Initialize Git and Push Code

Run these commands in your terminal (from the Badminton copy directory):

```bash
cd "/Users/sjsurupashi/Badminton copy"

# Initialize git (if not already done)
git init

# Create .gitignore to exclude unnecessary files
cat > .gitignore << 'EOF'
venv/
__pycache__/
*.pyc
*.db-journal
.idea/
*.ipynb_checkpoints/
.DS_Store
EOF

# Add all files
git add .

# Commit
git commit -m "Initial commit - Badminton app"

# Add your GitHub repo as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/badminton-app.git

# Push to GitHub
git branch -M main
git push -u origin main
```

**Note:** You'll need to authenticate with GitHub. You can use:
- Personal Access Token (recommended)
- GitHub CLI (`gh auth login`)

### Step 3: Create render.yaml

I've created a `render.yaml` file for you. This tells Render how to deploy your app.

### Step 4: Deploy on Render

1. Go to https://render.com and sign up/login (use GitHub to sign in)

2. Click "New +" → "Blueprint"

3. Connect your GitHub account if not already connected

4. Select your repository: `badminton-app`

5. Render will detect the `render.yaml` file automatically

6. Click "Apply"

7. Render will:
   - Build your Docker image
   - Deploy your app
   - Give you a public URL like `https://badminton-app.onrender.com`

### Step 5: Access Your App

Once deployment completes:
- Visit the URL Render provides
- Your app will be live on the internet!
- Combobox autocomplete will work perfectly

## Important Notes

### Database Persistence

⚠️ **Important:** Render's free tier has **ephemeral storage** - your database will reset if the service goes to sleep.

**Solutions:**
1. **Keep service awake** (paid plan)
2. **Use external database:**
   - Render PostgreSQL (free tier available)
   - SQLite with external storage (cloud storage)
   - Convert to PostgreSQL in the code

### Free Tier Limitations

- Services "spin down" after 15 minutes of inactivity
- May take 30-60 seconds to wake up
- 512 MB RAM limit
- 100 GB bandwidth/month

### Updating Your App

Every time you push to GitHub, Render will automatically redeploy:
```bash
git add .
git commit -m "Update app"
git push
```

## Troubleshooting

**Build fails:**
- Check build logs in Render dashboard
- Verify all files are in GitHub
- Ensure `requirements.txt` is correct

**App doesn't work:**
- Check service logs in Render
- Verify database file is included
- Check if port is correctly set

**Database resets:**
- Normal on free tier when service sleeps
- Consider upgrading or using external database

## Next Steps

1. ✅ Push code to GitHub
2. ✅ Create Render account
3. ✅ Connect GitHub to Render
4. ✅ Deploy using Blueprint
5. ✅ Test your live app!

