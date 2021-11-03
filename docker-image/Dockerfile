FROM debian

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install nmap \
  bash-completion \
  netcat \
  nano \
  curl \
  wget \
  procps \
  gawk \
  python3 \
  python3-pip \
  tree \
  vim \
  dnsutils \
  nodejs && \
  ln -s /usr/bin/python3 /usr/local/bin/python && \
  curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
  mv kubectl /usr/local/bin/ && \
  chmod a+rx /usr/local/bin/kubectl && \
  mkdir -p ~/.vim/pack/themes/start/dracula_pro/ && \
  mkdir ~/.kube && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# vim config for dracula themed syntax highlighting
COPY vim /root/.vim/pack/themes/start/dracula_pro/
COPY .vimrc /root/

# better bash configuration
COPY .bashrc /root/

WORKDIR /root

CMD exec /bin/bash -c "trap : TERM INT; sleep 9999999999d & wait"
