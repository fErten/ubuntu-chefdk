FROM eclipse/stack-base:ubuntu
User root

# Update aptitude with new repo
RUN apt-get update


# Install Chef
RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git
RUN wget https://packages.chef.io/files/stable/chefdk/3.8.14/ubuntu/18.04/chefdk_3.8.14-1_amd64.deb
RUN dpkg -i chefdk_3.8.14-1_amd64.deb

# Chef shell initialization add path to the bashrc
RUN echo 'eval "$(chef shell-init bash)"' >> ~/.bashrc
ENV PATH="/opt/chefdk/embedded/bin:${PATH}"

COPY ./chef-repo /chef-repo

# source bashrc to use chef executables
RUN /bin/bash -c "source ~/.bashrc"
