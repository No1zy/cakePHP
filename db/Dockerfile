FROM centos
RUN yum update -y
RUN yum install -y mysql mariadb-server vim
RUN systemctl enable mariadb
CMD ["/sbin/init"]
