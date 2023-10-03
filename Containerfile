FROM docker.io/debian:bookworm-slim

RUN apt update && apt install -y \
  git \
  neovim \
  python3 \
  python3-pip \
  fzf \
  ripgrep \
  zip \
  zsh \
  curl \
  make \
  build-essential \
  direnv

RUN /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY .streamcli/.zshrc /root/.zshrc

WORKDIR /projects

