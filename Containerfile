FROM docker.io/debian:bookworm-slim

RUN apt update && apt install -y \
  git \
  neovim \
  fzf \
  ripgrep \
  zip \
  zsh \
  curl \
  make \
  direnv

RUN /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY .streamcli/.zshrc /root/.zshrc

RUN chsh -s /bin/zsh

