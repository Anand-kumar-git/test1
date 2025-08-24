# Use Nginx only (no node build needed)
FROM nginx:alpine

# Remove default nginx html content
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output into Nginx html directory
COPY build/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
