FROM node:24-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Install OpenCode globally (as root, but will be used by agent)
RUN npm install -g opencode-ai

# Create a dedicated non-root user for the agent
RUN groupadd -r agent && useradd -r -g agent -m -d /home/agent -s /bin/bash agent

# Create agent home and config dir, restrict access to agent only
RUN mkdir -p /home/agent/.opencode /home/agent/.npm-global/bin && \
    chown -R agent:agent /home/agent && \
    chmod 700 /home/agent && \
    chmod 700 /home/agent/.opencode

# Create /app for Docker project files - root-owned, agent cannot read
RUN mkdir -p /app && chmod 700 /app

# Entrypoint script: fix .opencode ownership on every start (volume may be root-owned on host)
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Redirect npm global installs to user-owned directory
ENV NPM_CONFIG_PREFIX=/home/agent/.npm-global
ENV PATH=/home/agent/.npm-global/bin:$PATH

# Working directory is the agent home — this is what OpenCode will show
WORKDIR /home/agent

# Expose the default port
EXPOSE 4096

# Entrypoint runs as root to fix volume ownership, then drops to agent via gosu
ENTRYPOINT ["/entrypoint.sh"]
CMD ["opencode", "web", "--port", "4096", "--hostname", "0.0.0.0"]
