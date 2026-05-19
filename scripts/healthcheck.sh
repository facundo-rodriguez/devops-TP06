#!/bin/bash
# =========================================================
# Healthcheck del Stack Completo - TP06
# =========================================================

echo "Verificando salud del stack..."

# 1. Verificar Frontend (Nginx)
FRONTEND_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80)
if [ "$FRONTEND_STATUS" -eq 200 ]; then
    echo "Frontend (Nginx): OK (HTTP 200)"
else
    echo "Frontend (Nginx): FALLÓ (HTTP $FRONTEND_STATUS)"
fi

# 2. Verificar Backend a través del Proxy (Nginx -> Node)
API_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80/api/health)
if [ "$API_STATUS" -eq 200 ]; then
    echo "Backend (Proxy): OK (HTTP 200)"
else
    echo "Backend (Proxy): FALLÓ (HTTP $API_STATUS)"
fi

# 3. Verificar conectividad interna (Frontend a Backend)
INTERNAL_CHECK=$(docker compose exec frontend wget -qO- --spider http://backend:3000/health && echo "OK" || echo "FAIL")
if [ "$INTERNAL_CHECK" = "OK" ]; then
    echo "Conexión interna Nginx -> Node: OK"
else
    echo "Conexión interna Nginx -> Node: FALLÓ"
fi
