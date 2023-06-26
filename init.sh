#!/bin/sh

cp ./backend/.env.docker.example ./backend/.env
cp ./frontend/.env.example ./frontend/.env

# Erstelle eine neue Zeile in .env
echo >> ./frontend/.env

# Ueberpruefe, ob das Betriebssystem Windows ist
# Falls ja, dann setze CHOKIDAR_USEPOLLING=true
# Falls nein, dann setze CHOKIDAR_USEPOLLING=false
# Setze CHOKIDAR_USEPOLLING in .env in eine neue Zeile
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  echo "CHOKIDAR_USEPOLLING=true" >> ./frontend/.env
else
  echo "CHOKIDAR_USEPOLLING=false" >> ./frontend/.env
fi
