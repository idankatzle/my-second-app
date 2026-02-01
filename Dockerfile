FROM registry.access.redhat.com/ubi8/python-39

# Copy application files
COPY app.sh index.html ./

# Set execution permissions
USER root
RUN chmod +x app.sh

# Switch back to non-root user for OpenShift security
USER 1001

# Execute the startup script
CMD ["./app.sh"]
