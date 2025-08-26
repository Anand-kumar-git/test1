FM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

# FIX: copy contents of build into nginx root
COPY build/. /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
