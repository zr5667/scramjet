FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9.15.9

WORKDIR /app

# Copy lockfiles and application configuration files
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY . .

# Install dependencies allowing lockfile modifications
RUN pnpm install --no-frozen-lockfile

# Railway routes traffic using the PORT environment variable
ENV PORT=8080
EXPOSE 8080

# Execute the main Javascript wrapper directly bypassing pnpm's CLI engine
CMD ["node", "src/index.js"]
