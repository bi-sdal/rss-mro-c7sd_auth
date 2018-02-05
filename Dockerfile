FROM sdal/r-ldap-ssh-c7
MAINTAINER "Daniel Chen" <chend@vt.edu>

## Add RStudio binaries to PATH
ENV PATH /usr/lib/rstudio-server/bin/:$PATH

## Install Download Prerequisites
RUN cp /etc/pam.d/login /etc/pam.d/rstudio

## Download and Install Rstudio-server
RUN apt-get -y install curl gdebi-core && \
    curl -O https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-server-1.1.372-amd64.deb && \
    gdebi --n rstudio-server-*-amd64.deb

RUN systemctl enable rstudio-server

# Add default rstudio user with pass rstudio
RUN useradd -m -d /home/rstudio rstudio && echo rstudio:rstudio | chpasswd

# Get the Rprofile.site file
# RUN wget -O /usr/lib64/R/etc/Rprofile.site https://raw.githubusercontent.com/bi-sdal/mro-ldap-ssh-c7/master/Rprofile.site

EXPOSE 8787

CMD ["/lib/systemd/systemd"]
#CMD ["/usr/sbin/init"]
