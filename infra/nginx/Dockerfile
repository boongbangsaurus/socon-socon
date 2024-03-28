FROM nginx:latest

RUN rm -rf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY letsencrypt /etc/letsencrypt/live/socon-socon.site

CMD ["nginx", "-g", "daemon off;"]