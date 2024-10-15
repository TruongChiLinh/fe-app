
FROM node:16 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM amazon/aws-cli:2.13.7 

COPY --from=build /app/build /build
ENTRYPOINT ["sh", "-c", "aws s3 sync /build s3://linh-bucket --delete"]
