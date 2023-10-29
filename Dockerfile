FROM ubuntu:20.04

LABEL maintainer="O. Adetiba <olumide.adetiba@live.com>"

# Make sure the package repository is up to date.
RUN mkdir -p /var/run/sshd

RUN apt-get -y update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y openssh-server
RUN ssh-keygen -A

ADD ./sshd_config /etc/ssh/sshd_config

# Add user jenkins to the image
RUN adduser --quiet jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:password123" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
#docker build -t ti-jenkins-slave:v1 .
