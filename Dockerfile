# Use the official Homebrew Docker image
FROM homebrew/brew:latest

# Switch to root user to install system dependencies
USER root

# Install Docker CLI to communicate with Docker socket
# This allows the container to talk to the host's Docker daemon
# Using static binaries from official Docker releases
# Note: -k flag used due to build environment SSL certificate limitations
RUN apt-get update && \
    apt-get install -y curl && \
    DOCKER_VERSION=29.0.2 && \
    curl -fsSL -k "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" | \
    tar xzvf - --strip 1 -C /usr/local/bin docker/docker && \
    rm -rf /var/lib/apt/lists/*

# Install Supabase CLI directly from official GitHub releases
# Using a specific version to ensure reproducibility
# Note: -k flag used due to build environment SSL certificate limitations
RUN SUPABASE_VERSION=2.58.5 && \
    curl -fsSL -k "https://github.com/supabase/cli/releases/download/v${SUPABASE_VERSION}/supabase_linux_amd64.tar.gz" | \
    tar xzf - -C /usr/local/bin && \
    chmod +x /usr/local/bin/supabase

# Switch back to the linuxbrew user (default user in homebrew/brew image)
USER linuxbrew

# Set the default command to bash
CMD ["/bin/bash"]
