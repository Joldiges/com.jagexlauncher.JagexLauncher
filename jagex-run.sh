#!/bin/sh
set -x
# winebin="/app/opt/lutris-GE-Proton8-22-x86_64/bin"
winebin="/app/opt/wine/bin"
wineprefix="$XDG_DATA_HOME"/prefix
runelite_location="$wineprefix/drive_c/Program Files (x86)/RuneLite"

#  First run setup
if [ ! -d "$wineprefix" ]; then
    WINEPREFIX="$wineprefix" "wineboot"

    # Place metafile in the proper location
    mkdir -p "$wineprefix/drive_c/users/$(whoami)/AppData/Local/Jagex Launcher"
    cp /app/launcher-win.production.json "$wineprefix/drive_c/users/$(whoami)/AppData/Local/Jagex Launcher/"

    # Make sure the registry has the installation location for runelite.
    WINEPREFIX="$wineprefix" WINEDEBUG="-all" "wine64" reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\RuneLite Launcher_is1" /v "InstallLocation" /t REG_SZ /d "Z:\app" /f

    # Make sure the registry has the installation location for hdos
    WINEPREFIX="$wineprefix" WINEDEBUG="-all" "wine64" reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\HDOS Launcher_is1" /v "InstallLocation" /t REG_SZ /d "Z:\app" /f

    # curl -L https://github.com/doitsujin/dxvk/releases/download/v2.3/dxvk-2.3.tar.gz > out.tar.gz
    # tar xf out.tar.gz
    # cp -r dxvk-2.3/x32/*.dll "$wineprefix/drive_c/windows/system32/"
    # cp -r dxvk-2.3/x32/*.dll "$wineprefix/drive_c/windows/syswow64/"
fi

WINEPREFIX="$wineprefix" DXVK_HUD=1 WINEDLLOVERRIDES="d3d11=n;d3d10core=n;dxgi=n;d3d9=n" "wine64" /app/JagexLauncher.exe