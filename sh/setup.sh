#############################################
## R-Instat Linux install for Ubuntu 18.04 ##
#############################################

## Setup Wine and dependencies

# Wine has significantly better support for 32-bit applications
sudo dpkg --add-architecture i386

# Add the WineHQ Ubuntu repository
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'

# Update the package manager database
sudo apt update

# Wine 4.5+ require 32-bit and 64-bit versions of libfaudio0 (which is not available from ubuntu repositories
wget -nc https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/amd64/libfaudio0_19.07-0~bionic_amd64.deb
wget -nc https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/i386/libfaudio0_19.07-0~bionic_i386.deb
sudo apt install ./libfaudio0_19.07-0~bionic_amd64.deb
sudo apt install ./libfaudio0_19.07-0~bionic_i386.deb

# Install the latest wine-stable
sudo apt install --install-recommends winehq-stable


## 32-bit .NET manual install tested on Wine 5.0.1

# Install winetricks to install base .NET 4.0
sudo wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -O /usr/local/bin/winetricks
sudo chmod +x /usr/local/bin/winetricks

# Initialise Wine
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wineboot –init

# Install .NET 4.0 through winetricks

sudo apt-get install cabextract  # for corefonts install
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 winetricks dotnet40 corefonts





# Direct link to R-instat Installer 0.6.2 32-bit (not working from Google Drive)
wget https://drive.google.com/uc?export=download&id=16scomKqnFT_Q2CS8BfZim9nme6jBwk1z
