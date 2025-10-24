# Étape 1 : Construire l'application
# On utilise une image qui a déjà 'mvn' d'installé
FROM maven:3.8-openjdk-17 AS builder

WORKDIR /app

# 1. Copier SEULEMENT le pom.xml
COPY pom.xml .

# 2. Lancer le téléchargement des dépendances avec 'mvn'
#    Ceci sera mis en cache par Docker
RUN mvn dependency:go-offline

# 3. Copier tout le reste du code source
COPY .mvn/ .mvn
COPY mvnw mvnw.cmd ./
COPY src ./src

# 4. Construire le projet (toujours avec 'mvn')
RUN mvn package -DskipTests


# Étape 2 : Créer l'image finale
FROM eclipse-temurin:17-jre-focal
WORKDIR /app

# Copier le .jar final depuis l'étape 1
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]