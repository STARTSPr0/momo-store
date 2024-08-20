#сборка
FROM node:16.20.0-alpine3.18 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

#деплой
FROM nginx:1.21.6-alpine
WORKDIR /app
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80
