pipeline {
    agent any

    environment {
        REGISTRY = "myacr998.azurecr.io"
        IMAGE_NAME = "aks-javapp"
        AZURE_TENANT = "af5c40c2-7c44-480f-aa0e-b007cd9e101d" // your Azure tenant ID
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
                sh "docker build -t $REGISTRY/$IMAGE_NAME:latest ."
            }
        }

        stage('Login to Azure & Push Image') {
            steps {
                // Use Jenkins credentials for Service Principal
                withCredentials([usernamePassword(
                    credentialsId: 'acr-sp', 
                    usernameVariable: 'AZURE_CLIENT_ID', 
                    passwordVariable: 'AZURE_CLIENT_SECRET'
                )]) {
                    sh """
                        echo 'Logging in to Azure using Service Principal...'
                        az login --service-principal -u \$AZURE_CLIENT_ID -p \$AZURE_CLIENT_SECRET --tenant \$AZURE_TENANT
                        az acr login --name myacr998
                        docker push \$REGISTRY/\$IMAGE_NAME:latest
                    """
                }
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
