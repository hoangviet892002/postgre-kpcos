pipeline {
    agent any

    environment {
        SUDO_PASSWORD = credentials('sudo-password-id') 
    }
    
    stages {
        stage('Build') {
            steps {
                // Use triple single quotes to prevent Groovy from processing the string
                sh '''
/usr/bin/expect <<'EOD'
set timeout -1
spawn sudo docker-compose -f docker-compose.yml build
expect "password for"
send "$env(SUDO_PASSWORD)\r"
interact
EOD
'''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
/usr/bin/expect <<'EOD'
set timeout -1
spawn sudo docker-compose -f docker-compose.yml up -d
expect "password for"
send "$env(SUDO_PASSWORD)\r"
interact
EOD
'''
            }
        }
    }
}
