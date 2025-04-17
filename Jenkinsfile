pipeline {
  agent any

  environment {
    REMOTE_USER         = 'ubuntu'
    REMOTE_HOST         = '3.91.238.71'      // <-- Replace with your actual public IP or DNS
    TOMCAT_PATH         = '/opt/tomcat/webapps'
    SSH_CREDENTIALS_ID  = 'Lightsail-key-now'
  }

  stages {
    stage('Build WAR') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Deploy WAR to Tomcat') {
      steps {
        withCredentials([file(credentialsId: "${SSH_CREDENTIALS_ID}", variable: 'SSH_KEY')]) {
          sshagent (credentials: ["${SSH_CREDENTIALS_ID}"]) {
            sh '''
              echo "🔐 Starting SSH agent and adding key..."
              eval "$(ssh-agent -s)"
              chmod 600 "$SSH_KEY"
              ssh-add "$SSH_KEY"

              echo "🚀 Copying WAR to remote server..."
              scp -o StrictHostKeyChecking=no -i "$SSH_KEY" target/*.war $REMOTE_USER@$REMOTE_HOST:$TOMCAT_PATH/
            '''
          }
        }
      }
    }

    stage('Restart Tomcat') {
      steps {
        withCredentials([file(credentialsId: "${SSH_CREDENTIALS_ID}", variable: 'SSH_KEY')]) {
          sshagent (credentials: ["${SSH_CREDENTIALS_ID}"]) {
            sh '''
              echo "♻️ Restarting Tomcat remotely..."
              eval "$(ssh-agent -s)"
              chmod 600 "$SSH_KEY"
              ssh-add "$SSH_KEY"

              ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" $REMOTE_USER@$REMOTE_HOST "/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh"
            '''
          }
        }
      }
    }
  }

  post {
    success {
      echo '✅ Deployment completed successfully!'
    }
    failure {
      echo '❌ Deployment failed. Check logs above.'
    }
  }
}
