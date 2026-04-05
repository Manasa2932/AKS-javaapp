FROM ubuntu:20.04

# Avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache2 web server
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Copy your custom index.html into Apache's default web directory
COPY index.html /var/www/html/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
