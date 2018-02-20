FROM ubuntu:16.04

RUN apt-get update --quiet

# Make sure dpkg does not ask questions (such as which keyboard layout to configure)
ENV DEBIAN_FRONTEND noninteractive

# Install misc dependencies:
# - curl, git, make: used by many scripts
# - python: used by Cask
# - ruby, xorg: used by EVM
RUN apt-get install --quiet --assume-yes curl git make python ruby xorg

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install --quiet -y nodejs

# Install evm
RUN curl -fsSkL https://raw.github.com/rejeep/evm/master/go | bash
ENV PATH /root/.evm/bin:$PATH

# Install all versions of Emacs available with EVM
RUN evm config path /tmp

RUN evm install emacs-23.4-travis
RUN evm install emacs-24.1-travis
RUN evm install emacs-24.2-travis
RUN evm install emacs-24.3-travis
RUN evm install emacs-24.4-travis
RUN evm install emacs-24.5-travis
RUN evm install emacs-25.1-travis
RUN evm install emacs-25.2-travis
RUN evm install emacs-25.3-travis
RUN evm install emacs-26-pretest-travis
RUN evm install emacs-git-snapshot-travis
RUN evm install remacs-git-snapshot-travis

# Activate latest Emacs release
RUN evm use emacs-25.3-travis
RUN emacs --version

# Install cask
RUN curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
ENV PATH /root/.cask/bin:$PATH

