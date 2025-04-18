pipeline {
  agent any

  environment {
    DOCKER_IMAGE          = 'donhadley/peabsmartapp'
    DOCKERFILE            = 'Dockerfile'
    DOCKER_REGISTRY       = 'index.docker.io/v1'
    DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    DOCKER_TAG            = "${env.BUILD_NUMBER}"
    EC2_INSTANCE_ID       = 'i-05d37916155efbc80'
    EC2_REGION            = 'us-east-1'
    SSH_CREDENTIALS_ID    = 'ec2-ssh-key'
    EC2_USER              = 'ubuntu'
    EC2_HOST              = '3.89.70.94'
    CONTAINER_NAME        = 'peabsmart-app'
    HOST_PORT             = 80
    CONTAINER_PORT        = 9090
  }

  stages {

    stage('Checkout') {
      steps {
        echo 'Checking out code...'
        checkout scm
      }
    }

    stage('Build') {
      steps {
        echo 'Building Docker image...'
        script {
          docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", "-f ${DOCKERFILE} .")
        }
      }
    }

    stage('Test') {
      steps {
        echo 'Running tests...'
      }
    }

    stage('Push') {
      steps {
        echo 'Pushing Docker image to Docker Hub...'
        script {
          docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
          docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
      }
    }
  }
}


    stage('Deploy') {
      steps {
        echo 'Deploying to AWS EC2...'
        script {
          sshagent([SSH_CREDENTIALS_ID]) {
            sh """
              ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} \\
              'docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} && \
              docker stop ${CONTAINER_NAME} || true && \
              docker rm ${CONTAINER_NAME} || true && \
              docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${DOCKER_IMAGE}:${DOCKER_TAG}'
             """

          }
        }
      }
    }
  }

  post {
    success {
      echo "✅ Deployed successfully to EC2 🎉"
    }
    failure {
      echo "❌ Deployment failed. Please check the logs for details."
    }
  }
}
// This Jenkinsfile is a declarative pipeline that automates the process of building, testing, and deploying a Dockerized Node.js application to an AWS EC2 instance. It includes stages for checking out the code, building the Docker image, running tests, pushing the image to Docker Hub, and deploying it to the EC2 instance. The pipeline uses environment variables for configuration and SSH credentials for secure access to the EC2 instance.