FROM node:alpine

RUN mkdir /home/homelab

WORKDIR /home/homelab

RUN apk --no-cache add curl

COPY index.html .

EXPOSE 80
CMD npx serve -l 80