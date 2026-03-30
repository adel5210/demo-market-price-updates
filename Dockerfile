FROM openjdk:25-alpine
COPY backend/target/mini-chat-back-0.0.1-SNAPSHOT.jar MiniChat.jar
ENTRYPOINT [ "java","-jar","/app.jar"]