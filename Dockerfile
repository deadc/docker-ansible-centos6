FROM centos:6
ENV container docker

RUN yum -y update; yum clean all

RUN yum -y install initscripts; yum clean all

RUN mv /etc/init/serial.conf /etc/init/serial.conf.disabled;        \
    mv /etc/init/tty.conf /etc/init/tty.conf.disabled;              \
    mv /etc/init/start-ttys.conf /etc/init/start-ttys.conf.disabled

RUN yum -y install epel-release
RUN yum -y install PyYAML python-crypto python-jinja2 python-paramiko python-setuptools python-six openssl sshpass curl
RUN curl -qs http://releases.ansible.com/keys/RPM-GPG-KEY-ansible-release.pub | gpg --import
RUN rpm -ivh https://releases.ansible.com/ansible/rpm/release/epel-6-x86_64/ansible-2.4.2.0-1.el6.ans.noarch.rpm
RUN curl -fsSL https://goss.rocks/install | sh

WORKDIR /ansible

CMD ["/sbin/init"]
