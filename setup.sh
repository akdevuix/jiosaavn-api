#!/bin/bash

# JioSaavn API - Vercel Serverless Quick Start Script

echo "🎵 JioSaavn API - Vercel Serverless Quick Start"
echo "=============================================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18.x or higher."
    exit 1
fi

echo "✅ Node.js version: $(node -v)"
echo ""

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed."
    exit 1
fi

echo "✅ npm version: $(npm -v)"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies."
    exit 1
fi

echo "✅ Dependencies installed successfully"
echo ""

# Build the project
echo "🔨 Building the project..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Build failed."
    exit 1
fi

echo "✅ Build completed successfully"
echo ""

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📥 Installing Vercel CLI..."
    npm install -g vercel
fi

echo "✅ Vercel CLI is ready"
echo ""

echo "🚀 Quick Start Options:"
echo ""
echo "1. Local Development:"
echo "   npm run dev"
echo ""
echo "2. Deploy to Vercel (Preview):"
echo "   vercel"
echo ""
echo "3. Deploy to Vercel (Production):"
echo "   vercel --prod"
echo ""
echo "📚 For more information, see:"
echo "   - README.md - Project overview"
echo "   - DEPLOYMENT.md - Detailed deployment guide"
echo "   - MIGRATION.md - Migration details"
echo ""
echo "✨ Setup complete! You're ready to deploy."