
# Final stage: install production dependencies
FROM node:12-alpine
WORKDIR /app

COPY forta.config.json ./
COPY package*.json ./
COPY ./src ./src

RUN npm ci --production
CMD [ "npm", "run", "start:prod"]