pipeline {
    agent any

    environment {
        SUDO_PASSWORD = credentials('8<pS11"ilL')  
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh """
                    echo '$SUDO_PASSWORD' | sudo -S docker-compose -f docker-compose.yml build
                    """
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'sudo docker-compose -f docker-compose.yml up -d'
                }
            }
        }
    }
}