FROM ubuntu
WORKDIR /usr/local/app

RUN apt update && apt install -y bash curl smbclient nano
RUN bash -c "$(curl -L https://setup.vector.dev)"
RUN apt install -y vector

COPY vector.yaml /usr/local/app
COPY start.sh /usr/local/app
RUN chmod +x /usr/local/app/start.sh

CMD ["bash"]