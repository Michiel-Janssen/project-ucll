# https://dzone.com/articles/a-dockerfile-for-maven-based-github-projects

FROM alpine/git
RUN mdkir -p /app
WORKDIR /app
RUN git clone https://github.com/Michiel-Janssen/project-ucll.git

FROM maven:3.6.1-jdk-8-alpine
WORKDIR /app
copy --from=0 /app/project-ucll /app
RUN mvn clean install

FROM tomcat:8.5.43-jdk8
WORKDIR /app
COPY --from=1 /app/target/project-ucll-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/project
EXPOSE 8080
