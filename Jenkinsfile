pipeline {
    agent any

    environment {
        SUDO_PASSWORD = '8<pS11"ilL' 
    }

    stages {
        stage('Build') {
            steps {
                script {
                    sh """
                    export SUDO_ASKPASS=/usr/bin/ssh-askpass
                    echo '$SUDO_PASSWORD' | sudo -S docker-compose -f docker-compose.yml build
                    """
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh """
                    export SUDO_ASKPASS=/usr/bin/ssh-askpass
                    echo '$SUDO_PASSWORD' | sudo -S docker-compose -f docker-compose.yml up -d
                    """
                }
            }
        }
    }
}
