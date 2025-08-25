FROM nginx:alpine

# Clear default nginx html
RUN rm -rf /usr/share/nginx/html/*

# Copy only the *contents* of build folder into nginx html
COPY build/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
