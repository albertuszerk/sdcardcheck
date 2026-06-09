#!/bin/bash
USER_LANG="${1:-de}"

if [ "$USER_LANG" == "en" ]; then
    MSG_START="Installing X-Capacity & Speed Validator in language: $USER_LANG..."
    MSG_DONE="Installation complete! You can now find the app in your start menu."
    MENU_COMMENT="Checks SD cards for speed and real capacity"
else
    MSG_START="Installiere X-Capacity & Speed Validator in Sprache: $USER_LANG..."
    MSG_DONE="Installation abgeschlossen! Du findest die App nun im Startmenue."
    MENU_COMMENT="Prueft SD-Karten auf Geschwindigkeit und echte Kapazitaet"
fi

echo "$MSG_START"

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications

# Skript laden
curl -sL https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/sdcardcheck.sh -o ~/.local/bin/sdcardcheck.sh

# Spracheinstellung im Hauptskript ueberschreiben
sed -i "s/APP_LANG=\"de\"/APP_LANG=\"$USER_LANG\"/" ~/.local/bin/sdcardcheck.sh

chmod +x ~/.local/bin/sdcardcheck.sh

# Desktop-Starter anlegen (Mit dynamischer Sprach-Beschreibung)
cat << EOF > ~/.local/share/applications/sdcardcheck.desktop
[Desktop Entry]
Name=X-Capacity & Speed Validator
Comment=$MENU_COMMENT
Exec=/bin/bash -c "$HOME/.local/bin/sdcardcheck.sh"
Icon=drive-removable-media
Terminal=false
Type=Application
Categories=Utility;
EOF

update-desktop-database ~/.local/share/applications/ 2>/dev/null
echo "$MSG_DONE"
