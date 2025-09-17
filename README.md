# GitHub Actions Runner Docker Image

This Docker image provides a lightweight GitHub Actions runner that can be easily deployed to run your GitHub Actions workflows.

## Features

- Lightweight container using multi-stage build
- Automatically registers with your GitHub repository or organization
- Easy configuration via environment variables
- Based on Node.js 24 slim image

## Usage

### Required Environment Variables

- `URL`: The GitHub repository or organization URL
- `TOKEN`: The runner registration token

### Optional Environment Variables

- `NAME`: Custom name for the runner (default: hostname)
- `RUNNER_GROUP`: Runner group name (if applicable)

### Running the Container

```bash
docker run -d \
  -e URL="https://github.com/your-org/your-repo" \
  -e TOKEN="your-runner-token" \
  -e NAME="custom-runner-name" \
  -e RUNNER_GROUP="default" \
  --name github-runner \
  your-image-name
```

## Building the Image

```bash
docker build -t github-actions-runner:latest .
```

## How It Works

1. On first run, the runner registers with GitHub using the provided URL and token
2. For subsequent runs, the runner uses existing registration
3. The entrypoint script handles both scenarios automatically

## Notes

- The runner is configured with user ID 1100 for security
- All unnecessary build tools and caches are removed to keep the image lightweight
- The runner version can be customized during build using the `RUNNER_VERSION` build argument