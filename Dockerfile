FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache nginx

# Install deps first for better layer caching
COPY package.json ./
RUN npm install --omit=dev

# Copy app source
COPY . .

# Nginx proxies port 80 to the app HTTP port 3001
COPY docker/nginx.conf /etc/nginx/http.d/default.conf
COPY docker/www/ /var/www/html/
RUN chmod +x /app/docker/start.sh

# Expose the control port and the HTTP entry port
EXPOSE 80 3000

# Start Node server and Nginx
CMD ["sh", "/app/docker/start.sh"]
