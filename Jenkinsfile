pipeline {
  agent any

  environment {
    REMOTE_USER = 'ubuntu'
    REMOTE_HOST = '3.91.238.71'       // Replace with your actual IP
    TOMCAT_PATH = '/opt/tomcat/webapps'         // Tomcat's deployment path
  }

  stages {

    stage('Build WAR') {
      steps {
        bat 'mvn clean package'
      }
    }

    stage('Deploy WAR to Tomcat') {
      steps {
        sshagent(credentials: ['Lightsail-key-now']) {
          bat """
            echo Deploying WAR to Tomcat...
            scp -o StrictHostKeyChecking=no target\\*.war %REMOTE_USER%@%REMOTE_HOST%:%TOMCAT_PATH%
          """
        }
      }
    }

    stage('Restart Tomcat (optional)') {
      steps {
        sshagent(credentials: ['Lightsail-key-now']) {
          bat """
            echo Restarting remote Tomcat server...
            ssh -o StrictHostKeyChecking=no %REMOTE_USER%@%REMOTE_HOST% "/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh"
          """
        }
      }
    }
  }

  post {
    success {
      echo '✅ Deployment completed successfully!'
    }
    failure {
      echo '❌ Deployment failed. Check console logs.'
    }
  }
}
