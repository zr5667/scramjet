FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9.15.9

WORKDIR /app

# Copy package configurations
COPY package.json pnpm-lock.yaml* ./

# Install dependencies allowing lockfile modifications
RUN pnpm install --no-frozen-lockfile

# Copy the rest of the application files
COPY . .

# Railway routes traffic using the PORT environment variable automatically
ENV PORT=8080
EXPOSE 8080

# Execute the start script defined in the repository's package.json
CMD ["pnpm", "start"]
