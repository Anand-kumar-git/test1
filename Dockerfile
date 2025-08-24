# Use Nginx to serve static files
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your build folder into nginx html
COPY build/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
