pipeline {
    agent {
        label 'MAVEN'
    }

    stages {
        stage('CloneGitRepo') {
            steps {
                    git url: 'https://github.com/siddhaantkadu/devops-pocs.git', 
                    branch: 'main'
            }
        }
        stage('InstallAgent-OnRmote') {
            steps {
                sh'''
                    ansible-playbook -i inventory install-agent.yml
                '''
            }
        }
    }
}