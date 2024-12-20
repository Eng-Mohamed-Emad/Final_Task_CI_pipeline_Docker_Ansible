# Use a minimal Python base image
FROM python:3.9-slim

# Set environment variables to improve Python performance
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . /app/

# Expose the application port (adjust if your app uses a different port)
EXPOSE 5000

# Specify the default command to run the application
CMD ["python", "app.py"]
