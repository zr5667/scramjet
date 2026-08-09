FROM node:20-slim

# Install pnpm version 9 explicitly
RUN npm i -g pnpm@9

WORKDIR /app

# Copy all repository workspace configuration files
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY . .

# Install all workspace dependencies
RUN pnpm install --no-frozen-lockfile

# Expose the standard Railway network port
EXPOSE 8080

# Run the app 
CMD ["pnpm", "--filter", "scramjet-app", "start"]
