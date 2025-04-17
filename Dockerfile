# Node.js 베이스 이미지 사용
FROM node:16 as build

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일 복사 및 설치
COPY package.json package-lock.json ./
RUN npm install

# 소스 코드 복사
COPY . .

# 빌드
RUN npm run build

# Nginx를 사용하여 정적 파일 서빙
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]