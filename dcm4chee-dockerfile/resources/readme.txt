The file dcm4chee-arc-ear-5.3.1-mysql.ear was created using the contents of the original dcm4chee-arc-ear-5.3.1-mysql
file located in the dcm4chee-arc-light binary distribution, replacing:
- dcm4chee-arc-war-5.3.1-unsecure.war with dcm4chee-arc-war-5.3.1-secure.war
- dcm4chee-arc-ui-5.3.1-unsecure.war with dcm4chee-arc-ui-5.3.1-secure.war
both taken from http://www.dcm4che.org/maven2/org/dcm4che/dcm4chee-arc/dcm4chee-arc-ear/5.3.1/dcm4chee-arc-ear-5.3.1-psql-secure.ear,
since this is the only "secure" ear file provided by dcm4che.

Rebuild with:
  jar -cvf dcm4chee-arc-ear-5.3.1-mysql.ear .
