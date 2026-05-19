#!/bin/bash
set -euo pipefail

# --- CONFIGURACIÓN ---
DOCKER_USER="${DOCKER_USER:-95rodriguezfacundo}" 
IMAGE_NAME="app-node-tp05"
TAG="${1:-1.0}"
FULL_TAG="$DOCKER_USER/$IMAGE_NAME:$TAG"

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)" 

log() { echo -e "\e[32m[$(date '+%H:%M:%S')]\e[0m $1"; }

log "=== Iniciando Build de la imagen: $FULL_TAG ==="
# Construimos con dos tags: el número de versión y el 'latest'
docker build -t "$FULL_TAG" -t "$DOCKER_USER/$IMAGE_NAME:latest" "$APP_DIR"

log "=== Test de Calidad (Health Check) ==="
# Levantamos el contenedor temporalmente para validar que Node arranque bien

docker run --rm -d --name test-container -p 9999:3000 "$FULL_TAG"

# Esperamos a que Node inicie
sleep 5

# Verificamos el endpoint /health
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:9999/health || echo "000")

if [ "$STATUS" = "200" ]; then
    log " Health check exitoso (HTTP $STATUS)"
    docker stop test-container
else
    log " FALLÓ el Health check (HTTP $STATUS). Abortando..."
    docker stop test-container
    exit 1
fi

log "=== Subiendo imagen a Docker Hub ==="
# Para que esto funcione, primero tenés que hacer 'docker login' una vez en la terminal
docker push "$FULL_TAG"
docker push "$DOCKER_USER/$IMAGE_NAME:latest"

log " Proceso finalizado: $FULL_TAG subida correctamente."