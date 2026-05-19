FROM nginx:alpine
# Copiamos la configuración que está en la misma carpeta que este Dockerfile
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copiamos el HTML que está en la misma carpeta
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80