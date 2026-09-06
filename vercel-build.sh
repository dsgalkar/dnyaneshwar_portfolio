#!/bin/bash
set -e

echo "==> Setting up Flutter for Vercel build..."

# Clone Flutter stable SDK if not cached
if [ ! -d "flutter" ]; then
  echo "==> Cloning Flutter SDK (stable branch)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
else
  echo "==> Using cached Flutter SDK..."
fi

# Add Flutter to PATH
export PATH="$PATH:$(pwd)/flutter/bin"

echo "==> Configuring Flutter Web..."
flutter config --no-analytics
flutter config --enable-web

echo "==> Getting project dependencies..."
flutter pub get

echo "==> Building Flutter Web..."
flutter build web --release --base-href "/"

echo "==> Build successful! Output in build/web"
