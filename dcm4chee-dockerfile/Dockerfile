FROM dcm4che/wildfly:10.0.0.Final

COPY configuration /docker-entrypoint.d/configuration
COPY resources /resources
RUN cd $JBOSS_HOME \
    && tar -xzvf /resources/jai_imageio-jboss-modules-1.2-pre-dr-b04.tar.gz \
    && tar -xzvf /resources/querydsl-jboss-modules-4.0.3-noguava.tar.gz \
    && tar -xzvf /resources/jclouds-jboss-modules-1.9.1-noguava.tar.gz \
    && tar -xzvf /resources/dcm4che-jboss-modules-dcm4chee-arc-light-5.2.1.tar.gz \
    && unzip /resources/jdbc-jboss-modules-1.0.0-mysql.zip \
    && cp /resources/mysql-connector-java-5.1.36-bin.jar modules/com/mysql/main/ \
    && cp /resources/dcm4chee-arc-ear-5.2.1-mysql.ear /docker-entrypoint.d/deployments/

CMD ["standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "dcm4chee-arc.xml"]
