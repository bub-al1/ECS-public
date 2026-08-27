FROM node:24.13
WORKDIR /app
COPY . .
RUN yarn install 
RUN yarn build 
EXPOSE 80
CMD ["node", "server.js"]

