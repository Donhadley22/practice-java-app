pipeline {
  agent any

  environment {
    REMOTE_USER         = 'ubuntu'
    REMOTE_HOST         = '3.91.238.71'       // Replace this
    TOMCAT_PATH         = '/opt/tomcat/webapps'
    SSH_CREDENTIALS_ID  = 'Lightsail-key-now'
  }

  stages {
    stage('Build WAR') {
      steps {
        bat 'mvn clean package'
      }
    }

    stage('Deploy WAR to Tomcat') {
      steps {
        withCredentials([file(credentialsId: "${SSH_CREDENTIALS_ID}", variable: 'SSH_KEY')]) {
          bat """
            echo Setting up SSH key
            set "PATH=C:\\Program Files\\Git\\usr\\bin;%PATH%"
            echo | set /p dummy="----BEGIN KEY----" && type "%SSH_KEY%"

            echo Deploying WAR to server
            C:\\Windows\\System32\\OpenSSH\\scp.exe -o StrictHostKeyChecking=no -i "%SSH_KEY%" target\\*.war %REMOTE_USER%@%REMOTE_HOST%:%TOMCAT_PATH%
          """
        }
      }
    }

    stage('Restart Tomcat') {
      steps {
        withCredentials([file(credentialsId: "${SSH_CREDENTIALS_ID}", variable: 'SSH_KEY')]) {
          bat """
            echo Restarting Tomcat remotely...
            C:\\Windows\\System32\\OpenSSH\\ssh.exe -o StrictHostKeyChecking=no -i "%SSH_KEY%" %REMOTE_USER%@%REMOTE_HOST% "/opt/tomcat/bin/shutdown.sh && /opt/tomcat/bin/startup.sh"
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
      echo '❌ Deployment failed. Check logs above.'
    }
  }
}
