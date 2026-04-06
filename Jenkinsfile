pipeline {
    agent any

    environment {
        REGISTRY = "myacr998.azurecr.io"
        IMAGE_NAME = "AKS-javaapp"
    }

    stages {

        stage('Clone Code') {
            steps {
                git branch: main, url:'https://github.com/Manasa2932/AKS-javaapp.git'
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
                sh 'az acr login --name myacr998'
                sh 'docker push $REGISTRY/$IMAGE_NAME:latest'
            }
        }
stage('Login to ACR') {
    steps {
        sh 'az acr login --name myacr998'
    }
}

        stage('Deploy to AKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
