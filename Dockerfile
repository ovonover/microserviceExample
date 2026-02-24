# -------- Build Stage --------
FROM maven:3.9-eclipse-temurin-25-alpine AS build
WORKDIR /app



# Copy all project files
COPY . .



# Build the project and skip tests for faster build
RUN mvn clean package -DskipTests



# -------- Run Stage --------
FROM azul/zulu-openjdk-alpine:25-jre-headless-latest
WORKDIR /app



# Copy the jar built in the previous stage
COPY --from=build /app/target/*.jar app.jar



# Expose the default HTTP port
EXPOSE 8080



# Run the app with the port Render provides
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar app.jar"]


