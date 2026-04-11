FROM node:lts-alpine

WORKDIR /app

COPY . .

RUN apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont

RUN npm ci

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

ENV NEWS_API_KEY=your_news_api_key_here

CMD npm start
