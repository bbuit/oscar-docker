FROM ubuntu:latest

RUN mkdir -p /home && \
    cd /home 

COPY . /home
WORKDIR /home/oscar
RUN apt-get update
RUN apt-get install -y \
    && apt-get install -y wget

FROM tomcat:9-jre8 as ship
#FROM 9.0.65-jdk8-openjdk-slim as ship

RUN wget http://sourceforge.net/projects/oscarmcmaster/files/Oscar\ Debian\+Ubuntu\ deb\ Package/oscar_emr19-69~2239.deb
RUN dpkg -i oscar_emr19-69~2239.deb
ADD conf /usr/local/tomcat/conf
COPY conf/oscar_mcmaster.properties /root/oscar_mcmaster.properties

ENV JDBC_URL="jdbc:mysql://db:3306/oscar_mcmaster?autoReconnect=true&zeroDateTimeBehavior=round&useOldAliasMetadataBehavior=true&jdbcCompliantTruncation=false"
ENV JDBC_USER="root"
ENV JDBC_PASS="root"
ENV db_username="root"
ENV db_password="root"
ENV db_uri="jdbc:mysql://db:3306/"
ENV db_name="oscar_mcmaster?autoReconnect=true&zeroDateTimeBehavior=round&useOldAliasMetadataBehavior=true&jdbcCompliantTruncation=false"

EXPOSE 8080

CMD ["catalina.sh", "run"]
