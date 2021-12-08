FROM kartoza/geoserver

RUN wget -O /tmp/css-plugin.zip https://sourceforge.net/projects/geoserver/files/GeoServer/2.20.0/extensions/geoserver-2.20.0-css-plugin.zip/download &&\
    mkdir /tmp/x &&\
    unzip /tmp/css-plugin.zip -d /tmp/x &&\
    mv /tmp/x/*.jar /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/ &&\
    rm -rf /tmp/x /tmp/css-plugin.zip