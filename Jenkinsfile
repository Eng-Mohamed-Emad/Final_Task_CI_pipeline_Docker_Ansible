pipeline {
    agent any
    environment {
        DOCKER_USERNAME = credentials('dockerhub')  // Jenkins credential ID for username
        DOCKER_PASSWORD = credentials('dockerhub')  // Jenkins credential ID for password
    }
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Eng-Mohamed-Emad/Final_Task_CI_pipeline_Docker_Ansible.git',
                    credentialsId: 'github-credentials',  // The ID of the added credential
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
}
