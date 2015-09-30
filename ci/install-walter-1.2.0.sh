set -x
set -e
W_VERS=1.2.0
W_DIR=walter_linux_amd64

mkdir -p ~/walter/${W_VERS}

if [ ! -e ~/walter/${W_VERS}/${W_DIR}/walter ]; then
  wget https://github.com/walter-cd/walter/releases/download/v${W_VERS}/walter_${W_VERS}_linux_amd64.tar.gz
  tar xvzf walter_${W_VERS}_linux_amd64.tar.gz -C ~/walter/${W_VERS}
fi

sudo ln -sf ${HOME}/walter/${W_VERS}/${W_DIR}/walter ${HOME}/bin/walter
