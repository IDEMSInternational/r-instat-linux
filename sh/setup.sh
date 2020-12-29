#############################################
## R-Instat Linux install for Ubuntu 18.04 ##
#############################################

## Setup Wine and dependencies

mkdir /tmp/r-instat-setup; cd /tmp/r-instat-setup

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
sudo apt install -y ./libfaudio0_19.07-0~bionic_amd64.deb
sudo apt install -y ./libfaudio0_19.07-0~bionic_i386.deb

# Install the latest wine-stable
sudo apt install -y --install-recommends winehq-stable


## 32-bit .NET manual install tested on Wine 5.0.1

# Install winetricks to install base .NET 4.0
sudo wget 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -O /usr/local/bin/winetricks
sudo chmod +x /usr/local/bin/winetricks

# Initialise Wine with 32-bit architecture and supress messages boxes to install Mono and Gecko (for HTML rendering)
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 WINEDLLOVERRIDES="mscoree,mshtml=" wineboot –init

# Install of .NET Framework 4.0 through winetricks
sudo apt-get install -y cabextract  # for corefonts install
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 winetricks -q dotnet40 corefonts

# Install of .NET Framework 4.6.1 manually
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 winetricks win7
wget 'https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe'
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wine ./NDP461-KB3102436-x86-x64-AllOS-ENU.exe /q

# Verify .NET Framework setup (manual step using a GUI)
#wget 'https://msdnshared.blob.core.windows.net/media/2018/05/netfx_setupverifier_new.zip'
#unzip netfx_setupverifier_new.zip
#env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wine ./netfx_setupverifier.exe
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wineboot -e

# Direct link to R-instat Installer 0.6.4 32-bit (not working from Google Drive, see issue GitHub/#1)
# ** CURRENTLY REQUIRES DOWNLOADING FROM A BROWSER TO ACKNOWLEDGE THAT GOOGLE HASN'T PERFORMED A VIRUS CHECK **
wget https://drive.google.com/uc?export=download&id=1kqifLWe5Skv0y_L7cSp6n4H411ZbXViq

# Install R-Instat
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wineboot –init
env WINEPREFIX=$HOME/winedotnet WINEARCH=win32 wine ./R-Instat_0.6.4_Installer_32.exe
