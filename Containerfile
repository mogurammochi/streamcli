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
  direnv \
  && rm -rf /var/lib/apt/lists/*

RUN /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
  && git clone https://github.com/anyenv/anyenv ~/.anyenv \
  && ~/.anyenv/bin/anyenv install --force-init

COPY .streamcli/.zshrc /root/.zshrc
COPY .streamcli/.config/nvim /root/.config/nvim

RUN chsh -s /bin/zsh

