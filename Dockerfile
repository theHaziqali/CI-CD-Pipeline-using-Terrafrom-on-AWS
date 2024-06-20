FROM ubuntu:20.04


# Install terraform
RUN apt-get update && apt-get -y install curl software-properties-common && \
    apt-get -y install git
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt update && apt install terraform
RUN mkdir terraform

COPY . .