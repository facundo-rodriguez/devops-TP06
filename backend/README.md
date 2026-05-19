# TP05: Dockerización de API Node.js con MySQL (Clever Cloud)

Este proyecto consiste en una API desarrollada en **Node.js** que se conecta a una base de datos **MySQL** alojada en la nube (**Clever Cloud**). El objetivo del trabajo es aplicar conceptos de contenedorización, creación de imágenes livianas y automatización de builds.

## 🚀 Tecnologías utilizadas
* **Runtime:** Node.js 20
* **Framework:** Express.js
* **Base de Datos:** MySQL (Clever Cloud)
* **Contenedorización:** Docker (Imagen base: `node:18-alpine`)
* **Infraestructura:** WSL 2 (Ubuntu)

## 📁 Estructura del Proyecto
* `src/`: Código fuente de la API (Endpoints de categorías, productos y usuarios).
* `scripts/`: Script `build-push.sh` para automatización de CI.
* `Dockerfile`: Instrucciones de construcción de la imagen Docker.
* `.dockerignore`: Archivos excluidos del contexto de build.

## 🛠️ Configuración de Variables de Entorno
Para que el contenedor se conecte a Clever Cloud, se requiere un archivo `.env` en la raíz (no incluido en el repositorio por seguridad) con el siguiente formato:

```env
DB_HOST=tu_host_clever
DB_USER=tu_usuario
DB_PASSWORD=tu_password
DB_NAME=tu_nombre_db
DB_PORT=3306
PORT=3000

📦 Construcción y Despliegue
1. Construcción manual
Para construir la imagen localmente:
docker build -t 95rodriguezfacundo/app-node-tp05:1.0 .

La API estará disponible en http://localhost:8080.

3. Automatización (Build & Push)
El proyecto incluye un script que realiza un Health Check antes de subir la imagen a Docker Hub:
./scripts/build-push.sh 1.0

✅ Endpoints Principales
GET /health: Verifica el estado de la aplicación (Usado por el script de build).

GET /categories: Lista las categorías desde Clever Cloud.

GET /products: Lista los productos desde Clever Cloud.

🐳 Imagen en Docker Hub
La imagen oficial de este proyecto puede encontrarse en:
95rodriguezfacundo/app-node-tp05








