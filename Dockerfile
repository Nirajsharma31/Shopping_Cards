# Build Stage
FROM eclipse-temurin:17-jdk-focal AS builder

WORKDIR /app

# Copy all project files
COPY . .

# Give permission to mvnw
RUN chmod +x mvnw

# Build the Spring Boot project
RUN ./mvnw clean package -DskipTests

# Runtime Stage
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Copy generated jar file
COPY --from=builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run application
ENTRYPOINT ["java","-jar","app.jar"]
