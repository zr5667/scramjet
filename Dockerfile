FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9.15.9

WORKDIR /app

# CRITICAL: Copy both package configs AND the workspace catalog rules together
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./

# Install dependencies with the catalog definition visible
RUN pnpm install --no-frozen-lockfile

# Copy the rest of your application code
COPY . .

# Set up port routing for Railway
ENV PORT=8080
EXPOSE 8080

# Run the project workspace initialization script 
CMD ["pnpm", "start"]
