# Stage 1: Build the Angular app
FROM node:20.11.1 AS builder

WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app for production
RUN npm run build

# Stage 2: Create a lightweight container with Nginx to serve the Angular app
FROM nginx:alpine

# Copy the built app from the builder stage to the nginx public directory
COPY --from=builder /app/dist/my-app/browser  /usr/share/nginx/html

# Expose port 1316 to the outside world
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"] 
