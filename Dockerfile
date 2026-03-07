FROM node:24-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode globally
RUN npm install -g opencode-ai

# Create working directory
WORKDIR /app

# Expose the default port
EXPOSE 4096

# Start opencode web
# We use --hostname 0.0.0.0 to allow connections from outside the container
CMD ["opencode", "web", "--port", "4096", "--hostname", "0.0.0.0"]
