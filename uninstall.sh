#!/bin/bash
echo "Entferne X-Capacity & Speed Validator (sdcardcheck)..."

rm -f ~/.local/bin/sdcardcheck.sh
rm -f ~/.local/share/applications/sdcardcheck.desktop

update-desktop-database ~/.local/share/applications/ 2>/dev/null
echo "Deinstallation abgeschlossen. Alle Dateien wurden restlos entfernt."
