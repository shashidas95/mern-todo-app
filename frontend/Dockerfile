# Stage 1: Build the React app
FROM node:18 AS build

# Set working directory in container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Prepare the final runtime image
FROM node:18-slim

# Set working directory
WORKDIR /app

# Install serve globally to serve the static files
RUN npm install -g serve

# Copy built files from the build stage
COPY --from=build /app/build ./build

# Expose the port the app will run on
EXPOSE 3000

# Command to serve the static files in production
CMD ["serve", "-s", "build", "-l", "3000"]
