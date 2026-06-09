# sdcardcheck
### X-Capacity & Speed Validator for sd cards v1.0

![App Banner](banner1.png)

Ein professionelles, grafisches Werkzeug für Linux (speziell optimiert für Zorin OS), um die tatsächliche Kapazität und Geschwindigkeit von Speichergeräten (insbesondere MicroSD-Karten von Plattformen wie AliExpress) zuverlässig zu überprüfen. Das Tool entlarvt gefälschte Controller-Angaben (Fake Capacity) manipulationssicher und liefert exakte Hardware-Messergebnisse für eventuelle Händlerdispute.

---

## 📸 Screenshots & Impressionen

Hier finden Sie eine Übersicht der einzelnen Schritte des Wizards:

| 1. Hauptmenü (Wizard Start) | 2. Sicherheitsabfrage (Datenlöschung) |
|:---:|:---:|
| ![Hauptmenü](screen1.png) | ![Sicherheitsabfrage](screen2.png) |

| 3. Kapazitätstest (Schreibvorgang) | 4. Echtheitsprüfung (Lesevorgang) |
|:---:|:---:|
| ![Schreibvorgang läuft](screen3.png) | ![Prüfvorgang läuft](screen4.png) |

| 5. Mini-Speed-Test (dd Cache-Bypass) | 6. Finale Test-Zusammenfassung |
|:---:|:---:|
| ![Mini-Speed-Test](screen5.png) | ![Test-Zusammenfassung](screen6.png) |

---

## ✨ Funktionen

* **Zweistufige Validierung:** Vollständiges Beschreiben des Laufwerks mit anschliessender Verifizierung via `f3`-Engine, um Mogel-Speicher (Fake Capacity) gnadenlos zu entlarven.
* **Intelligenter Live-Fortschritt:** Echtzeit-Anzeige von Schreib-/Lesegeschwindigkeit, geschriebenen Datenmengen und geschätzter Restlaufzeit (ETA) direkt im grafischen Fenster.
* **Hardware-Erkennung:** Automatisches Auslesen des echten Controller-Herstellers und Modellnamens via `lsblk` für eine wasserdichte AliExpress-Beweisführung.
* **Exakte Speicheranalyse:** Gegenüberstellung der theoretischen (vom Händler manipulierten) Grösse und der real ermittelten physischen Speicherkapazität.
* **Präziser Speed-Test:** Integrierter Mini-Laufwerkstest (500 MB), der den Linux-Arbeitsspeicher-Cache (`RAM-Cache`) durch `fdatasync` und `iflag=direct` komplett umgeht, um echte Hardware-Limits zu messen.
* **Volle Zweisprachigkeit:** Nahtlose Unterstützung für Deutsch und Englisch über einfache Start-Parameter.

---

## 🚀 Installation & Nutzung

Das Projekt lässt sich mit einem einzigen Befehl direkt über das Terminal einrichten. Es wird ein vollwertiger Starter im Zorin-Startmenü hinterlegt.

### Standard-Installation (Deutsch)
```bash
bash <(curl -sL [https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/install.sh](https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/install.sh))
```
**Deinstallation:** (**Dieser Befehl führt eine vollständige Deinstallation durch**)
```bash
bash <(curl -sL [https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh](https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh))
```

### Installation mit Sprachparameter (Englisch)
```bash
bash <(curl -sL [https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/install.sh](https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/install.sh)) en
```
**Deinstallation:** (**Dieser Befehl führt eine vollständige Deinstallation durch**)
```bash
bash <(curl -sL [https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh](https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh)) en
```

---

## 🛑 Deinstallation

Falls Sie die App und alle erstellten Desktop-Verknüpfungen wieder restlos vom System entfernen möchten, stehen Ihnen zwei Wege offen:

### Methode 1: Über die grafische Oberfläche
Öffnen Sie die App über das Startmenü und wählen Sie die Option **"UNINSTALL"** (bzw. *"App komplett vom System entfernen"*).

### Methode 2: Über das Terminal (Manueller Befehl)
Führen Sie folgenden Befehl aus, um eine vollständige Deinstallation durchzuführen:

```bash
bash <(curl -sL [https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh](https://raw.githubusercontent.com/albertuszerk/sdcardcheck/main/uninstall.sh))
```
> **DIESER BEFEHL FÜHRT EINE VOLLSTÄNDIGE DEINSTALLATION DURCH UND ENTFERNT ALLE VERKNÜPFUNGEN.**

---

## 🛠 Technische Details & Funktionsweise

1. **Sicherheits-Check:** Nach der Auswahl des Laufwerkspfads wird eine strikte Warnung ausgegeben. Bei Bestätigung wird das Verzeichnis geleert, um Platz für die Testdaten zu schaffen.
2. **Der f3write-Schritt:** Das Laufwerk wird blockweise mit eindeutig identifizierbaren `1GB` grossen Testdateien (`.h2w`) beschrieben.
3. **Der f3read-Schritt (Der Fake-Check):** Die App liest jede geschriebene Datei sequentiell wieder ein. Wenn ein gefälschter Controller Daten im Kreis spiegelt oder ins Leere schreibt, bricht das Skript ab, isoliert die Zeile `Data OK` aus dem Log und ermittelt die exakte reale physische Grösse.
4. **Cache-Bypass Speed-Test:** Gewöhnliche Schreibbefehle spiegeln oft nur die RAM-Geschwindigkeit wider. `sdcardcheck` erzwingt mittels `conv=fdatasync` und `iflag=direct` echte physische I/O-Lese- und Schreibvorgänge direkt auf den Speicherzellen.
5. **Automatische Reinigung:** Nach dem Abschluss des Tests werden alle temporären Arbeitsdaten rückstandslos gelöscht.

---

## 👥 Entwickler & Maintainer

* **Author:** Albertus Zerk
* **Repository:** [https://github.com/albertuszerk/sdcardcheck](https://github.com/albertuszerk/sdcardcheck)
