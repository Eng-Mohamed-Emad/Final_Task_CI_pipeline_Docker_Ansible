pipeline {
    agent any
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
                 
                // Debugging step to check the contents of the workspace
                sh 'ls -l'  // List files to ensure everything is present
                
                // Running the Ansible playbook with Docker credentials passed as environment variables
                sh """
                    chmod 600 ansible-test.pem
                    export ANSIBLE_HOST_KEY_CHECKING=False
                    ansible-playbook -i inventory.ini deploy_playbook.yml
                """
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
















