FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY target/demo-1.0.0.jar app.jar
EXPOSE 80
CMD ["java", "-jar", "app.jar", "--server.port=80"]
