FROM maven:3.6.0-jdk-8-alpine  as maven

# COPY ./pom.xml ./pom.xml
COPY ./pom.xml ./pom.xml

RUN mvn dependency:go-offline -B

COPY ./src ./src

RUN mvn package -DskipTests

FROM openjdk:8-jre-alpine

#current working directory
WORKDIR /my-project

# copy over the built artifact from the maven image
COPY --from=maven target/springboot-starterkit-1.0.jar ./
EXPOSE 8081
# set the startup command to run your binary
CMD ["java", "-jar", "./springboot-starterkit-1.0.jar"]