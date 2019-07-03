FROM centos:7

RUN true \
    && yum -y install epel-release \
    # && yum -y install http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm \
    && yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm \
    && yum -y update \
    && yum -y install Percona-Server-client-57 \
    && yum -y install supervisor \
    && yum -y install postgresql-libs unixODBC \
    && rpm -Uhv http://sphinxsearch.com/files/sphinx-2.3.2-1.rhel7.x86_64.rpm \
    && yum clean all \
    && rm -rf /etc/sphinx/sphinx.conf \
    && rm -rf /tmp/yum* \
    && adduser estua

COPY supervisord_sphinx.conf /etc

# Порты контейнера
EXPOSE 9312 9306

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord_sphinx.conf"]

# yum list | grep percona
