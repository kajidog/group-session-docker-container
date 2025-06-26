FROM tomcat:9-jdk11-temurin

# Set Japanese locale
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8

COPY gsession.war ${CATALINA_HOME}/webapps/
COPY startup.sh /
COPY gsdata.conf /tmp/

RUN chmod +x /startup.sh \
    && echo "Asia/Tokyo" > /etc/timezone

VOLUME ["/home/gsession"]
EXPOSE 8080
CMD ["/startup.sh"]
