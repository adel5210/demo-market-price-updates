# Stage 1: Build using Maven and JDK 25
FROM maven:3.9.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Runtime using a slim JRE 25 image
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render uses the PORT environment variable
EXPOSE 8080

# Tune memory for Render's Free Tier (512MB RAM)
ENTRYPOINT ["java", "-Xmx384m", "-Xms256m", "-jar", "app.jar"]