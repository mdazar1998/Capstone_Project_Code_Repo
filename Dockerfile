# Base image
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Build the React.js application
RUN npm run build

# Production-ready image
FROM nginx:latest

# Copy the build files to NGINX web server
COPY --from=build /app/build /usr/share/nginx/html

# Update default NGINX configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
