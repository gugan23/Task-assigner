# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install Node.js
RUN apt-get update && apt-get install -y nodejs npm

# Copy backend files
COPY app.py .
COPY .env .

# Copy frontend files
COPY template-management/ template-management/

# Install frontend dependencies
WORKDIR /app/template-management
RUN npm install

# Build frontend
RUN npm run build

# Go back to app directory
WORKDIR /app

# Expose port
EXPOSE 5000

# Command to run both frontend and backend
CMD ["python", "app.py"]