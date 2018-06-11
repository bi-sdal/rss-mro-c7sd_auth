FROM sdal/mro-c7sd_auth
MAINTAINER "Daniel Chen" <chend@vt.edu>

## Add RStudio binaries to PATH
ENV PATH /usr/lib/rstudio-server/bin/:$PATH

## Install Download Prerequisites
RUN yum install -y initscripts && \
    cp /etc/pam.d/login /etc/pam.d/rstudio

## Download and Install Rstudio-server
RUN curl -O https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.2.637-x86_64.rpm && \
    yum install -y --nogpgcheck rstudio-server-rhel-*.rpm

RUN systemctl enable rstudio-server

# Add default rstudio user with pass rstudio
RUN useradd -m -d /home/rstudio rstudio && echo rstudio:rstudio | chpasswd

# Get the Rprofile.site file
# RUN wget -O /usr/lib64/R/etc/Rprofile.site https://raw.githubusercontent.com/bi-sdal/mro-ldap-ssh-c7/master/Rprofile.site

RUN yum install -y htop nano emacs vim && \
    yum install -y openssh openssh-server openssh-clients openssl-libs && \
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig && \
    systemctl enable sshd.service

EXPOSE 8787

CMD ["/lib/systemd/systemd"]
#CMD ["/usr/sbin/init"]
