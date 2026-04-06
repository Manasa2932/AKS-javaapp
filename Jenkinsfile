pipeline {
    agent any

    environment {
        REGISTRY = "myacr12345.azurecr.io"
        IMAGE_NAME = "aks-javapp"
    }

    stages {

        stage('Clone Code') {
            steps {
               git branch: 'main', url: 'https://github.com/Manasa2932/AKS-javaapp.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $REGISTRY/$IMAGE_NAME:latest .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'az acr login --name myacr12345'
                sh 'docker push $REGISTRY/$IMAGE_NAME:latest'
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
