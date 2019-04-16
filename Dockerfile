FROM node:latest

WORKDIR /usr/src/app

COPY ./src/package*.json ./

RUN npm install

RUN npm audit fix

COPY ./src .

EXPOSE 3000

CMD [ "npm", "start" ]

