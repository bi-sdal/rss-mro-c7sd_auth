FROM sdal/mro-ldap-ssh-c7
MAINTAINER "Aaron D. Schroeder" <aschroed@vt.edu>

## Add RStudio binaries to PATH
ENV PATH /usr/lib/rstudio-server/bin/:$PATH

## Install Download Prerequisites
RUN yum install -y which
RUN cp /etc/pam.d/login /etc/pam.d/rstudio
RUN yum -y install dejavu-sans-fonts dejavu-serif-font

## Download and Install Rstudio-server
RUN curl -O https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-server-rhel-1.0.143-x86_64.rpm
RUN yum install -y --nogpgcheck rstudio-server-rhel-1.0.143-x86_64.rpm
RUN systemctl enable rstudio-server

# Add default rstudio user with pass rstudio
RUN useradd -m -d /home/rstudio rstudio && echo rstudio:rstudio | chpasswd

EXPOSE 8787

CMD ["/lib/systemd/systemd"]
#CMD ["/usr/sbin/init"]
