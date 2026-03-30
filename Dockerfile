# Stage 1: Build using the official Temurin JDK 25 image
FROM eclipse-temurin:25-jdk-jammy AS build
WORKDIR /app

# Copy the wrapper and pom first to leverage Docker layer caching
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
# This will download dependencies without building the whole app yet
RUN ./mvnw dependency:go-offline

# Now copy source and build
COPY src ./src
RUN ./mvnw clean package -DskipTests

# Stage 2: Tiny runtime image
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render Port
EXPOSE 8080

# Performance Tuning for Render's 512MB RAM
# Since you're doing price updates, you might need room for off-heap memory
ENTRYPOINT ["java", "-Xmx350m", "-Xss512k", "-XX:+UseZGC", "-jar", "app.jar"]