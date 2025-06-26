#!/bin/bash

# Start Tomcat in background
catalina.sh start

# Wait for GroupSession to be ready
while [ "$(curl -s -o /dev/null -I -w "%{http_code}" http://localhost:8080/gsession/)" != "200" ]; do
    echo "Waiting for GroupSession to respond"
    sleep 5
done

# Copy configuration
cp /tmp/gsdata.conf /usr/local/tomcat/webapps/gsession/WEB-INF/conf/
touch /usr/local/tomcat/webapps/gsession/WEB-INF/web.xml

# Keep container running
tail -f /dev/null