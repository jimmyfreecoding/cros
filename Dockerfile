FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

# Install deps first for better layer caching
COPY package.json ./
RUN npm install --omit=dev

# Copy app source
COPY . .

# Default ports from server/server.yml
EXPOSE 3000 3001

# Start server by default
CMD ["node", "bin/cli.js", "server", "server/server.yml"]
