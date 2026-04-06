pipeline {
    agent any

    environment {
        REGISTRY = "myacr998.azurecr.io"
        IMAGE_NAME = "aks-javapp"
        AZURE_TENANT = "<tenant-id>"          // replace with your Azure tenant ID
    }

    stages {

        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Manasa2932/AKS-javaapp.git'
            }
        }

        stage('Build') {
            steps {
                sh "mvn clean package"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $REGISTRY/$IMAGE_NAME:latest ."
            }
        }

        stage('Login to Azure') {
            steps {
                // Use Jenkins credentials for Service Principal
                withCredentials([usernamePassword(credentialsId: 'acr-sp', usernameVariable: 'SP_APPID', passwordVariable: 'SP_PASSWORD')]) {
                    sh """
                        az login --service-principal -u $SP_APPID -p $SP_PASSWORD --tenant $AZURE_TENANT
                    """
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "az acr login --name myacr998"
                sh "docker push $REGISTRY/$IMAGE_NAME:latest"
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh "kubectl apply -f deployment.yaml"
            }
        }
    }
}
