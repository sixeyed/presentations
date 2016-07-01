FROM node:4.4.6

WORKDIR /usr/src/app
ADD badapi-api /usr/src/app

RUN npm install

EXPOSE 5000
CMD [ "npm", "start" ]