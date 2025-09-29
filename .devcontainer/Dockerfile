FROM fedora:latest

RUN sudo dnf upgrade -y

RUN sudo dnf install -y dnf-plugins-core \
&& sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo \
&& sudo dnf -y install terraform

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sudo sh ./get-docker.sh

RUN sudo dnf install ansible -y

CMD [ "/bin/bash" ]

