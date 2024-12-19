FROM node:lts-alpine as builder

COPY package.json ./
RUN npm install --omit=dev
RUN npm i vite
RUN mkdir /app
RUN mv ./node_modules ./app
WORKDIR /app
COPY . .

# Out of Memory error -> https://github.com/vitejs/vite/issues/2433
ENV NODE_OPTIONS=--max-old-space-size=32768

# Build
RUN npm run build

# Switch to the non-root user node
USER node

FROM nginx:alpine
    
RUN rm -rf /usr/share/nginx/html/*

COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD nginx -g 'daemon off;'