FROM tomcat:latest

LABEL maintainer="gopal"
#RUN cp -r /usr/local/tomcat/webapps.dest/* /usr/local/tomcat/webapps/

ADD ./target/LoginWebApp-1.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
