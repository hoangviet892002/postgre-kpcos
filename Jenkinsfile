pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    //  enter password for sudo
                    
                    sh 'sudo docker-compose -f docker-compose.yml build'
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