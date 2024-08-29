#сборка
FROM node:16.20.0-alpine3.18 as builder
WORKDIR /usr/src/app
COPY package*.json ./
COPY ./ .
RUN npm install && npm run build

#деплой
FROM nginx:1.21.6-alpine
WORKDIR /app
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# FROM node:16-alpine as builder
# WORKDIR /app
# COPY package*.json ./
# COPY ./ .
# ENV NODE_ENV=/
# ENV VUE_APP_API_URL=/
# RUN npm install && npm run build

# FROM nginx:latest
# WORKDIR /app
# COPY --from=builder /app/dist /app/static/momo-store
# EXPOSE 80

#CMD ["nginx", "-g", "daemon off;"]