FROM nginx:alpine-slim
COPY ./public_html/ /usr/share/nginx/html/
LABEL org.opencontainers.image.source https://github.com/CMG1911/hello-2048

