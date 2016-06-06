FROM dcm4che/wildfly:10.0.0.Final

ENV DCM4CHEE_ARC_VERSION="5.3.1"
ENV DCM4CHE_VERSION="dcm4chee-arc-$DCM4CHEE_ARC_VERSION-mysql"
ENV MYSQL_CONNECTOR="mysql-connector-java-5.1.36"

# download binary distribution
RUN curl -O -L https://sourceforge.net/projects/dcm4che/files/dcm4chee-arc-light5/$DCM4CHEE_ARC_VERSION/$DCM4CHE_VERSION.zip \
    && unzip $DCM4CHE_VERSION.zip \
    && cd $DCM4CHE_VERSION \
    && for module in jboss-modules/*; do unzip $module -d $JBOSS_HOME; done

# ear file
COPY resources/dcm4chee-arc-ear-5.3.1-mysql.ear /docker-entrypoint.d/deployments/

# download mysql java connector, decompress and move to final location
RUN curl -L https://downloads.mysql.com/archives/get/file/$MYSQL_CONNECTOR.tar.gz | tar xz \
    && mv $MYSQL_CONNECTOR/$MYSQL_CONNECTOR-bin.jar $JBOSS_HOME/modules/com/mysql/main/

# copy configuration files
COPY configuration /docker-entrypoint.d/configuration

CMD ["standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "dcm4chee-arc.xml", \
     "-Dkeycloak.import=/opt/wildfly/standalone/configuration/dcm4che-realm.json"]
