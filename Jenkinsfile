pipeline {
    agent any
    environment {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')])
    }
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Eng-Mohamed-Emad/Final_Task_CI_pipeline_Docker_Ansible.git',
                    credentialsId: 'github-credentials',
                    branch: 'main'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                sh './docker_build_and_push.sh'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
            cleanWs()
        }
    }
}
