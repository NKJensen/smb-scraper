FROM mcr.microsoft.com/devcontainers/base:ubuntu
WORKDIR /usr/local/app

RUN apt update && apt install -y bash curl smbclient nano samba python3 python3-pip
RUN pip3 install pysmb

RUN bash -c "$(curl -L https://setup.vector.dev)"
RUN apt install -y vector

COPY scrape_logs.py /usr/local/app/
COPY vector.yaml /usr/local/app
COPY start.sh /usr/local/app
RUN chmod +x /usr/local/app/start.sh

CMD ["bash"]

