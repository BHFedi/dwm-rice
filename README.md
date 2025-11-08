# 🎨 Suckless Environment Configuration

A minimal, customized Linux desktop environment built on suckless tools with personal configurations and patches.

## 📋 Table of Contents

- [Overview](#overview)
- [Components](#components)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Patches Applied](#patches-applied)
- [Customization](#customization)

---

## 🎯 Overview

This repository contains a complete suckless desktop environment configuration including:

- **dwm** - Dynamic window manager (with custom patches)
- **st** - Simple terminal (with Nord theme and scrollback)
- **dmenu** - Dynamic menu for launching applications
- **slstatus** - Status bar for dwm
- Custom X11 and input configurations

### Philosophy

Following the suckless philosophy: software that sucks less, is lightweight, fast, and highly customizable through source code modification rather than bloated configuration files.

---

## 🧩 Components

### Window Manager (dwm)
- **Tiling window manager** with dynamic layouts
- **Custom patches** for enhanced functionality
- **Status bar** powered by slstatus
- **Keyboard-driven** workflow

### Terminal (st)
- **Simple Terminal** - fast, lightweight
- **Nord color scheme** for comfortable viewing
- **Scrollback support** with mouse wheel
- **Clipboard integration**

### Application Launcher (dmenu)
- **Fast program launcher** bound to `Mod+p`
- **Minimal footprint**
- **Custom styling** to match dwm

### Status Bar (slstatus)
- **System information** display
- **Modular components** (CPU, RAM, battery, etc.)
- **Lightweight** and efficient

---

## 📦 Prerequisites

### Required Packages

#### Arch Linux / Manjaro
```bash
sudo pacman -S base-devel libx11 libxft libxinerama \
    freetype2 fontconfig xorg-server xorg-xinit \
    alsa-utils brightnessctl dbus feh
```

#### Debian / Ubuntu
```bash
sudo apt install build-essential libx11-dev libxft-dev \
    libxinerama-dev libfreetype6-dev libfontconfig1-dev \
    xorg xinit alsa-utils brightnessctl dbus feh
```

#### Fedora
```bash
sudo dnf install @development-tools libX11-devel \
    libXft-devel libXinerama-devel freetype-devel \
    fontconfig-devel xorg-x11-server-Xorg xinit \
    alsa-utils brightnessctl dbus feh
```

### Optional Dependencies

```bash
# For better font rendering
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts

# For file manager integration (if using broot)
# cargo install broot

# For system information display
# fastfetch or neofetch
```

---

## 🚀 Installation

### 1. Clone or Extract Configuration

```bash
# If you have this as a git repository
git clone https://github.com/yourusername/suckless-config.git ~/suckless-config
cd ~/suckless-config

# Or if you're setting up manually
mkdir -p ~/suckless-config
# Copy your files here
```

### 2. Install Suckless Tools

Each suckless tool needs to be compiled and installed:

```bash
cd ~/suckless-config/suckless

# Install dwm
cd dwm
sudo make clean install

# Install st
cd ../st
sudo make clean install

# Install dmenu
cd ../dmenu
sudo make clean install

# Install slstatus
cd ../slstatus
sudo make clean install
```

### 3. Copy Configuration Files

```bash
# Copy .xinitrc
cp ~/suckless-config/.xinitrc ~/.xinitrc

# Copy .bashrc (backup existing first!)
cp ~/.bashrc ~/.bashrc.backup
cp ~/suckless-config/.bashrc ~/.bashrc

# Copy X11 configurations
sudo cp ~/suckless-config/xorg.conf.d/* /etc/X11/xorg.conf.d/

# Copy wallpaper
mkdir -p ~/Pictures
cp ~/suckless-config/suckless/wallpaper.jpg ~/Pictures/
```

### 4. Set Wallpaper Path (Optional)

Edit `.xinitrc` and uncomment the wallpaper line:

```bash
vim ~/.xinitrc
# Change:
# feh --bg-scale /path/to/wallpaper.jpg &
```

### 5. Start X Session

```bash
# From TTY (after login)
startx
```

---

## ⚙️ Configuration

### .xinitrc Configuration

The `.xinitrc` file controls what happens when X starts:

```shellscript
# Set the wallpaper
feh --bg-scale ~/Pictures/wallpaper.jpg &

# Start status bar
slstatus &

# Start dwm with dbus session
exec dbus-run-session dwm
```

**Customization Options**:
- Add programs to autostart: `program &` before `exec dwm`
- Change wallpaper: modify the `feh` line
- Add compositor: `picom &` (for transparency/shadows)

### .bashrc Configuration

Your `.bashrc` contains:

```shellscript
export EDITOR=nvim  # Default text editor

# Optional: Enable fastfetch on terminal start
# fastfetch -l /path/to-ascii-art -c /path/to-config.jsonc

# Optional: Broot file manager integration
# source ~/.config/broot/launcher/bash/br
```

**Common Additions**:
```bash
# Aliases
alias ll='ls -alh'
alias update='sudo pacman -Syu'  # Arch
alias ..='cd ..'

# Custom prompt
PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
```

### Keyboard Layout

French keyboard with NumLock settings:

```
# /etc/X11/xorg.conf.d/00-keyboard.conf

Section "InputClass"
    Identifier "system-keyboard"
    MatchIsKeyboard "on"
    Option "XkbLayout" "fr"           # French layout
    Option "XkbOptions" "numpad:mac"  # NumLock always on
EndSection
```

**Change Keyboard Layout**:
```bash
# To US layout
sudo sed -i 's/XkbLayout" "fr"/XkbLayout" "us"/' /etc/X11/xorg.conf.d/00-keyboard.conf
```

### Touchpad Configuration

Tap-to-click and drag enabled:

```
# /etc/X11/xorg.conf.d/50-libinput.conf

Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    Option "Tapping" "True"        # Tap to click
    Option "TappingDrag" "True"    # Tap and drag
    Driver "libinput"
EndSection
```

---

## 🎨 Patches Applied

### dwm Patches

Located in `suckless/dwm/patches/`:

| Patch | Description |
|-------|-------------|
| **alternativetags** | Alternative tag display |
| **alwayscenter** | Center floating windows |
| **amixer-integration** | Volume control with amixer |
| **backlight** | Brightness control integration |
| **barpadding** | Add padding to status bar |
| **fullgaps** | Gaps between windows |
| **gaps** | Additional gap functionality |
| **tagcolorscheme** | Custom colors per tag |

**Key Features**:
- 🎨 Gaps between windows for aesthetics
- 🔊 Volume control with keyboard shortcuts
- 💡 Brightness control with keyboard shortcuts
- 📊 Enhanced status bar with padding
- 🎯 Centered floating windows

### st Patches

Located in `suckless/st/patches/`:

| Patch | Description |
|-------|-------------|
| **clipboard** | Better clipboard integration |
| **no_bold_colors** | Disable bold color variants |
| **nordtheme** | Nord color scheme |
| **scrollback** | Scrollback buffer support |
| **scrollback-mouse** | Mouse wheel scrolling |
| **xresources** | Load colors from .Xresources |

**Key Features**:
- 🎨 Beautiful Nord color scheme
- 📜 Scroll through terminal history
- 🖱️ Mouse wheel support
- 📋 System clipboard integration

---

## 🎨 Customization

### Modifying dwm

1. **Edit configuration**:
```bash
cd ~/suckless-config/suckless/dwm
vim config.h
```

2. **Common customizations**:
```c
// Change mod key (Mod1Mask = Alt, Mod4Mask = Super)
#define MODKEY Mod4Mask

// Change gaps size
static const unsigned int gappx = 10;  // Gap size in pixels

// Change colors
static const char col_gray1[]  = "#222222";  // Background
static const char col_cyan[]   = "#005577";  // Focused border
```

3. **Recompile and install**:
```bash
sudo make clean install
```

4. **Restart dwm**: `Mod+Shift+r`

### Modifying st

1. **Edit configuration**:
```bash
cd ~/suckless-config/suckless/st
vim config.h
```

2. **Common customizations**:
```c
// Change font
static char *font = "Hack:pixelsize=14:antialias=true";

// Change opacity (requires compositor)
unsigned int alpha = 0xdd;  // 0xff = opaque, 0x00 = transparent

// Change terminal size
static unsigned int cols = 80;
static unsigned int rows = 24;
```

3. **Recompile and install**:
```bash
sudo make clean install
```

### Modifying slstatus

1. **Edit configuration**:
```bash
cd ~/suckless-config/suckless/slstatus
vim config.h
```

2. **Example configuration**:
```c
static const struct arg args[] = {
    /* function     format          argument */
    { cpu_perc,     "CPU: %s%% | ", NULL },
    { ram_perc,     "RAM: %s%% | ", NULL },
    { battery_perc, "BAT: %s%% | ", NULL },
    { datetime,     "%s",           "%F %T" },
};
```

3. **Available components**:
- `battery_perc` - Battery percentage
- `cpu_perc` - CPU usage
- `ram_perc` - RAM usage
- `disk_perc` - Disk usage
- `wifi_essid` - WiFi network name
- `datetime` - Date and time
- `vol_perc` - Volume level
- `temp` - Temperature

4. **Recompile and install**:
```bash
sudo make clean install
```

5. **Restart slstatus**:
```bash
pkill slstatus && slstatus &
```

### Adding New Patches

1. **Download patch**:
```bash
cd ~/suckless-config/suckless/dwm/patches
wget https://dwm.suckless.org/patches/patch-name/dwm-patch-name.diff
```

2. **Apply patch**:
```bash
cd ..
patch -p1 < patches/dwm-patch-name.diff
```

3. **Resolve conflicts** if any, then:
```bash
sudo make clean install
```

---

## 📚 Resources

### Official Documentation
- [dwm.suckless.org](https://dwm.suckless.org/)
- [st.suckless.org](https://st.suckless.org/)
- [tools.suckless.org/dmenu](https://tools.suckless.org/dmenu/)
- [tools.suckless.org/slstatus](https://tools.suckless.org/slstatus/)

### Community Resources
- [r/suckless](https://reddit.com/r/suckless) - Reddit community
- [Arch Wiki - dwm](https://wiki.archlinux.org/title/Dwm)
- [Suckless Patches](https://dwm.suckless.org/patches/)

### Recommended Software
- **Terminal**: st, alacritty, kitty
- **File Manager**: ranger, lf, nnn
- **Browser**: qutebrowser, firefox
- **Editor**: vim, neovim, emacs
- **Media**: mpv, feh
- **Compositor**: picom (for transparency/shadows)

---


## 🤝 Contributing

Feel free to fork this configuration and adapt it to your needs! If you have improvements or find issues, please share them.

---

**Built with ❤️ and suckless philosophy** 🚀
