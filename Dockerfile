# Stage 1: Build the application
FROM node:14-alpine as builder

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Run the application
FROM node:14-alpine
WORKDIR /usr/app
COPY --from=builder /usr/src/app/dist ./dist
COPY package*.json ./
RUN npm install --only=production

CMD ["node", "dist/main"]