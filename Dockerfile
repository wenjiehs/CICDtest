#新生成的镜像是基于sshd:dockerfile镜像
FROM sshd:dockerfile
MAINTAINER by Steven
#安装wget
RUN yum install -y wget
WORKDIR /usr/local/src
#下载并解压源码包
RUN wget http://apache.fayea.com/httpd/httpd-2.4.17.tar.gz
RUN tar -zxvf httpd-2.4.17.tar.gz
WORKDIR httpd-2.4.17
#编译安装apache
RUN yum install -y gcc make apr-devel apr apr-util apr-util-devel pcre-devel
RUN ./configure --prefix=/usr/local/apache2  --enable-mods-shared=most  --enable-so
RUN make
RUN make install
#修改apache配置文件
RUN sed -i 's/#ServerName www.example.com:80/ServerName localhost:80/g' /usr/local/apache2/conf/httpd.conf
#启动apache服务
RUN /usr/local/apache2/bin/httpd
#复制服务启动脚本并设置权限
ADD run.sh /usr/local/sbin/run.sh
RUN chmod 755 /usr/local/sbin/run.sh
#开放80端口
EXPOSE 80
CMD ["/usr/local/sbin/run.sh"]