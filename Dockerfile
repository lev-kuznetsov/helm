FROM golang AS build

RUN mkdir -p /src
WORKDIR /src
COPY . .
RUN make

FROM alpine:3.6

RUN apk update && apk add docker curl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl
COPY --from=build /src/bin/helm /usr/local/bin/

ENTRYPOINT ["helm"]
CMD ["helm"]
