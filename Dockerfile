# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app



# Copy all project files
COPY . .



# Build the project and skip tests for faster build
RUN mvn clean package -DskipTests



# -------- Run Stage --------
FROM eclipse-temurin:21-jdk
WORKDIR /app



# Copy the jar built in the previous stage
COPY --from=build /app/target/*.jar app.jar



# Expose the default HTTP port
EXPOSE 8080



# Run the app with the port Render provides
CMD ["sh", "-c", "java -Dserver.port=$PORT -jar app.jar"]


