pipeline {
    agent any
    environment {
        GIT_REPO_URL = 'https://github.com/siddhaantkadu/devops-pocs.git'
        BRANCH_NAME = 'feature/purpleCube'
        TARGET_SERVER = 'centos@10.128.0.10'
        TARGET_PATH = '/home/centos'
        SSH_CREDENTIALS_ID = 'jenkins-purple-cube'
    }
    stages {
        stage('Clone Git Repository') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: "${env.GIT_REPO_URL}"
            }
        }
        stage('Detect New File') {
            steps {
                script {
                    def filesChanged = sh(script: 'git diff --name-only HEAD~1 HEAD', returnStdout: true).trim()
                    def newFiles = filesChanged.split('\n').findAll { it.endsWith('.json') }
                    if (newFiles) {
                        env.NEW_FILE = newFiles[0]
                    } else {
                        error 'No new JSON file found.'
                    }
                }
            }
        }
        stage('Copy File to Target Server') {
            steps {
                script {
                    sh "scp -o StrictHostKeyChecking=no ${env.NEW_FILE} ${env.TARGET_SERVER}:${env.TARGET_PATH}"
                }
            }
        }
        stage('Execute Script on Target Server') {
            steps {
                sshagent(credentials: ["${env.SSH_CREDENTIALS_ID}"]) {
                    sh "ssh -o StrictHostKeyChecking=no ${env.TARGET_SERVER} 'df -h'"
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
