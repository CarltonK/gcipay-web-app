FROM node:22.11-alpine

WORKDIR /app

COPY package*.json /app/

RUN npm i

COPY . /app/

EXPOSE 9009

CMD [ "npm", "run", "dev" ]