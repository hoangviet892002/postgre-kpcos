pipeline {
    agent any

    environment {
        SUDO_PASSWORD = credentials('sudo-password-id')  
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    sh '''
                    /usr/bin/expect -c "
                    set timeout -1
                    spawn sudo docker-compose -f docker-compose.yml build
                    expect \"password for\"
                    send \"${SUDO_PASSWORD}\r\"
                    interact
                    "
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh """
                    /usr/bin/expect <<EOD
                    spawn sudo docker-compose -f docker-compose.yml up -d
                    expect "password for"
                    send "${SUDO_PASSWORD}\\r"
                    interact
                    EOD
                    """
                }
            }
        }
    }
}
