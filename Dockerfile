FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9.15.9

WORKDIR /app

# Copy all configuration files across the entire monorepo workspace structure
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY packages/ ./packages/

# Run the project installation by instructing pnpm to ignore strict catalog checks
RUN pnpm install --no-frozen-lockfile --unsafe-perm

# Copy any leftover root files
COPY . .

# Route traffic for Railway
ENV PORT=8080
EXPOSE 8080

# Execute the start script natively
CMD ["pnpm", "start"]
