pipeline {
    agent any

    environment {
        SUDO_PASSWORD = credentials('sudo-password-id')  
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
                    sh """
                    echo '$SUDO_PASSWORD' | sudo -S docker-compose -f docker-compose.yml up -d
                    """
                }
            }
        }
    }
}
