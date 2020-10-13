FROM jenkins/jenkins:lts
# We set User "root" because default user "jenkins" for Jenkins. If we don't this, it will fail when commands run.
USER root 
RUN apt-get update -y && apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce docker-ce-cli containerd.io
RUN curl -O https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip && unzip terraform_0.11.13_linux_amd64.zip -d /usr/local/bin/
# We're set back the user as "jenkins".
USER ${user}