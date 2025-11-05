FROM ubuntu:latest

#RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y lubuntu-desktop

#RUN rm /run/reboot-required*
RUN apt update && apt install -y lubuntu-desktop \
    systemd \
    nginx \
    sudo \
    curl \
    && apt clean
    
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    

RUN [ -e /run/reboot-required* ] && rm /run/reboot-required* || true

RUN useradd -m rocket -p $(openssl passwd rocket)
RUN usermod -aG sudo rocket

RUN apt install -y xrdp
RUN adduser xrdp ssl-cert

RUN sed -i '3 a echo "\
export GNOME_SHELL_SESSION_MODE=lubuntu\\n\
export XDG_SESSION_TYPE=x11\\n\
export XDG_CURRENT_DESKTOP=LXQt\\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-Lubuntu:/etc/xdg\\n\
" > ~/.xsessionrc' /etc/xrdp/startwm.sh

EXPOSE 3389
RUN apt-get update && apt-get install -y sshpass
COPY start_eda.sh /usr/local/bin/start_eda.sh
RUN chmod +x /usr/local/bin/start_eda.sh
#ENTRYPOINT ["/home/rocket/Desktop/start_eda.sh"]
CMD service xrdp start ; bash
RUN mkdir -p home/rocket/.config/autostart 
COPY eda.desktop home/rocket/.config/autostart/eda.desktop
