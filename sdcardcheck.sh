#!/bin/bash
# ====================================================
# Short Name: sdcardcheck
# Long Name:  X-Capacity & Speed Validator for sd cards v1.0
# Author:     Albertus Zerk
# ====================================================

APP_LANG="de" # Wird durch install.sh geaendert, falls Parameter mitgegeben wird

# --- SPRACH-VARIABLEN ---
if [ "$APP_LANG" == "en" ]; then
    # ENGLISCH
    TXT_WELCOME="Welcome to the App Wizard.\nPlease select an action:"
    TXT_BTN_START="Test SD Card/Drive"
    TXT_BTN_UNINSTALL="Completely remove app from system"
    TXT_BTN_EXIT="Exit Wizard"
    TXT_SEL_DRIVE="a) Select drive (e.g., under /media/)"
    TXT_WARN_TITLE="b) Security Confirmation"
    TXT_WARN_TEXT="WARNING: ALL data in the directory\n\n%s\n\nwill now be completely deleted!\n\nAre you absolutely sure?"
    TXT_ERR_PERM="Error during deletion. Please check access permissions."
    TXT_INFO_START="Step 1: The drive will now be filled with test data.\nStep 2: The data will be verified for authenticity."
    TXT_PROG_WRITE="Write process running..."
    TXT_INIT="Initializing..."
    TXT_ERR_WRITE="ERROR during write process!\nThe drive is write-protected or defective."
    TXT_PROG_READ="Verification process running..."
    TXT_VERIFYING="Verifying data..."
    TXT_ERR_READ="ERROR during read process!\nWarning: This is highly likely a counterfeit SD card (Fake Capacity) or contains defective sectors!"
    TXT_SPEED_TITLE="Mini Speed Test"
    TXT_SPEED_TEXT="Starting Mini Test now (Read/Write 500MB)."
    TXT_SUMMARY_TITLE="Test Summary"
    TXT_SUMMARY_TEXT="<b>Test completed!</b>\n\n<b>Drive (Hardware):</b> %s\n<b>Theoretical Capacity:</b> %s\n<b>Real Capacity (verified):</b> %s\n\n<b>1. Status:</b>\n%s\n\n<b>2. Mini Speed Test:</b>\n%s\n\n<i>All temporary data has been deleted. The drive is empty.</i>"
    TXT_UNINSTALL_OK="App and menu entry have been completely removed from the system."
    
    # Status-Meldungen (Zusammenfassung)
    TXT_RES_WRITE_ERR="FAILED (Write Error)"
    TXT_RES_NO_WRITE="Could not be written"
    TXT_RES_FAKE="FAILED (Fake/Defective)"
    TXT_RES_TOTAL_FAIL="0.00 Byte (Total Failure)"
    TXT_RES_PASS="PASSED (Capacity genuine)"
    TXT_RES_VERIFIED="(Verified)"
    TXT_SPEED_WRITE="Write"
    TXT_SPEED_READ="Read"
    TXT_ERR_MEASURE="Measurement Error"

else
    # DEUTSCH (Standard)
    TXT_WELCOME="Willkommen beim App-Wizard.\nBitte waehle eine Aktion:"
    TXT_BTN_START="SD-Karte/Laufwerk testen"
    TXT_BTN_UNINSTALL="App komplett vom System entfernen"
    TXT_BTN_EXIT="Wizard beenden"
    TXT_SEL_DRIVE="a) Laufwerk auswaehlen (z.B. unter /media/)"
    TXT_WARN_TITLE="b) Sicherheitsabfrage"
    TXT_WARN_TEXT="ACHTUNG: ALLE Daten im Verzeichnis\n\n%s\n\nwerden jetzt restlos geloescht!\n\nBist du absolut sicher?"
    TXT_ERR_PERM="Fehler beim Loeschen. Bitte pruefe die Zugriffsrechte."
    TXT_INFO_START="Schritt 1: Das Laufwerk wird nun mit Testdaten gefuellt.\nSchritt 2: Die Daten werden auf Echtheit geprueft."
    TXT_PROG_WRITE="Schreibvorgang laeuft..."
    TXT_INIT="Initialisiere..."
    TXT_ERR_WRITE="FEHLER beim Schreiben!\nDas Laufwerk ist schreibgeschuetzt oder defekt."
    TXT_PROG_READ="Pruefvorgang laeuft..."
    TXT_VERIFYING="Verifiziere Daten..."
    TXT_ERR_READ="FEHLER beim Lesen!\nWarnung: Dies ist hochwahrscheinlich eine gefaelschte SD-Karte (Fake Capacity) oder Sektoren sind defekt!"
    TXT_SPEED_TITLE="Mini-Speed-Test"
    TXT_SPEED_TEXT="Starte nun den Mini-Test (Lesen/Schreiben von 500MB)."
    TXT_SUMMARY_TITLE="Test-Zusammenfassung"
    TXT_SUMMARY_TEXT="<b>Test abgeschlossen!</b>\n\n<b>Laufwerk (Hardware):</b> %s\n<b>Theoretische Kapazitaet:</b> %s\n<b>Reale Kapazitaet (ermittelt):</b> %s\n\n<b>1. Status:</b>\n%s\n\n<b>2. Mini-Speed-Test:</b>\n%s\n\n<i>Alle Arbeitsdaten wurden geloescht. Das Laufwerk ist leer.</i>"
    TXT_UNINSTALL_OK="App und Menue-Eintrag wurden restlos vom System entfernt."
    
    # Status-Meldungen (Zusammenfassung)
    TXT_RES_WRITE_ERR="FEHLGESCHLAGEN (Schreibfehler)"
    TXT_RES_NO_WRITE="Konnte nicht geschrieben werden"
    TXT_RES_FAKE="FEHLGESCHLAGEN (Fake/Defekt)"
    TXT_RES_TOTAL_FAIL="0.00 Byte (Totalausfall)"
    TXT_RES_PASS="BESTANDEN (Kapazitaet echt)"
    TXT_RES_VERIFIED="(Verifiziert)"
    TXT_SPEED_WRITE="Schreiben"
    TXT_SPEED_READ="Lesen"
    TXT_ERR_MEASURE="Messfehler"
fi
# --- ENDE SPRACH-VARIABLEN ---

APP_NAME="sdcardcheck"
LONG_NAME="X-Capacity & Speed Validator for sd cards v1.0"

while true; do
    ACTION=$(zenity --list --title="$LONG_NAME" \
        --text="$TXT_WELCOME" \
        --column="Aktion" --column="Beschreibung" \
        "START" "$TXT_BTN_START" \
        "UNINSTALL" "$TXT
