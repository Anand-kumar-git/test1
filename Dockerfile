FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy *contents* of build folder (so index.html is in the right place)
COPY build/* /usr/share/nginx/html/
COPY build/static /usr/share/nginx/html/static

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
