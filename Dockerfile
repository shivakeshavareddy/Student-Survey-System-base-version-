# we are extending everything from tomcat:8.0 image ...
FROM tomcat:8.0
MAINTAINER ptamhank
COPY surveyform.war /usr/local/tomcat/webapps
EXPOSE 8080/tcp
