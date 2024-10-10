FROM ubuntu
WORKDIR /usr/local/app

RUN apt update && apt install -y bash curl cifs-utils
RUN bash -c "$(curl -L https://setup.vector.dev)"
RUN apt install -y vector

COPY vector.yaml /usr/local/app
COPY start.sh /usr/local/app
RUN chmod +x /usr/local/app/start.sh

# Create a mount point
RUN mkdir -p /mnt/smbshare

ENTRYPOINT ["/usr/local/app/start.sh"]
CMD ["bash"]