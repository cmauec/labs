FROM node:lts AS build
WORKDIR /app

COPY survivors/package*.json ./survivors/
RUN cd survivors && npm install
COPY survivors ./survivors/
RUN cd survivors && npm run build

FROM nginx:alpine AS runtime

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=build /app/survivors/dist /usr/share/nginx/html/survivors

EXPOSE 8080