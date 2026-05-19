# Imagen ultra liviana
FROM node:18-alpine

# Directorio de trabajo
WORKDIR /app

# Copiamos dependencias
COPY package*.json ./

# Instalamos (Alpine no tiene bash por defecto, usa sh)
RUN npm install --production

# Copiamos el código
COPY . .

# El usuario 'node' también existe en Alpine
USER node

EXPOSE 3000

CMD ["node", "src/index.js"]