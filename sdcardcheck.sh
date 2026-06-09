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

    # Buttons (System Override)
    TXT_BTN_YES="Yes"
    TXT_BTN_NO="No"
    TXT_BTN_OK="OK"
    TXT_BTN_CANCEL="Cancel"

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

    # Buttons (System Override)
    TXT_BTN_YES="Ja"
    TXT_BTN_NO="Nein"
    TXT_BTN_OK="OK"
    TXT_BTN_CANCEL="Abbrechen"
fi
# --- ENDE SPRACH-VARIABLEN ---

APP_NAME="sdcardcheck"
LONG_NAME="X-Capacity & Speed Validator for sd cards v1.0"

while true; do
    ACTION=$(zenity --list --title="$LONG_NAME" \
        --text="$TXT_WELCOME" \
        --column="Aktion" --column="Beschreibung" \
        "START" "$TXT_BTN_START" \
        "UNINSTALL" "$TXT_BTN_UNINSTALL" \
        "EXIT" "$TXT_BTN_EXIT" \
        --width=650 --height=350 --hide-header \
        --ok-label="$TXT_BTN_OK" --cancel-label="$TXT_BTN_CANCEL")

    if [ $? -ne 0 ] || [ "$ACTION" == "EXIT" ]; then
        break
    fi

    if [ "$ACTION" == "UNINSTALL" ]; then
        rm -f ~/.local/bin/sdcardcheck.sh
        rm -f ~/.local/share/applications/sdcardcheck.desktop
        update-desktop-database ~/.local/share/applications/ 2>/dev/null
        zenity --info --title="Deinstallation" --text="$TXT_UNINSTALL_OK" --ok-label="$TXT_BTN_OK"
        break
    fi

    if [ "$ACTION" == "START" ]; then
        TARGET_DIR=$(zenity --file-selection --directory --title="$TXT_SEL_DRIVE" --confirm-overwrite)
        if [ -z "$TARGET_DIR" ]; then continue; fi

        DEVICE=$(df -P "$TARGET_DIR" | tail -1 | awk '{print $1}')
        PARENT=$(lsblk -no PKNAME "$DEVICE" 2>/dev/null)
        if [ -z "$PARENT" ]; then PARENT_DEV="$DEVICE"; else PARENT_DEV="/dev/$PARENT"; fi
        
        DRIVE_MODEL=$(lsblk -no VENDOR,MODEL "$PARENT_DEV" | xargs)
        if [ -z "$DRIVE_MODEL" ]; then DRIVE_MODEL="Unbekannt (Standard-Controller)"; fi
        
        THEO_SIZE=$(df -h "$TARGET_DIR" | tail -1 | awk '{print $2}')

        WARN_MSG=$(printf "$TXT_WARN_TEXT" "$TARGET_DIR")
        zenity --question --title="$TXT_WARN_TITLE" --text="$WARN_MSG" --icon-name=dialog-warning --ok-label="$TXT_BTN_YES" --cancel-label="$TXT_BTN_NO"
        if [ $? -ne 0 ]; then continue; fi

        rm -rf "$TARGET_DIR"/*
        if [ $? -ne 0 ]; then
            zenity --error --text="$TXT_ERR_PERM" --ok-label="$TXT_BTN_OK"
            continue
        fi

        zenity --info --title="Test startet" --text="$TXT_INFO_START" --timeout=3 --ok-label="$TXT_BTN_OK"

        stdbuf -o0 f3write "$TARGET_DIR" | stdbuf -o0 tr '\r' '\n' | while IFS= read -r line; do echo "# $line"; done | zenity --progress --title="$TXT_PROG_WRITE" --text="$TXT_INIT" --pulsate --auto-close --auto-kill --width=600 --cancel-label="$TXT_BTN_CANCEL"
        
        if [ ${PIPESTATUS[0]} -ne 0 ]; then
            zenity --error --text="$TXT_ERR_WRITE" --ok-label="$TXT_BTN_OK"
            RESULT_CAP="$TXT_RES_WRITE_ERR"
            REAL_SIZE="$TXT_RES_NO_WRITE"
        else
            rm -f /tmp/f3read.log
            stdbuf -o0 f3read "$TARGET_DIR" | stdbuf -o0 tee /tmp/f3read.log | stdbuf -o0 tr '\r' '\n' | while IFS= read -r line; do echo "# $line"; done | zenity --progress --title="$TXT_PROG_READ" --text="$TXT_VERIFYING" --pulsate --auto-close --auto-kill --width=600 --cancel-label="$TXT_BTN_CANCEL"

            if [ ${PIPESTATUS[0]} -ne 0 ]; then
                zenity --error --text="$TXT_ERR_READ" --ok-label="$TXT_BTN_OK"
                RESULT_CAP="$TXT_RES_FAKE"
                
                REAL_SIZE=$(grep "Data OK:" /tmp/f3read.log | awk '{print $3" "$4}')
                if [ -z "$REAL_SIZE" ]; then REAL_SIZE="$TXT_RES_TOTAL_FAIL"; fi
            else
                RESULT_CAP="$TXT_RES_PASS"
                REAL_SIZE="$THEO_SIZE $TXT_RES_VERIFIED"
            fi
        fi

        rm -f "$TARGET_DIR"/*.h2w

        zenity --info --title="$TXT_SPEED_TITLE" --text="$TXT_SPEED_TEXT" --timeout=3 --ok-label="$TXT_BTN_OK"
        
        TEST_FILE="$TARGET_DIR/xcheck_speed.bin"
        
        WRITE_OUT=$(LC_ALL=C dd if=/dev/zero of="$TEST_FILE" bs=1M count=500 conv=fdatasync 2>&1 | grep "copied" | awk -F', ' '{print $NF}')
        READ_OUT=$(LC_ALL=C dd if="$TEST_FILE" of=/dev/null bs=1M count=500 iflag=direct 2>&1 | grep "copied" | awk -F', ' '{print $NF}')
        
        if [ -z "$WRITE_OUT" ]; then WRITE_OUT="$TXT_ERR_MEASURE"; fi
        if [ -z "$READ_OUT" ]; then READ_OUT="$TXT_ERR_MEASURE"; fi

        SPEED_VAL="$TXT_SPEED_WRITE: $WRITE_OUT\n$TXT_SPEED_READ: $READ_OUT"

        rm -f "$TEST_FILE"

        SUMMARY_MSG=$(printf "$TXT_SUMMARY_TEXT" "$DRIVE_MODEL" "$THEO_SIZE" "$REAL_SIZE" "$RESULT_CAP" "$SPEED_VAL")
        zenity --info --title="$TXT_SUMMARY_TITLE" --text="$SUMMARY_MSG" --ok-label="$TXT_BTN_OK"
    fi
done
