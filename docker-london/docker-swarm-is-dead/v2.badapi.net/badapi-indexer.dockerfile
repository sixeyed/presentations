FROM node:4.4.6

WORKDIR /usr/src/app
ADD badapi-indexer /usr/src/app

RUN npm install

CMD [ "npm", "start" ]