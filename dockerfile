# Use a minimal Python base image
FROM python:3.9-slim

# Set environment variables to improve Python performance and security
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install essential system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /app

# Copy only the requirements file for dependency installation
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Add a non-root user and switch to it
RUN useradd -m appuser
USER appuser

# Copy the application code into the container
COPY --chown=appuser:appuser . /app/

# Expose the application port (adjust if necessary)
EXPOSE 5000

# Specify the default command to run the application
CMD ["/usr/local/bin/python", "app.py"]
