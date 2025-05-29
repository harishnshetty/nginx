# Use official Nginx image as base
FROM nginx:alpine

# Remove the default Nginx static assets (optional)
RUN rm -rf /usr/share/nginx/html/*

# Copy your static website files into the Nginx web directory
COPY ./html /usr/share/nginx/html

# Copy custom Nginx config if you have one (optional)
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (optional here because nginx does it by default)
EXPOSE 80

# Start Nginx (default command already in base image, so this is optional)
CMD ["nginx", "-g", "daemon off;"]
