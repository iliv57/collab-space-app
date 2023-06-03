# Collab Space

## Benötigte Anwendungen
- [git](https://git-scm.com/download/win)
- [Docker](https://www.docker.com/products/docker-desktop/)

> Damit Docker unter Windows laufen kann, wird noch [wsl 2](https://learn.microsoft.com/en-us/windows/wsl/install) benötigt.


## Schritte um die App zum Laufen zu bringen

> Unter Windows sollten die Befehle auf der *Git Bash* Konsole ausgeführt werden. Beim Installieren von Git auf Windows sollte *Git Bash* automatisch mit installiert werden.
>
> Unter Linux und Mac kann ein ganz normales Terminal verwendet werden

### Docker starten

Falls noch nicht passiert `Docker` starten  

### Repository klonen

Erstelle und navigiere mit der Konsole der Ordner, in den die Repository gespeichert werden soll (z.B. `mkdir pse && cd pse`). Unter diesem Ort führe folgenden Befehl aus:

```bash
git clone --recurse-submodules git@github.com:KIT-PSE/collab-space-app.git
```

> Falls ihr `git` noch nie wirklich benutzt habt, wird dieser Befehl wahrscheinlich fehlschlagen und in der Fehlernachricht steht sowas wie `Host key verification failed.` Das liegt daran, da ihr noch keine `ssh` Keys eingerichtet habt.
>
> [Hier](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) lernt ihr, wie ihr einen `ssh` Key erstellt und diesen in Github hinzufügt.

Mit dem Befehl `ls` kann verifziert werden, ob alles geklappt hat und der Ordner `collab-space-app` nun existiert.

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

### Datenbank initialisieren

Nach dem ersten Start ist die Datenbank noch nicht für die App fertig eingerichtet. Dazu in einem zweiten Konsolen Fenster (weil in dem anderem die App grade läuft) erstmal wieder zu dem App Ordner (mit `cd ...`) navigieren und dann folgenden Befehl ausführen:

```bash
docker compose exec backend npx mikro-orm migration:up
```

Damit werden die Datenbank Schemas erstellt.

Als nächstes kann noch in die Datenbank ein paar Testdaten hinzugefügt werden mit:

```bash
docker compose exec backend npx mikro-orm seeder:run
```

Wenn alles geklappt hat sollte man jetzt im Browser jetzt die Seite `localhost:5173` öffnen können und sieht die App.

## App stoppen

Zum Stoppen der App kann in dem Konsolen Fenster in dem die App läuft `Strg+C` gedrückt werden. Falls das Konsolen Fenster ausversehen geschlossen wurde aber die App immer noch läuft (unter `localhost:5173` ist noch etwas zu sehen) kann mit `docker compose down` im entsprechendem Ordner die App gestoppt werden.

## App starten

Nachdem oben die Schritte befolgt wurden ist zum Starten der App nur der Befehl `docker compose up` im entsprechnedem Ordner notwendig.