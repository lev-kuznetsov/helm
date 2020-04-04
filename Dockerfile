FROM golang

RUN apt-get update -y && apt-get install -y docker curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
RUN mkdir -p /src
WORKDIR /src
COPY . .
RUN make
RUN cp ./bin/helm /usr/local/bin

CMD ["helm"]
