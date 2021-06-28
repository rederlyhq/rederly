FROM rederly_frontend-build as build
# production environment
FROM nginx:1.21.0-alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY rederly.nginx.conf /etc/nginx/conf.d/rederly.nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]