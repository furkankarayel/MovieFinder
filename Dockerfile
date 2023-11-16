# Base Image ziehen
FROM node:18.0-alpine
# WORKING DIR auf den Pfad app setzen
WORKDIR /app
# Kopiere package.json und package-lock.json
COPY package*.json ./
# Kopiere den Sourcecode der App
COPY . .
# Kopiere die Quasar Konfigurationsdatei 
COPY quasar.config.js ./
# Installiere die Abhängigkeiten
RUN npm install
# Installiere die Quasar CLI Abhängigkeit global
RUN npm install -g @quasar/cli
# Gebe den Port 8080 für den Container frei
EXPOSE 8080
# Baue die Quasar App auf
CMD ["quasar","dev"]