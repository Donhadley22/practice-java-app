pipeline {
  agent any

  environment {
    REMOTE_USER = 'ubuntu'
    REMOTE_HOST = '3.91.238.71'     // replace with actual IP
    TOMCAT_PATH = '/opt/tomcat/webapps'
  }

  stages {
    stage('Build WAR') {
      steps {
        bat 'mvn clean package'
      }
    }

    stage('Deploy WAR to Tomcat') {
      steps {
        withCredentials([file(credentialsId: 'tomcat-ssh-key', variable: 'SSH_KEY')]) {
          sh '''
            echo "🔐 Setting permissions for key"
            chmod 600 "$SSH_KEY"

            echo "🚀 Deploying WAR to $REMOTE_HOST"
            scp -i "$SSH_KEY" -o StrictHostKeyChecking=no target/*.war $REMOTE_USER@$REMOTE_HOST:$TOMCAT_PATH/
          '''
        }
      }
    }

    stage('Restart Tomcat') {
      steps {
        withCredentials([file(credentialsId: 'tomcat-ssh-key', variable: 'SSH_KEY')]) {
          sh '''
            echo "♻️ Restarting Tomcat on $REMOTE_HOST"
            ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh"
          '''
        }
      }
    }
  }

  post {
    success {
      echo '✅ Deployment completed successfully!'
    }
    failure {
      echo '❌ Deployment failed. Check logs.'
    }
  }
}
