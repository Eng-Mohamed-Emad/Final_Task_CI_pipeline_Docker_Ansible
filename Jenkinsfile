pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Eng-Mohamed-Emad/Final_Task_CI_pipeline_Docker_Ansible.git',
                    credentialsId: 'github-credentials',
                    branch: 'Ansible-test'
                )
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) {
                    sh """
                        docker build -t mohamedemadeldin101/my-weather-app-image .
                        docker login -u ${myuser} -p ${mypass}
                        docker push mohamedemadeldin101/my-weather-app-image
                    """
                }
            }
        }
        stage('CD') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'mypass', usernameVariable: 'myuser')]) {
                    sh """
                        docker login -u ${myuser} -p ${mypass}
                        docker run -d -p 5000:5000 --name my-app-container mohamedemadeldin101/my-weather-app-image
                    """
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    sh """
                        ansible-playbook -i inventory.ini ansible-playbook.yml
                    """
                }
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
