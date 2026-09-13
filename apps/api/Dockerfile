FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache openssl libc6-compat

# Copy root and API package definitions
COPY package.json package-lock.json ./
COPY apps/api/package.json apps/api/package-lock.json ./apps/api/

# Install root and backend dependencies
RUN npm ci
RUN cd apps/api && npm ci

# Copy Prisma schema and generate client
COPY prisma ./prisma
RUN npx prisma generate

# Copy backend source code
COPY apps/api ./apps/api

# Build NestJS backend
WORKDIR /app/apps/api
RUN npm run build
RUN chmod +x docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["./docker-entrypoint.sh"]
