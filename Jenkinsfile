pipeline {
    agent any
    environment {
        // withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) 
        DOCKER_HUB_USERNAME = credentials('dockerhub')  // Jenkins credentials ID for Docker Hub username
        DOCKER_HUB_PASSWORD = credentials('dockerhub')  // Jenkins credentials ID for Docker Hub password
    }
    stages {
        stage('Checkout') {
            steps {
                git'https://github.com/Eng-Mohamed-Emad/Final_Task_CI_pipeline_Docker_Ansible'
                // Checkout the code from the GitHub repository

                checkout scm
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Execute the Docker build and push script
                    sh './docker_build_and_push.sh'
                }
            }
        }
    }
    post {
        always {
            // Clean workspace if needed
            cleanWs()
        }
    }
}
