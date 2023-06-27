# Collab Space

## Benötigte Anwendungen
- [git](https://git-scm.com/download/win)
- [Docker](https://www.docker.com/products/docker-desktop/)

> Damit Docker unter Windows laufen kann, wird noch [wsl 2](https://learn.microsoft.com/en-us/windows/wsl/install) benötigt.


## Schritte um die App zum Laufen zu bringen

> Unter Windows sollten alle Befehle in einer Konsole innerhalb der WSL-Installation ausgeführt werden. Standardmäßig sollte bei der oben aufgeführten Installtionsanleitung Ubuntu installiert werden. Eine WSL-Konsole kann dann einfach über die Eingabe 'Ubuntu' in das Startfenster geöffnet werden.
>
> Unter Linux und Mac kann ein ganz normales Terminal verwendet werden

### Docker starten

Falls noch nicht passiert `Docker` starten  

So sieht die Docker App unter Windows frisch installiert dann aus

![QlV491s](https://github.com/KIT-PSE/collab-space-app/assets/37345813/bc18c12f-fa87-486d-b7bf-4e79e91da97f)

### Repository klonen

>#### Erinnerung - Windows
>Um die Anwendung später unter Windows einwandfrei starten zu können, solle die Repository in einem Verzeichnis innerhalb von WSL gespeichert werden. Gehe also nun sicher, dass eine WSL-Konsole, wie am Anfang beschreiben, geöffnet ist.

Erstelle und navigiere mit der Konsole der Ordner, in den die Repository gespeichert werden soll (z.B. `mkdir pse && cd pse`). Unter diesem Ort führe folgenden Befehl aus:

```bash
git clone --recurse-submodules git@github.com:KIT-PSE/collab-space-app.git
```

> Falls ihr `git` noch nie wirklich benutzt habt, wird dieser Befehl wahrscheinlich fehlschlagen und in der Fehlernachricht steht sowas wie `Host key verification failed.` Das liegt daran, da ihr noch keine `ssh` Keys eingerichtet habt.
>
> [Hier](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) lernt ihr, wie ihr einen `ssh` Key erstellt und diesen in Github hinzufügt.

Mit dem Befehl `ls` kann verifziert werden, ob alles geklappt hat und der Ordner `collab-space-app` nun existiert.

![lmaXxHz](https://github.com/KIT-PSE/collab-space-app/assets/37345813/e7148a82-3518-4fe4-93d1-20e2e41a88de)

### Container starten

Navigiere mit dem Befehl `cd collab-space-app` in den App Ordner und führe in diesem folgenden Befehl aus:

```bash
./init.sh
```
Dieser kopiert die Standard Umgebungsvariablen aus den Beispiel-Dateien, da echte Umgebungsvariablen nicht in einer Git Repository hochgeladen werden sollten.

Als nächstes können wir die App mit folgendem Befehl starten:

```bash
docker compose up
```

Der erste Start dauert etwas länger da erstmal alle Docker Images (wie zum Beispiel *Node* oder *MySQL*) heruntergeladen werden müssen. Sobald der erste Start erfolgreich war laufen die nächsten Starts ziemlich schnell.

![1wFjL41](https://github.com/KIT-PSE/collab-space-app/assets/37345813/e49a3288-9fff-4434-81e7-17a4f68d5616)

### Datenbank initialisieren

Nach dem ersten Start ist die Datenbank noch nicht für die App fertig eingerichtet. Dazu in einem zweiten Konsolen Fenster (weil in dem anderem die App grade läuft) erstmal wieder zu dem App Ordner (mit `cd ...`) navigieren und dann folgenden Befehl ausführen:

```bash
docker compose exec backend npx mikro-orm migration:up
```

Damit werden die Datenbank Schemata erstellt.

Als nächstes kann noch in die Datenbank ein paar Testdaten hinzugefügt werden mit:

```bash
docker compose exec backend npx mikro-orm seeder:run
```

![F2V6o9A](https://github.com/KIT-PSE/collab-space-app/assets/37345813/bb1b8013-8046-421c-b2e9-1a146e80b6ab)

Wenn alles geklappt hat sollte man im Browser die Seite `localhost:5173` öffnen können und sieht die App.

![DQ5Nbbq](https://github.com/KIT-PSE/collab-space-app/assets/37345813/b8e1d8ba-a687-4518-838e-1a0b9a2d8335)


## App stoppen

Zum Stoppen der App kann in dem Konsolen Fenster in dem die App läuft `Strg+C` gedrückt werden. Falls das Konsolen Fenster ausversehen geschlossen wurde aber die App immer noch läuft (unter `localhost:5173` ist noch etwas zu sehen) kann mit `docker compose down` im entsprechendem Ordner die App gestoppt werden.

![frfinHJ](https://github.com/KIT-PSE/collab-space-app/assets/37345813/4c3f7a0e-0aab-48c9-8118-871bbff8a697)

## App starten

Nachdem oben die Schritte befolgt wurden ist zum Starten der App nur der Befehl `docker compose up` im entsprechnedem Ordner notwendig.

![Nr7RYXE](https://github.com/KIT-PSE/collab-space-app/assets/37345813/10460c8f-f8ce-42d4-b2cb-011c281e1a69)


## Zusammenfassung - Kurzanleitung für Windows
Ausgangspunkt: Git, Docker & WSL2 installiert
- Docker starten
- WSL2 Konsole starten
  - 'Ubuntu' in das Startfenster eingeben
- SSH key erstellen
  - `ssh-keygen -t ed25519 -C "your_email@example.com"` - Einfach alle Eingaben bestätigen
  - `eval "$(ssh-agent -s)"`
  - `ssh-add ~/.ssh/id_ed25519`
  - `cat ~/.ssh/id_ed25519.pub` - Die Ausgabe dieses Commands in die Zwischenablage kopieren
  - Github Account Einstellungen öffnen -> Auf `SSH and GPG keys` klicken -> Neuen SSH key erstellen und eben kopierten Text einfügen
- In das Verzeichnis wechseln, in welches die Repository gespeichert werden soll
- `git clone --recurse-submodules git@github.com:KIT-PSE/collab-space-app.git`
- `ls collab-space-app`
- `./init.sh`
- `docker compose up`
- Auf das Starten des Docker Containers warten
- Währenddessen seperate Konsole öffnen
- Sobald der Docker Container läuft in der seperaten Konsole folgende Commands ausführen
- `docker compose exec backend npx mikro-orm migration:up`
- `docker compose exec backend npx mikro-orm seeder:run`
- Nun sollte die Anwendung unter `localhost:5173` erreichbar sein

