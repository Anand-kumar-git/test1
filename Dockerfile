FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

# Copy *contents* of build folder, not the folder itself
COPY build/* /usr/share/nginx/html/
COPY build/static /usr/share/nginx/html/static

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
