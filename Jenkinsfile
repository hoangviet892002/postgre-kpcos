pipeline {
  agent any
  environment {
    SERVICE_URL = "http://localhost:82/"
    COMPOSE_FILE = "docker-compose.yml"
    REDIS_URL = "localhost:6379"
    REDIS_COMPOSE_FILE = "redis-docker-compose.yml"
  }
  stages {
    stage("Verify Tooling") {
      steps {
        echo "Checking Docker version..."
        sh 'docker version'

        echo "Checking Docker info..."
        sh 'docker info'

        echo "Checking Docker Compose version..."
        sh 'docker compose version'

        echo "Checking curl version..."
        sh 'curl --version'

        echo "Checking jq version..."
        sh 'jq --version'
      }
    }
 
    stage('Prune Docker Data') {
      steps {
        echo "Pruning Docker system..."
        sh 'docker system prune -a --volumes -f'
      }
    }
    // deploy postgres

    // stage('Start Container postgres') {
    //   steps {
    //     echo "Starting Docker containers postgres..."
    //     sh "docker compose -f ${env.COMPOSE_FILE} up -d --no-color --wait"

    //     echo "Listing running containers postgres..."
    //     sh "docker compose -f ${env.COMPOSE_FILE} ps"
    //   }
    // }

    // stage('Run Tests Against the Container postgres') {
    //   steps {
    //     echo "Running tests against the service at ${env.SERVICE_URL}..."
    //     sh "curl -f ${env.SERVICE_URL} | jq"
    //   }
    // }
    stage('Start Container redis') {
      steps {
        echo "Starting Docker containers..."
        sh "docker compose -f ${env.REDIS_COMPOSE_FILE} up -d --no-color --wait"

        echo "Listing running containers..."
        sh "docker compose -f ${env.REDIS_COMPOSE_FILE} ps"
      }
    }
  
    
    
    stage ('Run Tests Against the Container redis') {
      steps {
        echo "Running tests against Redis at ${env.REDIS_URL}..."
        sh "docker run --rm redis redis-cli -h localhost -p 6379 ping"
      }
    }


  }
  post {
    always {
      echo "Cleaning up Docker containers..."
      script {
        try {
          sh "docker compose -f ${env.COMPOSE_FILE} down --remove-orphans -v"
        } catch (e) {
          echo "Cleanup encountered an issue: ${e}"
        }
      }
      echo "Final Docker container states:"
      sh "docker compose -f ${env.COMPOSE_FILE} ps"
    }
    failure {
      echo "Pipeline failed. Please check the logs for more details."
    }
  }
}
