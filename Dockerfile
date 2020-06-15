## MAVEN
FROM maven:3.6.3-jdk-8 as maven
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD . /usr/src/app
RUN mvn install

## APP
FROM openjdk:8-jdk-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG JAR_FILE=target/gs-spring-boot-docker-0.1.0.jar
COPY --from=maven /usr/src/app/${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]