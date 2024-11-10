# Stage 1 - Builder
FROM node:18 AS builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies in builder stage
RUN npm install 

# Copy the rest of the application code
COPY . .

# Stage 2 - Production
FROM node:18-slim AS production

WORKDIR /app

# Copy only the necessary files from builder stage
COPY --from=builder /app .

# Expose the necessary port
EXPOSE 8000

# Start the application
CMD ["node", "server.js"]
