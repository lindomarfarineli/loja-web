FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY ./index.js .
COPY ./web ./web

EXPOSE 8080

CMD ["npm", "start"]