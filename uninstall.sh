#!/bin/bash
USER_LANG="${1:-de}"

if [ "$USER_LANG" == "en" ]; then
    MSG_START="Removing X-Capacity & Speed Validator (sdcardcheck)..."
    MSG_DONE="Uninstallation complete. All files have been completely removed."
else
    MSG_START="Entferne X-Capacity & Speed Validator (sdcardcheck)..."
    MSG_DONE="Deinstallation abgeschlossen. Alle Dateien wurden restlos entfernt."
fi

echo "$MSG_START"

rm -f ~/.local/bin/sdcardcheck.sh
rm -f ~/.local/share/applications/sdcardcheck.desktop

update-desktop-database ~/.local/share/applications/ 2>/dev/null
echo "$MSG_DONE"
