FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

FROM node:18-alpine

WORKDIR /app

RUN adduser -D appuser

COPY --from=build --chown=appuser:appuser /app .

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]