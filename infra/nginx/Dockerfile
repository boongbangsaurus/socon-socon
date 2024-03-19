FROM nginx:latest

RUN rm -rf /etc/nginx/conf.d/default.conf
RUN mkdir -p /etc/letsencrypt/live/socon-socon.site
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]