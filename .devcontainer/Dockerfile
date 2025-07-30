# Use the linuxserver/code-server image as the base
FROM linuxserver/code-server:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    python3-venv \
    python3-poetry \
    duckdb \
    sudo \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set the PATH to include Poetry's bin directory
ENV PATH="/root/.local/bin:$PATH"

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml ./
COPY poetry.lock ./

# Set up Python
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
ENV VIRTUAL_ENV=/app/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m venv $VIRTUAL_ENV \
    && poetry install --no-interaction --no-root

# Final entrypoint
ENTRYPOINT ["/init"]