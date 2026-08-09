FROM node:20-slim

# Install pnpm 9 explicitly
RUN npm i -g pnpm@9.15.9

WORKDIR /app

# Copy absolutely everything at once to preserve monorepo workspaces and catalogs
COPY . .

# Run installation bypassing catalog isolation issues 
RUN pnpm install --no-frozen-lockfile

# Expose network channels for Railway routing
ENV PORT=8080
EXPOSE 8080

# Execute the start routine natively 
CMD ["pnpm", "start"]
