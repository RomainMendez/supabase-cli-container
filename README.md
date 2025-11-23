# supabase-cli-container

Supabase CLI Container based on the official Homebrew Docker image (`homebrew/brew`).

## Features

- Based on `homebrew/brew:latest` - official Homebrew Docker image
- Pre-installed Supabase CLI (v1.200.3)
- Docker CLI installed for Docker socket communication
- Boots into bash by default
- Supports Docker socket pass-through for container management

## Installation

### Pull from GitHub Container Registry (Recommended)

The image is automatically built and published to GitHub Container Registry:

```bash
docker pull ghcr.io/romainmendez/supabase-cli-container:latest
```

### Building Locally

Alternatively, you can build the image locally:

```bash
docker build -t supabase-cli .
```

## Usage

### Basic Usage

Run an interactive bash session:

```bash
docker run -it --rm ghcr.io/romainmendez/supabase-cli-container:latest
```

Or if you built locally:

```bash
docker run -it --rm supabase-cli
```

### With Docker Socket Access

To allow the container to communicate with your host's Docker daemon (for Supabase local development):

```bash
docker run -it --rm --user root -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/romainmendez/supabase-cli-container:latest
```

**Note:** Running with `--user root` is needed for Docker socket access. Alternatively, you can:
- Map your user's UID/GID that has Docker permissions
- Add the container user to the docker group on your host

### Running Supabase Commands

```bash
# Check Supabase CLI version
docker run --rm ghcr.io/romainmendez/supabase-cli-container:latest supabase --version

# Initialize a new Supabase project
docker run -it --rm -v $(pwd):/workspace -w /workspace ghcr.io/romainmendez/supabase-cli-container:latest supabase init

# Start Supabase locally (requires Docker socket)
docker run -it --rm --user root \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd):/workspace -w /workspace \
  ghcr.io/romainmendez/supabase-cli-container:latest supabase start
```

## What's Included

- **Supabase CLI** (v1.200.3): Full-featured CLI for Supabase
- **Docker CLI** (v27.4.1): For managing Docker containers
- **Homebrew**: Package manager (inherited from base image)

## Docker Socket Support

The container includes Docker CLI and can communicate with the host Docker daemon when the socket is mounted:

- **File socket**: `-v /var/run/docker.sock:/var/run/docker.sock`
- **TLS socket**: Configure with appropriate environment variables and certificates

This enables the Supabase CLI to start and manage local Supabase containers for development. 
