FROM maven:3.9.4-eclipse-temurin-21-alpine AS root

#Construction de la premiere image
COPY pom.xml ./
COPY src ./src

RUN mvn clean package -DskipTests

#Construction de l'image finale
FROM openjdk:21-ea-oraclelinux8

WORKDIR /app

ENV APP_NAME=tp-cd-2024

COPY --from=root target/*.jar ${APP_NAME}.jar

ENTRYPOINT ["sh", "-c", "java -jar ${APP_NAME}.jar"]