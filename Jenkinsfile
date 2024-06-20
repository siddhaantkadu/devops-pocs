pipeline {
    agent {
        label 'MAVEN'
    }

    stages {
        stage('InstallAgent-OnRmote') {
            steps {
                script {
                    // sshCommnad remote: [host: "${REMOTE_HOST}", port: 22, user: "${SSH_USER}"], command: 'ls -la'

                    def remote = [:]
                    remote.name = 'centos'
                    remote.host = '10.128.0.10'
                    remote.user = 'centos'
                    remote.allowAnyHosts = true
                    stage('Remote SSH') {
                    sshCommand remote: remote, command: "ls -lrt"
                    sshCommand remote: remote, command: "df -h"
                    }
                }
            }
        }
    }
}