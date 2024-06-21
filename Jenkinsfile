pipeline {
    agent any
    environment {
        GIT_REPO_URL = 'https://github.com/siddhaantkadu/devops-pocs.git'
        BRANCH_NAME = 'feature/purpleCube'
        TARGET_SERVER = 'centos@10.128.0.10'
        TARGET_PATH = '/home/centos'
        TARGET_HOST_JSON_REPO = 'purple-cube-jsons'
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
                    def filesChanged = sh(script: 'git diff-tree --no-commit-id --name-only -r HEAD', returnStdout: true).trim()
                    def newFiles = filesChanged.split('\n').findAll { it.endsWith('.json') }
                    if (newFiles) {
                        env.NEW_FILE = newFiles[-1] 
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
        stage('Execute Commands on Target Server') {
            steps {
                script {
                    def baseName = sh(script: "basename ${env.NEW_FILE}", returnStdout: true).trim()
                    sshagent(credentials: ["${env.SSH_CREDENTIALS_ID}"]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${env.TARGET_SERVER} '
                                hostname  
                                df -h
                                mkdir -p ${env.TARGET_PATH}/${env.TARGET_HOST_JSON_REPO}
                                mv ${env.TARGET_PATH}/${baseName} ${env.TARGET_PATH}/purple-cube-jsons/${baseName}
                                ls -ltrha ${env.TARGET_PATH}/${env.TARGET_HOST_JSON_REPO}
                            '
                        """
                    }
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
