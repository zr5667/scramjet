FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9

WORKDIR /app

# Copy configuration files
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY . .

# Run the installation allowing inline lockfile updates
RUN pnpm install --no-frozen-lockfile

# Expose the network port for Railway
EXPOSE 8080

# Move directly into the specific application workspace folder to launch
WORKDIR /app/packages/scramjet-app

# Execute the start script natively from within its home directory
CMD ["pnpm", "start"]
