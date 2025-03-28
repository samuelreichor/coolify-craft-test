# nginx/Dockerfile

FROM nginx:alpine

# Entferne die Standard-Konfiguration
RUN rm /etc/nginx/conf.d/default.conf

# Kopiere deine eigene Nginx-Konfiguration
COPY nginx.conf /etc/nginx/conf.d/app.conf

# Exponiere Port 80 (Standard für Nginx)
EXPOSE 80

# Standard-Kommando (wird vom Basis-Image geerbt)
# CMD ["nginx", "-g", "daemon off;"]