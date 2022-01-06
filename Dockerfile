FROM maven:3.6.0-jdk-8-alpine  as maven

WORKDIR /my-project 

# COPY ./pom.xml ./pom.xml
COPY . .

RUN mvn dependency:go-offline -B

# COPY ./src ./src

RUN mvn package -DskipTests

FROM openjdk:18-jdk-alpine3.15

#current working directory
WORKDIR /my-project

# copy over the built artifact from the maven image
COPY --from=maven target/springboot-starterkit-1.0.jar ./
EXPOSE 8080
# set the startup command to run your binary
ENTRYPOINT ["java", "-jar"]

CMD ["springboot-starterkit-1.0.jar"]