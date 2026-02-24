# ---- Stage 1: Build ----
FROM maven:3.9-amazoncorretto-21 AS builder

WORKDIR /app

# Copy pom.xml first for dependency caching
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build the jar
COPY src ./src
RUN mvn clean package -DskipTests

# ---- Stage 2: Run ----
FROM azul/zulu-openjdk-alpine:25-jre-headless-latest

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]