# Stage 1: Build React app
FROM node:18 AS build
WORKDIR /app

# Copy package.json & package-lock.json first (better caching)
COPY package*.json ./
RUN npm install

# Copy rest of the source code (excluding build folder)
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
# Copy only the compiled build output, not the raw repo files
COPY --from=build /app/build /usr/share/nginx/html
# Custom nginx config (fix routing issue if needed)
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
