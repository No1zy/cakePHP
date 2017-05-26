FROM centos
RUN yum update -y
RUN yum install -y httpd vim git
RUN yum install -y epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi,remi-php56 php php-devel php-mbstring php-pdo php-gd php-mysql
RUN systemctl enable httpd
CMD ["/sbin/init"]
