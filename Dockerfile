FROM ruby:2.3.3

ENV HOME /root

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl git nodejs
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/.nvm
ENV NODE_VERSION stable

# Install nvm
RUN git clone https://github.com/creationix/nvm.git $NVM_DIR && \
    cd $NVM_DIR && \
    git checkout `git describe --abbrev=0 --tags`

# Install default version of Node.js
RUN source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# Add nvm.sh to .bashrc for startup...
RUN echo "source ${NVM_DIR}/nvm.sh" > $HOME/.bashrc && \
    source $HOME/.bashrc

RUN cd ~

RUN mkdir /uenfBook
WORKDIR /uenfBook
ADD Gemfile /uenfBook/Gemfile
ADD Gemfile.lock /uenfBook/Gemfile.lock
RUN bundle install
ADD . /uenfBook