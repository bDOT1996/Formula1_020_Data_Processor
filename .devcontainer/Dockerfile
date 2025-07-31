FROM mcr.microsoft.com/vscode/devcontainers/python:3.12

RUN apt-get update && \
    apt-get install -y \
    curl \
    python3-venv \
    python3.12 \
    sudo \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1
