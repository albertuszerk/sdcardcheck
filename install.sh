#!/bin/bash
USER_LANG="${1:-de}"
echo "Installiere X-Capacity & Speed Validator in Sprache: $USER_LANG..."

mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications

# Skript laden
curl -sL https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/sdcardcheck.sh -o ~/.local/bin/sdcardcheck.sh

# Spracheinstellung im Skript ueberschreiben
sed -i "s/APP_LANG=\"de\"/APP_LANG=\"$USER_LANG\"/" ~/.local/bin/sdcardcheck.sh

chmod +x ~/.local/bin/sdcardcheck.sh

# Desktop-Starter anlegen (Name korrigiert!)
cat << 'EOF' > ~/.local/share/applications/sdcardcheck.desktop
[Desktop Entry]
Name=X-Capacity & Speed Validator
Comment=Prueft SD-Karten auf Geschwindigkeit und echte Kapazitaet
Exec=/bin/bash -c "$HOME/.local/bin/sdcardcheck.sh"
Icon=drive-removable-media
Terminal=false
Type=Application
Categories=Utility;
EOF

update-desktop-database ~/.local/share/applications/ 2>/dev/null
echo "Installation abgeschlossen! Du findest die App nun im Startmenue."
