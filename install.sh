#!/usr/bin/env bash
set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required but was not found in PATH." >&2
  exit 1
fi

install_linux_deps() {
  if command -v apt-get >/dev/null 2>&1; then
    apt_pkg() {
      if apt-cache show "$1" >/dev/null 2>&1; then
        echo "$1"
      else
        echo "$2"
      fi
    }

    local libasound_pkg
    local libatk_bridge_pkg
    local libatk_pkg
    local libgtk_pkg
    libasound_pkg="$(apt_pkg libasound2t64 libasound2)"
    libatk_bridge_pkg="$(apt_pkg libatk-bridge2.0-0t64 libatk-bridge2.0-0)"
    libatk_pkg="$(apt_pkg libatk1.0-0t64 libatk1.0-0)"
    libgtk_pkg="$(apt_pkg libgtk-3-0t64 libgtk-3-0)"

    if ! sudo apt-get update; then
      echo "apt-get update failed; trying installation with existing package indexes." >&2
    fi
    sudo apt-get install -y --no-install-recommends \
      ca-certificates \
      fonts-liberation \
      "$libasound_pkg" \
      "$libatk_bridge_pkg" \
      "$libatk_pkg" \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libgbm1 \
      libglib2.0-0 \
      "$libgtk_pkg" \
      libnspr4 \
      libnss3 \
      libpango-1.0-0 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxshmfence1 \
      libxss1 \
      libxtst6 \
      xdg-utils
    return
  fi

  if command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y \
      atk \
      at-spi2-atk \
      alsa-lib \
      cairo \
      cups-libs \
      dbus-libs \
      gtk3 \
      libX11 \
      libXcomposite \
      libXcursor \
      libXdamage \
      libXext \
      libXfixes \
      libXi \
      libXrandr \
      libXrender \
      libXScrnSaver \
      libXtst \
      nspr \
      nss \
      pango \
      xdg-utils
    return
  fi

  if command -v yum >/dev/null 2>&1; then
    sudo yum install -y \
      atk \
      at-spi2-atk \
      alsa-lib \
      cairo \
      cups-libs \
      dbus-glib \
      gtk3 \
      libX11 \
      libXcomposite \
      libXcursor \
      libXdamage \
      libXext \
      libXfixes \
      libXi \
      libXrandr \
      libXrender \
      libXScrnSaver \
      libXtst \
      nspr \
      nss \
      pango \
      xdg-utils
    return
  fi

  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm \
      alsa-lib \
      atk \
      at-spi2-atk \
      cairo \
      cups \
      dbus \
      gtk3 \
      libx11 \
      libxcomposite \
      libxcursor \
      libxdamage \
      libxext \
      libxfixes \
      libxi \
      libxrandr \
      libxrender \
      libxss \
      libxtst \
      nspr \
      nss \
      pango \
      xdg-utils
    return
  fi

  if command -v apk >/dev/null 2>&1; then
    sudo apk add --no-cache \
      alsa-lib \
      atk \
      at-spi2-atk \
      cairo \
      cups-libs \
      dbus-libs \
      gtk+3.0 \
      libx11 \
      libxcomposite \
      libxcursor \
      libxdamage \
      libxext \
      libxfixes \
      libxi \
      libxrandr \
      libxrender \
      libxss \
      libxtst \
      nss \
      pango \
      xdg-utils
    return
  fi

  echo "Could not find a supported Linux package manager (apt, dnf, yum, pacman, apk)." >&2
  exit 1
}

case "$(uname -s)" in
  Linux)
    install_linux_deps
    ;;
  Darwin)
    echo "macOS does not require extra system packages for Puppeteer in most setups."
    ;;
  *)
    echo "Unsupported OS: $(uname -s). Use install.ps1 on Windows." >&2
    exit 1
    ;;
esac

npx puppeteer browsers install chrome
echo "Puppeteer prerequisites installed successfully."
