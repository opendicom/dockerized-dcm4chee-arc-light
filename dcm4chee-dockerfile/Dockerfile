FROM dcm4che/wildfly:10.0.0.Final

ENV DCM4CHEE_ARC_VERSION "5.3.1"
ENV DCM4CHE_VERSION "dcm4chee-arc-light-${DCM4CHEE_ARC_VERSION}"
ENV BASE_URL "http://www.dcm4che.org/maven2/org/dcm4che"
ENV MYSQL_CONNECTOR "mysql-connector-java-5.1.36"

# download and decompress JBOSS modules
RUN cd $JBOSS_HOME \
    && curl ${BASE_URL}/jai_imageio-jboss-modules/1.2-pre-dr-b04/jai_imageio-jboss-modules-1.2-pre-dr-b04.tar.gz | tar xz \
    && curl ${BASE_URL}/querydsl-jboss-modules/4.0.3-noguava/querydsl-jboss-modules-4.0.3-noguava.tar.gz | tar xz \
    && curl ${BASE_URL}/jclouds-jboss-modules/1.9.1-noguava/jclouds-jboss-modules-1.9.1-noguava.tar.gz | tar xz \
    && curl ${BASE_URL}/dcm4che-jboss-modules/$DCM4CHE_VERSION/dcm4che-jboss-modules-${DCM4CHE_VERSION}.tar.gz | tar xz \
    && curl -O ${BASE_URL}/jdbc-jboss-modules/1.0.0/jdbc-jboss-modules-1.0.0-mysql.zip \
        && unzip jdbc-jboss-modules-1.0.0-mysql.zip

# download mysql java connector, decompress and move to final location
RUN cd \
    && curl -L https://downloads.mysql.com/archives/get/file/${MYSQL_CONNECTOR}.tar.gz | tar xz \
        && mv ${MYSQL_CONNECTOR}/${MYSQL_CONNECTOR}-bin.jar $JBOSS_HOME/modules/com/mysql/main/

# copy ear file
COPY resources/dcm4chee-arc-ear-5.2.1-mysql.ear /docker-entrypoint.d/deployments/

COPY configuration /docker-entrypoint.d/configuration

CMD ["standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "dcm4chee-arc.xml"]
