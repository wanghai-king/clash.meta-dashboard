FROM node:lts AS builder

WORKDIR /app

RUN git clone https://github.com/haishanh/yacd.git . 
RUN npm i 
RUN npm run build
