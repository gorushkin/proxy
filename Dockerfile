FROM nginx:1.27.0

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
