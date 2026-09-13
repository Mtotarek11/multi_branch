FROM node:lts-slim

WORKDIR /app

# Copy dependency files and install production dependencies
COPY package*.json ./
RUN npm install --production

# Copy the application code
COPY . .

EXPOSE 5000

CMD ["node", "index.js"]
