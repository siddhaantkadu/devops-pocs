pipeline {
    agent {
        label 'MAVEN'
    }

    environment {
        SSH_USER = 'centos' 
        REMOTE_HOST = '10.128.0.10'
    }

    stages {
        stage('InstallAgent-OnRmote') {
            steps {
                script {
                    sshCommnad remote: [host: "${REMOTE_HOST}", port: 22, user: "${SSH_USER}"], command: 'ls -la'
                }

            }
        }
    }
}