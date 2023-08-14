# Use uma imagem base leve, como o nginx
FROM nginx:alpine

# Copie o arquivo index.html para o diretório padrão do nginx
COPY index.html /usr/share/nginx/html/
