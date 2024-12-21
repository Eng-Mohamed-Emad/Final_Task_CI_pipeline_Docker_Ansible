pipeline {
    agent any
    environment {
         // withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) 
        GIT_CREDENTIALS = credentials('github-pat')  // Use the Jenkins credentials ID
        DOCKER_HUB_USERNAME = credentials('dockerhub-username')  // Jenkins credentials ID
        DOCKER_HUB_PASSWORD = credentials('dockerhub-password')  // Jenkins credentials ID
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repository with credentials
                git(
                    url: 'https://github.com/Eng-Mohamed-Emad/Final_Task_CI_pipeline_Docker_Ansible',
                    credentialsId: 'github-pat',
                    branch: 'main'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh './docker_build_and_push.sh'
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
