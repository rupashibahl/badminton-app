#!/bin/bash
# Script to set up Git and prepare for GitHub push

echo "🚀 Setting up Git repository for Render deployment..."

cd "$(dirname "$0")"

# Check if git is already initialized
if [ -d .git ]; then
    echo "✅ Git is already initialized"
else
    echo "📦 Initializing Git repository..."
    git init
fi

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo "📝 Creating .gitignore..."
    cat > .gitignore << 'EOF'
venv/
__pycache__/
*.pyc
*.db-journal
.idea/
*.ipynb_checkpoints/
.DS_Store
.env
EOF
fi

echo ""
echo "✅ Repository ready!"
echo ""
echo "📋 Next steps:"
echo ""
echo "1. Create a repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Name it 'badminton-app' (or any name)"
echo "   - Don't initialize with README"
echo "   - Click 'Create repository'"
echo ""
echo "2. Run these commands (replace YOUR_USERNAME with your GitHub username):"
echo ""
echo "   git add ."
echo "   git commit -m 'Initial commit - Badminton app'"
echo "   git branch -M main"
echo "   git remote add origin https://github.com/YOUR_USERNAME/badminton-app.git"
echo "   git push -u origin main"
echo ""
echo "3. Then go to https://render.com and deploy using Blueprint!"
echo ""

