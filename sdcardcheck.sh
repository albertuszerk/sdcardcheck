#!/bin/bash
# ====================================================
# Short Name: sdcardcheck
# Long Name:  X-Capacity & Speed Validator for sd cards v1.0
# Author:     Albertus Zerk
# ====================================================

APP_LANG="de" # Wird durch install.sh geaendert, falls Parameter mitgegeben wird

# --- SPRACH-VARIABLEN (Vorbereitung fuer Uebersetzung) ---
if [ "$APP_LANG" == "en" ]; then
    # ENGLISCH (Aktuell Platzhalter in Deutsch bis zum GO)
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
        --width=650 --height=350 --hide-header)

    if [ $? -ne 0 ] || [ "$ACTION" == "EXIT" ]; then
        break
    fi

    if [ "$ACTION" == "UNINSTALL" ]; then
        rm -f ~/.local/bin/sdcardcheck.sh
        rm -f ~/.local/share/applications/sdcardcheck.desktop
        update-desktop-database ~/.local/share/applications/ 2>/dev/null
        zenity --info --title="Deinstallation" --text="$TXT_UNINSTALL_OK"
        break
    fi

    if [ "$ACTION" == "START" ]; then
        TARGET_DIR=$(zenity --file-selection --directory --title="$TXT_SEL_DRIVE")
        if [ -z "$TARGET_DIR" ]; then continue; fi

        DEVICE=$(df -P "$TARGET_DIR" | tail -1 | awk '{print $1}')
        PARENT=$(lsblk -no PKNAME "$DEVICE" 2>/dev/null)
        if [ -z "$PARENT" ]; then PARENT_DEV="$DEVICE"; else PARENT_DEV="/dev/$PARENT"; fi
        
        DRIVE_MODEL=$(lsblk -no VENDOR,MODEL "$PARENT_DEV" | xargs)
        if [ -z "$DRIVE_MODEL" ]; then DRIVE_MODEL="Unbekannt (Standard-Controller)"; fi
        
        THEO_SIZE=$(df -h "$TARGET_DIR" | tail -1 | awk '{print $2}')

        WARN_MSG=$(printf "$TXT_WARN_TEXT" "$TARGET_DIR")
        zenity --question --title="$TXT_WARN_TITLE" --text="$WARN_MSG" --icon-name=dialog-warning
        if [ $? -ne 0 ]; then continue; fi

        rm -rf "$TARGET_DIR"/*
        if [ $? -ne 0 ]; then
            zenity --error --text="$TXT_ERR_PERM"
            continue
        fi

        zenity --info --title="Test startet" --text="$TXT_INFO_START" --timeout=3

        stdbuf -o0 f3write "$TARGET_DIR" | stdbuf -o0 tr '\r' '\n' | while IFS= read -r line; do echo "# $line"; done | zenity --progress --title="$TXT_PROG_WRITE" --text="$TXT_INIT" --pulsate --auto-close --auto-kill --width=600
        
        if [ ${PIPESTATUS[0]} -ne 0 ]; then
            zenity --error --text="$TXT_ERR_WRITE"
            RESULT_CAP="FEHLGESCHLAGEN (Schreibfehler)"
            REAL_SIZE="Konnte nicht geschrieben werden"
        else
            rm -f /tmp/f3read.log
            stdbuf -o0 f3read "$TARGET_DIR" | stdbuf -o0 tee /tmp/f3read.log | stdbuf -o0 tr '\r' '\n' | while IFS= read -r line; do echo "# $line"; done | zenity --progress --title="$TXT_PROG_READ" --text="$TXT_VERIFYING" --pulsate --auto-close --auto-kill --width=600

            if [ ${PIPESTATUS[0]} -ne 0 ]; then
                zenity --error --text="$TXT_ERR_READ"
                RESULT_CAP="FEHLGESCHLAGEN (Fake/Defekt)"
                
                REAL_SIZE=$(grep "Data OK:" /tmp/f3read.log | awk '{print $3" "$4}')
                if [ -z "$REAL_SIZE" ]; then REAL_SIZE="0.00 Byte (Totalausfall)"; fi
            else
                RESULT_CAP="BESTANDEN (Kapazitaet echt)"
                REAL_SIZE="$THEO_SIZE (Verifiziert)"
            fi
        fi

        rm -f "$TARGET_DIR"/*.h2w

        zenity --info --title="$TXT_SPEED_TITLE" --text="$TXT_SPEED_TEXT" --timeout=3
        
        TEST_FILE="$TARGET_DIR/xcheck_speed.bin"
        
        WRITE_OUT=$(LC_ALL=C dd if=/dev/zero of="$TEST_FILE" bs=1M count=500 conv=fdatasync 2>&1 | grep "copied" | awk -F', ' '{print $NF}')
        READ_OUT=$(LC_ALL=C dd if="$TEST_FILE" of=/dev/null bs=1M count=500 iflag=direct 2>&1 | grep "copied" | awk -F', ' '{print $NF}')
        
        if [ -z "$WRITE_OUT" ]; then WRITE_OUT="Messfehler"; fi
        if [ -z "$READ_OUT" ]; then READ_OUT="Messfehler"; fi

        SPEED_VAL="Schreiben: $WRITE_OUT\nLesen: $READ_OUT"

        rm -f "$TEST_FILE"

        SUMMARY_MSG=$(printf "$TXT_SUMMARY_TEXT" "$DRIVE_MODEL" "$THEO_SIZE" "$REAL_SIZE" "$RESULT_CAP" "$SPEED_VAL")
        zenity --info --title="$TXT_SUMMARY_TITLE" --text="$SUMMARY_MSG"
    fi
done
