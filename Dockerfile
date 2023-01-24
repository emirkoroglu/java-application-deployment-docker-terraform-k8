FROM maven:3.8-jdk-11 AS build_step
RUN mkdir /project
COPY . /project
WORKDIR /project
RUN mvn clean package -DskipTests

FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine-slim
RUN mkdir /application
COPY --from=build_step /project/target/awesome-app-1.0.jar /application
WORKDIR /application
CMD ["java", "-jar", "awesome-app-1.0.jar"]
