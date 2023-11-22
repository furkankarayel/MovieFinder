# Pull Base Image
FROM node:20.0-alpine
# Set WORKING DIR to the 'app' path
WORKDIR /app
# Copy package.json and package-lock.json
COPY package.json ./
# Copy the source code of the app
COPY . .
# Copy the Quasar configuration file
COPY quasar.config.js ./
# Install dependencies
RUN npm install
# Expose port 8080 for the container
EXPOSE 8080
# Build the Quasar app
CMD ["npm", "run", "dev"]
