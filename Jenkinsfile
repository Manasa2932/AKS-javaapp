pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t myacr12345.azurecr.io/aks-javapp:latest .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push myacr12345.azurecr.io/aks-javapp:latest'
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
